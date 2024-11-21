# *Flutter Mobile Application Development*

## *Table of Contents*
- [*Introduction*](#introduction)
- [*System Requirements*](#system-requirements)
- [*Setting Up the Development Environment*](#setting-up-the-development-environment)
- [*Creating Your First Flutter Application*](#creating-your-first-flutter-application)
---

## *Introduction*

This repository provides a guide for setting up a mobile application development environment in *Flutter*. Flutter is an open-source UI software development kit created by Google for building natively compiled applications for mobile, web, and desktop from a single codebase. This README will walk you through the steps to install Flutter, set up your project, and create your first Flutter application.

---

## *System Requirements*

### *For Windows Users:*
To get started with Flutter development, ensure that your system meets the following minimum requirements:

#### *1. Windows OS:*
- Windows 10 or higher (64-bit)

#### *2. CPU:*
- Intel® Core™ i5 or equivalent processor

#### *3. RAM:*
- 8 GB RAM (16 GB recommended for better performance)

#### *4. Disk Space:*
- At least 4 GB of free disk space for Flutter SDK and Android Studio
- Additional 4 GB for Android Emulator images (optional, if you want to run the emulator)

#### *5. Graphics:*
- OpenGL 2.0 compatible GPU for running the Android Emulator

#### *6. Software Requirements:*
- *Flutter SDK:*
  - Download and install from the official Flutter website:
    [Download Flutter SDK](https://flutter.dev/docs/get-started/install)
  
- *Dart SDK:*
  - Dart SDK is bundled with Flutter. No separate installation is needed.

- *Android Studio (IDE):*
  - Download and install from the official Android Studio website:
    [Download Android Studio](https://developer.android.com/studio)

- *Android SDK:*
  - Included within Android Studio installation.

#### *7. Other Requirements:*
- *Windows 10 SDK and Virtualization Support* (for emulator):
  - Virtualization must be enabled in BIOS settings (for faster emulator performance).

---

## *Setting Up the Development Environment*

Follow these steps to set up Flutter and start developing your mobile app:

### *Step 1: Install Flutter SDK*
1. Download the Flutter SDK from the official Flutter website: [Download Flutter SDK](https://flutter.dev/docs/get-started/install).
2. Extract the .zip file to a desired location on your system.
3. Add the flutter/bin directory to your system’s PATH variable.

### *Step 2: Install Android Studio*
1. Download and install Android Studio from the official website: [Download Android Studio](https://developer.android.com/studio).
2. Launch Android Studio and install the Flutter and Dart plugins:
   - Go to *File > Settings > Plugins > Marketplace* and search for *Flutter* and *Dart* to install them.

### *Step 3: Set Up Android Emulator (Optional)*
1. Open Android Studio and go to *Tools > AVD Manager*.
2. Create a new Virtual Device and select the Android version you want to use.
3. Once the emulator is set up, you can launch it from AVD Manager.

---

## *Creating Your First Flutter Application*

### *Step 1: Create a New Project*
1. Open Android Studio and click *Start a new Flutter project*.
2. Choose *Flutter Application* and configure your project:
   - *Project Name*: Enter the name of your project.
   - *Flutter SDK Path*: Ensure the Flutter SDK is set correctly.
   - *Project Location*: Choose the directory where your project will be saved.

3. Click *Finish* to create the project.

### *Step 2: Modify the lib/main.dart File*
Once your project is created, you can start editing the main.dart file:

- *Location*: lib > main.dart
- Here’s a simple Dart code example for your main.dart:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('My First Flutter App')),
        body: Center(child: Text('Hello, Flutter!')),
      ),
    );
  }
}
