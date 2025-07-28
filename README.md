# LT App - Lineysha & Thevan Software Technologies

A comprehensive cross-platform Flutter application showcasing software development services, products, and career opportunities.

## 🚀 Features

### Core Features
- **Multi-platform Support**: Android, iOS, Web, Windows, macOS, Linux
- **Firebase Integration**: Authentication, Firestore, Storage, Analytics, Crashlytics
- **Push Notifications**: Firebase Cloud Messaging with local notifications
- **Offline Support**: Connectivity monitoring and offline data handling
- **Theme Support**: Light/Dark mode with persistent preferences
- **Profile Management**: User profiles with image upload capability
- **Job Board**: Admin-managed career opportunities with CRUD operations
- **Responsive Design**: Optimized for all screen sizes and orientations

### Authentication & Security
- Email/password authentication
- Role-based access control (Admin/User)
- Secure data storage and transmission
- Privacy policy and terms of service compliance

### User Experience
- Modern, accessible UI design
- Smooth animations and transitions
- Intuitive navigation with bottom navigation bar
- WhatsApp integration for quick contact
- Search and filter functionality
- Error handling with retry mechanisms

## 📱 Screens

1. **Splash Screen**: App initialization and branding
2. **Home**: Company overview, services carousel, hero section
3. **About**: Company information, mission, vision
4. **Products**: Software products catalog with search/filter
5. **Services**: Service offerings with detailed descriptions
6. **Careers**: Job board with admin management
7. **Contact**: Contact information and form
8. **Profile**: User profile management and settings

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd lt_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication, Firestore, Storage, Analytics, and Cloud Messaging
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate directories:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Configure Firebase**
   - Update `lib/firebase_options.dart` with your Firebase configuration
   - Set up Firestore security rules
   - Configure Storage rules for profile images

5. **Platform-specific Setup**

   **Android:**
   - Update `android/app/build.gradle.kts` with your application ID
   - Configure signing for release builds
   - Add necessary permissions in `android/app/src/main/AndroidManifest.xml`

   **iOS:**
   - Update bundle identifier in Xcode
   - Configure signing and capabilities
   - Add required permissions in `ios/Runner/Info.plist`

6. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the root directory:
```env
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
```

### Firebase Security Rules

**Firestore Rules:**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own profile
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Jobs: public read, admin write
    match /jobs/{jobId} {
      allow read: if true;
      allow write: if request.auth != null && 
        get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';
    }
  }
}
```

**Storage Rules:**
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /profile_images/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

### Integration Tests
```bash
flutter test integration_test/app_test.dart
```

## 📦 Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🚀 Deployment

### Google Play Store
1. Build app bundle: `flutter build appbundle --release`
2. Upload to Google Play Console
3. Configure store listing with screenshots and descriptions
4. Submit for review

### Apple App Store
1. Build iOS app: `flutter build ios --release`
2. Archive in Xcode
3. Upload to App Store Connect
4. Configure app metadata and screenshots
5. Submit for review

### Web Deployment
1. Build web app: `flutter build web --release`
2. Deploy to hosting service (Firebase Hosting, Netlify, etc.)

## 📊 Analytics & Monitoring

The app includes comprehensive analytics and monitoring:
- **Firebase Analytics**: User behavior and app performance
- **Crashlytics**: Crash reporting and monitoring
- **Custom Events**: Job applications, contact form submissions
- **Error Tracking**: Centralized error handling and reporting

## 🔐 Security Features

- Secure authentication with Firebase Auth
- Role-based access control
- Data encryption in transit and at rest
- Input validation and sanitization
- Secure file upload with validation

## 📱 Permissions

The app requests the following permissions:
- **Camera**: Profile picture capture
- **Storage**: File upload and download
- **Notifications**: Push notifications
- **Internet**: Network connectivity

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is proprietary software owned by Lineysha & Thevan Software Technologies.

## 📞 Support

For support and questions:
- **Email**: contact@lineyshathevan.com
- **Phone**: +91 8247252626
- **Website**: https://lineyshathevan.com

## 🔄 Version History

- **v1.0.0**: Initial release with core features
- Complete Firebase integration
- Multi-platform support
- Admin job board management
- User authentication and profiles

---

**Developed by Lineysha & Thevan Software Technologies**
*Pioneering Innovation in Technology*
