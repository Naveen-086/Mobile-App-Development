Mobile Application Development in Android Studio (Java)
Table of Contents
Introduction
System Requirements
Setting Up the Development Environment
Creating Your First Android Application
Building and Running the Application
Troubleshooting
Introduction
This repository provides a guide for setting up a mobile application development environment in Android Studio using Java. Android Studio is the official IDE for Android development, and it supports the development of Android apps using Java (and Kotlin). This README will walk you through the process of installing Android Studio, setting up your project, and creating your first Android application.

System Requirements
For Windows Users:
To get started with Android development, ensure that your system meets the following minimum requirements:

1. Windows OS:
Windows 10 or higher (64-bit)
2. CPU:
Intel® Core™ i5 or equivalent processor
Minimum of 2 cores
3. RAM:
8 GB RAM (16 GB recommended for better performance)
4. Disk Space:
At least 4 GB of free disk space for Android Studio and SDK
Additional 4 GB for Android Emulator images (optional, if you want to run the emulator)
5. Graphics:
OpenGL 2.0 compatible GPU for running the Android Emulator
6. Software Requirements:
Java Development Kit (JDK):

Android Studio comes bundled with JDK, so no separate installation is required.
Android Studio (IDE):

Download and install from the official Android Studio website: Download Android Studio
Android SDK:

Included within Android Studio installation.
7. Other Requirements:
Windows 10 SDK and Virtualization Support (for emulator):
Virtualization must be enabled in BIOS settings (for faster emulator performance).
Setting Up the Development Environment
Follow these steps to set up Android Studio and start developing your Android app:

Step 1: Install Android Studio
Download the installer from the official Android Studio website: Download Android Studio.
Run the downloaded .exe file and follow the setup wizard to install Android Studio.
During installation, ensure that Android SDK and Android Virtual Device (AVD) are selected.
Step 2: Set Up Android SDK
Open Android Studio and click on "Configure" (or directly "SDK Manager" from the welcome screen).
In the SDK Manager, ensure that the following components are installed:
Android SDK
Android SDK Build-Tools
Android Emulator
Platform SDKs (for the latest Android version)
Click Apply to install any missing components.
Step 3: Install Java Development Kit (JDK)
Android Studio typically includes a bundled version of JDK. However, if you want to use a different version of JDK:
Download JDK from Oracle’s official website: Download JDK.
Configure JDK in Android Studio (if necessary) via File > Project Structure > SDK Location > JDK location.
Step 4: Set Up Android Emulator (Optional)
To test your applications without a physical device, you can use the Android Emulator:

Open Android Studio and go to Tools > AVD Manager.
Click on Create Virtual Device and follow the steps to set up a virtual device (select a device model and system image).
Once created, you can start the emulator from the AVD Manager.
Creating Your First Android Application
Once the environment is set up, you're ready to create a new Android project. Follow these steps to create your first application:

Step 1: Create a New Project
Open Android Studio and select Start a new Android Studio project.

Choose a project template:

For a simple app, select Empty Activity.
Configure your app:

Name: Enter the name of your application.
Package name: This will be the unique identifier for your app (e.g., com.example.myapp).
Save location: Choose the directory where your project will be saved.
Language: Select Java.
Minimum API level: Select the minimum Android version you want to support.
Click Finish to create the project.

Step 2: Modify the MainActivity.java File
Once your project is created, you can start editing the MainActivity.java file:

Location: app > src > main > java > com.example.yourappname > MainActivity.java
Here's a simple Java code example for your MainActivity.java:
java
Copy code
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
Step 3: Modify the activity_main.xml Layout
Location: app > src > main > res > layout > activity_main.xml
Here's an example of a simple XML layout with a Button:
xml
Copy code
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <Button
        android:id="@+id/button"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Click Me"
        android:layout_centerInParent="true" />
</RelativeLayout>
Building and Running the Application
Step 1: Build the Application
In Android Studio, click Build > Make Project to compile the project.
If there are no errors, the build will complete successfully.
Step 2: Run the Application
Click on the Run button (green triangle) in Android Studio.
Select a physical device (connected via USB) or a virtual device (emulator).
Android Studio will install the app on the selected device and launch it.
Troubleshooting
If you encounter issues during setup or development, consider the following troubleshooting tips:

Issue: Emulator not starting
Ensure that hardware acceleration is enabled in your BIOS settings.
Check that you have enough system resources (RAM, disk space).
Issue: App crashes on launch
Check the Logcat in Android Studio for error messages.
Verify that you have set up the required permissions in the AndroidManifest.xml.
