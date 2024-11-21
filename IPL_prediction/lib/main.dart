import 'package:flutter/material.dart';
import 'prediction_screen.dart';
import 'signin_page.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPL prediction',
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => const SignInPage(),
        '/login': (context) => const LoginPage(),
        '/prediction': (context) => const PredictionScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
