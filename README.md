
# IQChannels Flutter Plugin

This is a Flutter plugin for integrating IQChannels chat SDK into your Flutter app.

It provides Android and iOS platform implementations to configure, authenticate, and open the chat UI.

---

## ✨ Features

✅ Configure IQChannels SDK

✅ Login / Logout user

✅ Login anonymously

✅ Open chat UI

✅ Set push notification token

---

## 🛠 Installation

Add the plugin to your `pubspec.yaml`:

```yaml
dependencies:
  iqchannels:
    git:
      url: https://github.com/ShahzodAtabayev/iqchannels-flutter.git
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Android Configuration

### 1️⃣ Add GitHub Maven repository to your project

In your **android/build.gradle** (or **settings.gradle.kts** if Kotlin DSL), add:

```gradle
allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            name = "GitHubPackages"
            url = uri("https://maven.pkg.github.com/iqstore/iqchannels-kotlin")
            credentials(PasswordCredentials) {
                username = project.findProperty("gpr.user") ?: System.getenv("GPR_USER")
                password = project.findProperty("gpr.key") ?: System.getenv("GPR_API_KEY")
            }
        }
    }
}
```

Also, create (or update) a `local.properties` file with your GitHub credentials:

```properties
gpr.user=YOUR_GITHUB_USERNAME
gpr.key=YOUR_GITHUB_PERSONAL_ACCESS_TOKEN
```

✅ Make sure your token has **read:packages** scope.

---

### 2️⃣ Update app-level `build.gradle`:

Ensure AndroidX is enabled:

```gradle
android {
    compileSdkVersion 34
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
    buildFeatures {
        viewBinding true
    }
}
```

✅ **IMPORTANT:** IQChannels SDK uses AndroidX and requires `android.useAndroidX=true` in `gradle.properties`.

Add:

```properties
android.useAndroidX=true
android.enableJetifier=true
```

---

## 🍏 iOS Configuration

### 1️⃣ Add dependency to **example/ios/Podfile**:

Add IQChannelsSwift pod to the `Runner` target:

```ruby
target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods(File.dirname(File.realpath(__FILE__)))

  pod 'IQChannelsSwift', :git => 'https://github.com/iqstore/iqchannels-swift.git', :tag => '2.1.10'
end
```

Then install pods:

```bash
cd example/ios
pod install
```

✅ Note: IQChannelsSwift **requires iOS 14.0 or higher**, so set platform version:

```ruby
platform :ios, '14.0'
```

---

### 2️⃣ Add permissions to `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>This app requires camera access for chat attachments</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app requires photo library access for chat attachments</string>
```

---

## 📦 Using the Plugin

Import the plugin:

```dart
import 'package:iqchannels/iqchannels.dart';
```

Initialize:

```dart
final _iqchannels = IQChannels();

await _iqchannels.configure(
  address: 'https://your-iqchannels-server.com',
  channel: 'your-channel',
);
```

Login:

```dart
await _iqchannels.login('your-user-token');
```

Anonymous login:

```dart
await _iqchannels.loginAnonymous();
```

Open chat:

```dart
await _iqchannels.openChat();
```

Logout:

```dart
await _iqchannels.logout();
```

Set push token:

```dart
await _iqchannels.setPushToken('device_push_token', isHuawei: false);
```

---

## 🏃 Example App

Run the example app:

```bash
cd example
flutter run
```

---

## ⚠️ Notes

✅ iOS build requires Xcode 14+ and deployment target iOS 14.0+  
✅ Android requires minSdkVersion 21+ and AndroidX enabled.

---

## 📄 License

MIT License — see [LICENSE](LICENSE) file.

---

## 💬 Support

For integration issues or bug reports, open an issue on GitHub.

---

Happy coding! 🚀
