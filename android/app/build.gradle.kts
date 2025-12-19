import java.util.Properties
import java.io.FileInputStream
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
keystoreProperties.load(FileInputStream(keystorePropertiesFile))

android {
    namespace = "com.futuredragon.app"
    compileSdk = 36
    ndkVersion = "29.0.14206865"

    compileOptions {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

    kotlinOptions {
        jvmTarget = "17" 
    }

    defaultConfig {
        multiDexEnabled = true
        manifestPlaceholders["appAuthRedirectScheme"] = "com.futuredragon.app"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            signingConfig = signingConfigs.getByName("release")
        }
    }
    compileSdkMinor = 1
}
tasks.withType<JavaCompile> {
    options.compilerArgs.add("-Xlint:deprecation")
}

flutter {
    source = "../.."
}

dependencies {
     implementation(platform("com.google.firebase:firebase-bom:34.7.0"))
     implementation("com.google.android.gms:play-services-ads")
     implementation("com.google.firebase:firebase-analytics")
     implementation("com.google.firebase:firebase-auth")
     implementation("com.google.firebase:firebase-firestore")
     implementation("com.google.firebase:firebase-messaging")
}
