import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// Membaca local.properties
val localPropertiesFile = rootProject.file("local.properties")
val localProperties = Properties()
if (localPropertiesFile.exists()) {
    localProperties.load(localPropertiesFile.inputStream())
}

// Konfigurasi versi
val flutterVersionCode = localProperties.getProperty("flutter.versionCode", "1").toInt()
val flutterVersionName = localProperties.getProperty("flutter.versionName", "1.0.0")
val compileSdkVersion = localProperties.getProperty("flutter.compileSdkVersion", "34").toInt()
val minSdkVersion = localProperties.getProperty("flutter.minSdkVersion", "21").toInt()
val targetSdkVersion = localProperties.getProperty("flutter.targetSdkVersion", "34").toInt()

android {
    namespace = "com.example.apac_application"
    compileSdk = flutter.compileSdkVersion.toInt()
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.apac_application"
        minSdk = minSdkVersion
        targetSdk = targetSdkVersion
        versionCode = flutterVersionCode
        versionName = flutterVersionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))
    implementation("com.google.firebase:firebase-analytics")
}