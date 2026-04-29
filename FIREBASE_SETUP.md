# Firebase Setup untuk Holydays App

## ✅ Setup yang Sudah Dilakukan

1. **Dependencies Added** - Firebase Core & Auth sudah di pubspec.yaml
2. **Authentication Service** - `lib/services/auth_service.dart` untuk handle login/register
3. **Firebase Initialization** - main.dart sudah di-update untuk initialize Firebase
4. **Login Integration** - login_screen.dart sudah connect ke Firebase
5. **Register Integration** - register_screen.dart sudah connect ke Firebase
6. **Auth State Check** - splash_screen.dart check user login status

---

## 📋 Langkah-Langkah yang Perlu Anda Lakukan

### **1. Setup Firebase Console**

1. Buka [Firebase Console](https://console.firebase.google.com/)
2. Buat project baru atau gunakan existing project
3. Aktifkan **Authentication**:
   - Pergi ke Authentication > Sign-in method
   - Enable "Email/Password" provider
   - Enable "Email link sign-in" (opsional)

### **2. Tambahkan App di Firebase**

#### **Untuk Android:**
- Klik "+ Add App" → Pilih Android
- Bundle ID: `com.example.holydays` (atau sesuaikan dengan package name Anda)
- Download file `google-services.json`
- Letakkan di folder: `android/app/`

#### **Untuk iOS:**
- Klik "+ Add App" → Pilih iOS
- Bundle ID: `com.example.holydays` (atau sesuaikan)
- Download file `GoogleService-Info.plist`
- Letakkan di folder: `ios/Runner/` dan add ke Xcode

#### **Untuk Web (jika diperlukan):**
- Klik "+ Add App" → Pilih Web
- Copy config yang diberikan

### **3. Update `firebase_options.dart`**

File `lib/firebase_options.dart` sudah dibuat, tapi Anda perlu update dengan credentials dari Firebase Console:

**Untuk Android & iOS:**
- Buka file `google-services.json` atau `GoogleService-Info.plist`
- Copy values ini ke `firebase_options.dart`:
  - `apiKey`
  - `appId`
  - `messagingSenderId`
  - `projectId`
  - `storageBucket`

**Contoh:**
```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', // Dari google-services.json
  appId: '1:123456789:android:abcdefghijklmnop',
  messagingSenderId: '123456789',
  projectId: 'your-project-id',
  storageBucket: 'your-project-id.appspot.com',
);
```

### **4. Android Configuration**

Update `android/app/build.gradle.kts`:

```kotlin
plugins {
    id 'com.android.application'
    id 'kotlin-android'
    id 'dev.flutter.flutter-gradle-plugin'
    id 'com.google.gms.google-services'  // ← Tambahkan ini
}
```

### **5. iOS Configuration**

Update `ios/Podfile` - uncomment atau pastikan deployment target:

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_ios_post_install(target)
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'PERMISSION_LOCATION=1',
      ]
    end
  end
end
```

---

## 🧪 Testing Authentication

### **Test Login:**
1. Run app: `flutter run`
2. Tampilannya: Splash Screen → Login Screen
3. Gunakan akun yang sudah terdaftar di Firebase:
   - Email: `test@example.com`
   - Password: `password123`

### **Test Register:**
1. Dari Login Screen, klik "Create account"
2. Isi form dengan data baru
3. Klik "Create Account"
4. System akan auto-create user di Firebase

---

## 🔧 Troubleshooting

### **Error: MissingPluginException**
- Jalankan: `flutter pub get`
- Clean build: `flutter clean && flutter pub get`
- Rebuild app: `flutter run`

### **Error: PlatformException(PlatformException)**
- Pastikan `google-services.json` sudah di `android/app/`
- Pastikan `GoogleService-Info.plist` sudah di `ios/Runner/` (Xcode)

### **Aplikasi Crash saat Login**
- Check di firebase_options.dart - pastikan credentials benar
- Cek Internet connection
- Lihat logs: `flutter logs`

---

## 📁 File Structure Setelah Setup

```
holydays/
├── lib/
│   ├── main.dart (✅ Updated)
│   ├── firebase_options.dart (✅ Created - perlu credentials)
│   ├── services/
│   │   └── auth_service.dart (✅ Created)
│   ├── screens/
│   │   ├── login_screen.dart (✅ Updated)
│   │   ├── register_screen.dart (✅ Updated)
│   │   └── splash_screen.dart (✅ Updated)
│   └── ...
├── android/
│   ├── app/
│   │   ├── google-services.json (⚠️ Perlu download dari Firebase)
│   │   └── build.gradle.kts (⚠️ Perlu add google-services plugin)
│   └── ...
├── ios/
│   ├── Runner/
│   │   ├── GoogleService-Info.plist (⚠️ Perlu download dari Firebase)
│   │   └── ...
│   └── ...
└── pubspec.yaml (✅ Updated)
```

---

## ✨ Features yang Sudah Siap

✅ Email/Password Registration
✅ Email/Password Login
✅ Auto-redirect ke Home jika sudah login
✅ Error handling dengan user-friendly messages
✅ Loading state saat auth process
✅ Password validation (min 6 chars, confirm password)
✅ Input validation
✅ Session persistence (auto login jika restart app)

---

## 🚀 Next Steps (Optional)

- [ ] Add "Forgot Password" feature
- [ ] Add Google Sign-In
- [ ] Add user profile storage (Firestore)
- [ ] Add email verification
- [ ] Add logout button di profile screen

---

**Status: 95% Ready - Hanya perlu setup Firebase Console & update credentials!** 🎉
