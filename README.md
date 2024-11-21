# Mobile Application Development in Android Studio (Java)

## Table of Contents
- [*Introduction*](#introduction)
- [*System Requirements*](#system-requirements)
- [*Setting Up the Development Environment*](#setting-up-the-development-environment)
- [*Creating Your First Android Application*](#creating-your-first-android-application)
---

## *Introduction*

This repository provides a guide for setting up a mobile application development environment in *Android Studio* using *Java*. Android Studio is the official IDE for Android development, and it supports the development of Android apps using Java (and Kotlin). This README will walk you through the process of installing Android Studio, setting up your project, and creating your first Android application.

---

## *System Requirements*

### *For Windows Users:*
To get started with Android development, ensure that your system meets the following minimum requirements:

#### *1. Windows OS:*
- Windows 10 or higher (64-bit)

#### *2. CPU:*
- Intel® Core™ i5 or equivalent processor
- Minimum of 2 cores

#### *3. RAM:*
- 8 GB RAM (16 GB recommended for better performance)

#### *4. Disk Space:*
- At least 4 GB of free disk space for Android Studio and SDK
- Additional 4 GB for Android Emulator images (optional, if you want to run the emulator)

#### *5. Graphics:*
- OpenGL 2.0 compatible GPU for running the Android Emulator

#### *6. Software Requirements:*
- *Java Development Kit (JDK):*
  - Android Studio comes bundled with JDK, so no separate installation is required.
  
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

Follow these steps to set up Android Studio and start developing your Android app:

### *Step 1: Install Android Studio*
1. Download the installer from the official Android Studio website: [Download Android Studio](https://developer.android.com/studio).
2. Run the downloaded .exe file and follow the setup wizard to install Android Studio.
3. During installation, ensure that *Android SDK* and *Android Virtual Device (AVD)* are selected.

### *Step 2: Set Up Android SDK*
1. Open Android Studio and click on *"Configure"* (or directly *"SDK Manager"* from the welcome screen).
2. In the SDK Manager, ensure that the following components are installed:
   - Android SDK
   - Android SDK Build-Tools
   - Android Emulator
   - Platform SDKs (for the latest Android version)
3. Click *Apply* to install any missing components.

### *Step 3: Install Java Development Kit (JDK)*
- Android Studio typically includes a bundled version of JDK. However, if you want to use a different version of JDK:
  1. Download JDK from Oracle’s official website: [Download JDK](https://www.oracle.com/java/technologies/javase-jdk16-downloads.html).
  2. Configure JDK in Android Studio (if necessary) via *File > Project Structure > SDK Location > JDK location*.

### *Step 4: Set Up Android Emulator (Optional)*
To test your applications without a physical device, you can use the Android Emulator:
1. Open Android Studio and go to *Tools > AVD Manager*.
2. Click on *Create Virtual Device* and follow the steps to set up a virtual device (select a device model and system image).
3. Once created, you can start the emulator from the AVD Manager.

---

## *Creating Your First Android Application*

Once the environment is set up, you're ready to create a new Android project. Follow these steps to create your first application:

### *Step 1: Create a New Project*
1. Open Android Studio and select *Start a new Android Studio project*.
2. Choose a project template:
   - For a simple app, select *Empty Activity*.
3. Configure your app:
   - *Name*: Enter the name of your application.
   - *Package name*: This will be the unique identifier for your app (e.g., com.example.myapp).
   - *Save location*: Choose the directory where your project will be saved.
   - *Language: Select **Java*.
   - *Minimum API level*: Select the minimum Android version you want to support.

4. Click *Finish* to create the project.

### *Step 2: Modify the MainActivity.java File*
Once your project is created, you can start editing the MainActivity.java file:

- *Location*: app > src > main > java > com.example.yourappname > MainActivity.java
- Here's a simple Java code example for your MainActivity.java:

```java
package com.example.myfirstapp;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Button action
        Button button = findViewById(R.id.button);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Show a toast message
                Toast.makeText(MainActivity.this, "Button Clicked!", Toast.LENGTH_SHORT).show();
            }
        });
    }
}
