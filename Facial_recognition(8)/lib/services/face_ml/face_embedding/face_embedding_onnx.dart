import 'dart:math' as math show max, min, sqrt;
import 'dart:typed_data' show Float32List;

import 'package:computer/computer.dart';
import 'package:flutter/services.dart';
import 'package:flutterface/services/face_ml/face_detection/detection.dart';
import 'package:flutterface/utils/image_ml_isolate.dart';
import 'package:logging/logging.dart';
import 'package:onnxruntime/onnxruntime.dart';

class FaceEmbeddingOnnx {
  static const String kModelPath = 'assets/models/mobilefacenet_opset15.onnx';

  static const int kInputSize = 112;
  static const int kEmbeddingSize = 192;

  final _logger = Logger('FaceEmbeddingOnnx');

  bool _isInitialized = false;
  int _sessionAddress = 0;

  final _computer = Computer.shared();

  // singleton pattern
  FaceEmbeddingOnnx._privateConstructor();

  /// Use this instance to access the FaceEmbedding service. Make sure to call `init()` before using it.
  /// e.g. `await FaceEmbedding.instance.init();`
  ///
  /// Then you can use `predict()` to get the embedding of a face, so `FaceEmbedding.instance.predict(imageData)`
  ///
  /// config options: faceEmbeddingEnte
  static final instance = FaceEmbeddingOnnx._privateConstructor();
  factory FaceEmbeddingOnnx() => instance;

  /// Check if the interpreter is initialized, if not initialize it with `loadModel()`
  Future<void> init() async {
    if (!_isInitialized) {
      _sessionAddress = await _loadModel({'modelPath': kModelPath});
      if (_sessionAddress != -1) {
        _isInitialized = true;
      }
    }
  }

  Future<void> dispose() async {
    if (_isInitialized) {
      await _computer
          .compute(releaseModel, param: {'address': _sessionAddress});
      _isInitialized = false;
      _sessionAddress = 0;
    }
  }

  Future<int> _loadModel(Map args) async {
    final sessionOptions = OrtSessionOptions()
      ..setInterOpNumThreads(1)
      ..setIntraOpNumThreads(1)
      ..setSessionGraphOptimizationLevel(GraphOptimizationLevel.ortEnableAll);
    try {
      OrtEnv.instance.init();
      _logger.info('Loading face embedding model');
      final rawAssetFile = await rootBundle.load(args['modelPath'] as String);
      final modelBytes = rawAssetFile.buffer.asUint8List();
      final session = OrtSession.fromBuffer(modelBytes, sessionOptions);
      _logger.info('Face embedding model loaded');
      return session.address;
    } catch (e, s) {
      _logger.severe('Face embedding model not loaded', e, s);
    }
    return -1;
  }

  static Future<void> releaseModel(Map args) async {
    final address = args['address'] as int;
    if (address == 0) {
      return;
    }
    final session = OrtSession.fromAddress(address);
    session.release();
    OrtEnv.instance.release();
    return;
  }

  Future<(List<double>, bool, double)> predict(
    Uint8List imageData,
    FaceDetectionRelative face,
  ) async {
    assert(_sessionAddress != 0 && _sessionAddress != -1 && _isInitialized);

    try {
      final stopwatchDecoding = Stopwatch()..start();
      final (inputImageList, alignmentResults, isBlur, blurValue) =
          await ImageMlIsolate.instance.preprocessMobileFaceNetOnnx(
        imageData,
        [face],
      );
      stopwatchDecoding.stop();
      _logger.info(
        'MobileFaceNet image decoding and preprocessing is finished, in ${stopwatchDecoding.elapsedMilliseconds}ms',
      );

      final stopwatch = Stopwatch()..start();
      _logger.info('MobileFaceNet interpreter.run is called');
      final embedding = await _computer.compute(
        infer,
        param: {
          'input': inputImageList,
          'address': _sessionAddress,
          'inputSize': kInputSize,
        },
        taskName: 'createFaceEmbedding',
      ) as List<double>;
      stopwatch.stop();
      _logger.info(
        'MobileFaceNet interpreter.run is finished, in ${stopwatch.elapsedMilliseconds}ms',
      );

      _logger.info(
        'MobileFaceNet results (only first few numbers): embedding ${embedding.sublist(0, 5)}',
      );
      _logger.info(
        'Mean of embedding: ${embedding.reduce((a, b) => a + b) / embedding.length}',
      );
      _logger.info(
        'Max of embedding: ${embedding.reduce(math.max)}',
      );
      _logger.info(
        'Min of embedding: ${embedding.reduce(math.min)}',
      );

      return (embedding, isBlur[0], blurValue[0]);
    } catch (e) {
      _logger.info('MobileFaceNet Error while running inference: $e');
      rethrow;
    }
  }

  static Future<List<double>> infer(Map args) async {
    final inputImageList = args['input'] as Float32List;
    final address = args['address'] as int;
    final inputSize = args['inputSize'] as int;
    final runOptions = OrtRunOptions();
    final int numberOfFaces =
        inputImageList.length ~/ (inputSize * inputSize * 3);
    final inputOrt = OrtValueTensor.createTensorWithDataList(
      inputImageList,
      [numberOfFaces, inputSize, inputSize, 3],
    );
    final inputs = {'img_inputs': inputOrt};
    final session = OrtSession.fromAddress(address);
    final outputs = session.run(runOptions, inputs);
    final embedding = (outputs[0]?.value as List<List<double>>)[0];

    double normalization = 0;
    for (int i = 0; i < kEmbeddingSize; i++) {
      normalization += embedding[i] * embedding[i];
    }
    final double sqrtNormalization = math.sqrt(normalization);
    for (int i = 0; i < kEmbeddingSize; i++) {
      embedding[i] = embedding[i] / sqrtNormalization;
    }
    return (embedding);
  }
}
