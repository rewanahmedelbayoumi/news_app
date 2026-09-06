# 📰 News App

A modern, multilingual Flutter news application designed to provide users with a clean, simple, and engaging way to browse, read, search, and save news articles.

The application combines a responsive Flutter user interface with Firebase Authentication and Cloud Firestore to provide user accounts and cloud-based saved news functionality.

---

## 📌 Table of Contents

* [Project Overview](#-project-overview)
* [Project Goals](#-project-goals)
* [Key Features](#-key-features)
* [Application Screens](#-application-screens)
* [User Flow](#-user-flow)
* [Authentication](#-authentication)
* [Firebase Integration](#-firebase-integration)
* [Firestore Database Structure](#-firestore-database-structure)
* [Firestore Security Rules](#-firestore-security-rules)
* [Saved News System](#-saved-news-system)
* [Search](#-search)
* [Dark Mode](#-dark-mode)
* [Multilingual Support](#-multilingual-support)
* [Remember Me](#-remember-me)
* [Onboarding](#-onboarding)
* [Project Architecture](#-project-architecture)
* [Project Structure](#-project-structure)
* [Screens](#-screens)
* [Widgets](#-widgets)
* [Models](#-models)
* [Services](#-services)
* [News Data](#-news-data)
* [Assets](#-assets)
* [Technologies Used](#-technologies-used)
* [Dependencies](#-dependencies)
* [Installation](#-installation)
* [Firebase Configuration](#-firebase-configuration)
* [Running the Application](#-running-the-application)
* [Testing](#-testing)
* [Building the APK](#-building-the-apk)
* [Error Handling](#-error-handling)
* [Security](#-security)
* [Future Improvements](#-future-improvements)
* [Screenshots](#-screenshots)
* [Conclusion](#-conclusion)

---

# 📱 Project Overview

**News App** is a Flutter-based mobile application created to provide a centralized platform for browsing news content through a clean and user-friendly interface.

The application allows users to:

* Browse news articles.
* View featured news.
* Explore the latest news.
* Filter news by category.
* Search through available articles.
* Open and read individual articles.
* Save articles for later.
* Create an account.
* Log in securely.
* Reset a forgotten password.
* Edit profile information.
* Switch between light and dark themes.
* Change the application language.
* Use the application in multiple languages.
* Use the application as a guest.
* Keep saved news synchronized with their Firebase account.

The project was developed using **Flutter** and **Dart**, with **Firebase** used for authentication and cloud data storage.

---

# 🎯 Project Goals

The main goals of the project are:

1. Create a modern mobile news-reading experience.
2. Provide simple and intuitive navigation.
3. Allow users to discover news quickly.
4. Provide category-based news organization.
5. Allow users to save interesting articles.
6. Store user-related data securely in Firebase.
7. Support multiple languages.
8. Support both light and dark themes.
9. Provide a guest experience without forcing users to register immediately.
10. Maintain a modular and organized Flutter project structure.

---

# ✨ Key Features

## 📰 News Feed

The home screen displays the available news articles in an organized layout.

Each article contains:

* Category
* Title
* Description
* Publication time
* Image
* Save/bookmark action

---

## ⭐ Featured News

The application includes a dedicated featured-news section that highlights the main article.

The featured article can be opened to view its complete details.

---

## 🗂️ News Categories

News articles are organized into categories such as:

* Technology
* Business
* Sports
* Health
* News

Category filtering allows users to quickly focus on a specific type of content.

---

## 🔍 Search

The application provides an integrated search experience.

Users can search through available news based on:

* Article title
* Article description
* Article category

The search interface dynamically filters the available news content.

---

## 🔖 Save News

Authenticated users can save articles for later.

When an article is saved:

1. The article is added to the user's saved-news collection.
2. The article becomes available in the Saved screen.
3. The saved article is associated with the authenticated user's Firebase UID.

Users can also remove saved articles.

---

## 👤 User Accounts

Users can create an account using:

* Full name
* Email address
* Password
* Password confirmation

After registration, the user is taken through the onboarding experience.

---

## 🔐 Login

Existing users can log in using:

* Email
* Password

The application validates authentication through Firebase Authentication.

---

## 🔑 Forgot Password

Users who forget their password can request a password-reset email.

The application uses Firebase Authentication's password-reset functionality.

---

## 🌙 Dark Mode

The application supports both:

* Light Mode
* Dark Mode

The selected theme is stored locally using `SharedPreferences`.

This means the user's theme preference remains available after restarting the application.

---

## 🌍 Multilingual Support

The application supports seven languages:

| Language | Code |
| -------- | ---- |
| English  | `en` |
| Arabic   | `ar` |
| Spanish  | `es` |
| French   | `fr` |
| German   | `de` |
| Japanese | `ja` |
| Chinese  | `zh` |

The language selection is stored locally so the selected language can be restored when the application starts.

---

## 🧠 Remember Me

The login system includes a **Remember Me** option.

When enabled:

* The user's email can be remembered locally.
* The user's session preference is stored locally.
* The application can keep the user logged in between launches.

When disabled, the application clears the remembered-login preference and signs the user out during session initialization.

Passwords are **never stored locally** by the application.

---

# 👥 Guest Experience

The application does not require users to immediately create an account.

Guests can browse the available news.

Protected functionality such as:

* Saved News
* Profile

requires authentication.

When a guest attempts to access protected functionality, the application provides options to:

* Log In
* Register

This creates a smoother user experience while still protecting user-specific data.

---

# 🔐 Authentication

Firebase Authentication is used to manage user accounts.

The authentication system supports:

### Registration

Users provide:

```text
Name
Email
Password
Confirm Password
```

The application validates the form before sending the registration request.

Validation includes:

* Required fields
* Minimum password length
* Password confirmation matching

---

### Login

Firebase Authentication verifies the supplied email and password.

Authentication errors are converted into user-friendly messages.

---

### Password Reset

Firebase Authentication sends a password-reset email to the user's registered email address.

---

### Logout

When the user logs out:

* Firebase Authentication signs the user out.
* The local Remember Me preference is cleared.
* The local user information is cleared.

---

# 🔥 Firebase Integration

The project uses Firebase as the backend service.

Firebase is initialized when the application starts.

The project uses:

* Firebase Core
* Firebase Authentication
* Cloud Firestore
* Firebase Cloud Messaging dependency

Firebase configuration is generated using the FlutterFire CLI.

The Firebase project used by the application is:

```text
news-app-rewan
```

---

# ☁️ Firestore Database Structure

User profile information is stored in Firestore.

The structure is:

```text
users
│
└── USER_UID
    │
    ├── uid
    ├── name
    ├── email
    ├── createdAt
    └── updatedAt
    │
    └── saved_news
        │
        ├── NEWS_DOCUMENT
        ├── NEWS_DOCUMENT
        └── NEWS_DOCUMENT
```

---

## 👤 User Document

Each authenticated user has a document inside:

```text
users/{userId}
```

Example:

```text
users
└── abc123
    ├── uid: abc123
    ├── name: User Name
    ├── email: user@email.com
    ├── createdAt: Timestamp
    └── updatedAt: Timestamp
```

---

## 🔖 Saved News Collection

Saved articles are stored inside:

```text
users/{userId}/saved_news
```

Each saved article contains:

```text
category
title
description
time
image
savedAt
```

This ensures saved articles belong to the authenticated user.

---

# 🔒 Firestore Security Rules

The Firestore rules ensure that users can only access their own data.

Current rules:

```text
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {

    match /users/{userId} {
      allow read, write: if request.auth != null
                         && request.auth.uid == userId;

      match /saved_news/{newsId} {
        allow read, write: if request.auth != null
                           && request.auth.uid == userId;
      }
    }
  }
}
```

### Security behavior

A user can:

* Read their own profile.
* Update their own profile.
* Read their own saved articles.
* Add saved articles.
* Delete saved articles.

A user cannot access another user's protected documents through these rules.

---

# 🔖 Saved News System

Saved news is managed through:

```text
services/saved_news_service.dart
```

The service communicates with Cloud Firestore.

When a user saves an article:

```text
Firebase Authentication
        ↓
Current User UID
        ↓
Firestore
        ↓
users/{UID}/saved_news
```

When an article is removed, the corresponding Firestore document is deleted.

This allows saved articles to persist between application sessions.

---

# 🔎 Search System

The application contains a local search system based on the existing `NewsData`.

Search can match:

```text
Title
Description
Category
```

This allows users to quickly locate relevant articles without manually browsing the entire news list.

---

# 🌙 Dark Mode

Theme management is handled by:

```text
services/theme_service.dart
```

The service uses:

```text
SharedPreferences
```

to store the user's theme preference.

The application supports:

```text
ThemeMode.light
ThemeMode.dark
```

The selected theme affects the entire application.

---

# 🌍 Multilingual Support

Language management is handled by:

```text
services/language_service.dart
```

The application supports:

```text
English
Arabic
Spanish
French
German
Japanese
Chinese
```

The selected language is stored locally.

The application also uses Flutter's localization delegates:

```text
GlobalMaterialLocalizations
GlobalWidgetsLocalizations
GlobalCupertinoLocalizations
```

This allows Flutter widgets to respond appropriately to the selected locale.

---

# 👋 Onboarding

The onboarding screen is displayed after successful registration.

The onboarding experience introduces the user to the application before they continue to the main application experience.

The onboarding interface includes actions such as:

* Skip
* Continue
* Get Started

---

# 🏗️ Project Architecture

The project follows a modular structure separating:

* Screens
* Widgets
* Models
* Data
* Services

This separation makes the application easier to:

* Understand
* Maintain
* Debug
* Extend
* Test

---

# 📁 Project Structure

```text
lib/
│
├── main.dart
├── firebase_options.dart
│
├── screens/
│   │
│   ├── main_screen.dart
│   ├── home_screen.dart
│   ├── saved_screen.dart
│   ├── profile_screen.dart
│   ├── settings_screen.dart
│   ├── news_details_screen.dart
│   ├── splash_screen.dart
│   │
│   └── auth/
│       ├── login_screen.dart
│       ├── register_screen.dart
│       ├── forgot_password_screen.dart
│       └── onboarding_screen.dart
│
├── widgets/
│   ├── app_bar.dart
│   ├── category_chip.dart
│   ├── featured_news.dart
│   ├── news_card.dart
│   └── bottom_nav_bar.dart
│
├── models/
│   └── news_model.dart
│
├── data/
│   └── news_data.dart
│
└── services/
    ├── saved_news_service.dart
    ├── theme_service.dart
    ├── auth_service.dart
    └── language_service.dart
```

---

# 📱 Screens

## 🏠 Home Screen

The Home Screen is the main entry point of the application.

It contains:

* Application header
* Category selection
* Featured News
* Latest News
* Search functionality
* News cards

---

## ⭐ Featured News

The Featured News component displays the main highlighted article.

Users can tap the article to open its details.

---

## 📰 News Details

The News Details screen provides a larger view of an article.

It displays:

* Article image
* Category
* Title
* Time
* Description
* Story information
* Save/bookmark action

---

## 🔖 Saved Screen

The Saved screen displays articles saved by the authenticated user.

The screen supports:

* Loading saved articles
* Displaying saved articles
* Removing saved articles
* Refreshing saved content

---

## 👤 Profile Screen

The Profile screen provides user account functionality.

Authenticated users can access:

* Profile information
* Edit Profile
* Saved Articles
* Reading History section
* Notification Preferences section
* Settings
* Logout

Guests are provided with Login/Register options.

---

## ⚙️ Settings Screen

The Settings screen contains application preferences.

Available settings include:

* Language
* Notifications
* Dark Mode
* About
* Privacy Policy

---

## 🔑 Login Screen

The Login screen provides:

* Email field
* Password field
* Password visibility toggle
* Remember Me
* Forgot Password
* Login button
* Register navigation

---

## 📝 Register Screen

The Register screen provides:

* Full name
* Email
* Password
* Confirm password
* Password visibility controls
* Account creation

---

## 🔐 Forgot Password Screen

Users can enter their email address to request a password-reset email.

---

## 🚀 Splash Screen

The Splash Screen is displayed when the application launches.

It provides the initial application entry experience before the main application is displayed.

---

# 🧩 Widgets

## `NewsCard`

Responsible for displaying an individual news article.

It handles:

* News image
* Category
* Title
* Description
* Time
* Save action
* Article navigation

---

## `FeaturedNews`

Responsible for displaying the highlighted article on the Home screen.

---

## `CategoryChip`

Provides category-selection UI for filtering news.

---

## `BottomNavBar`

Provides primary navigation between the application's main sections.

---

## `AppBar`

Provides a reusable application header component.

---

# 🧱 Models

The primary news model is:

```text
models/news_model.dart
```

The `NewsModel` contains:

```text
category
title
description
time
image
```

This model provides a consistent structure for news articles throughout the application.

---

# ⚙️ Services

## `AuthService`

Responsible for:

* Registration
* Login
* Logout
* Password reset
* Profile updates
* Firebase Authentication
* Firestore profile storage
* Remember Me session handling

---

## `SavedNewsService`

Responsible for:

* Saving articles
* Removing saved articles
* Loading saved articles
* Synchronizing saved news with Firestore

---

## `ThemeService`

Responsible for:

* Light/Dark mode
* Persisting theme preferences

---

## `LanguageService`

Responsible for:

* Supported languages
* Current language
* Translation strings
* Persisting language selection

---

# 📰 News Data

Current news content is stored in:

```text
lib/data/news_data.dart
```

Each article follows the `NewsModel` structure.

Current example categories include:

```text
News
Technology
Business
Sports
Health
```

---

# 🖼️ Assets

Application images are stored inside:

```text
assets/images/
```

Example:

```text
assets/
└── images/
    ├── canyoneering.jpg
    ├── technology.jpg
    ├── business.jpg
    ├── sports.jpg
    └── health.jpg
```

The entire folder is registered in `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/
```

This allows Flutter to access images using paths such as:

```text
assets/images/technology.jpg
```

---

# 🛠️ Technologies Used

## Flutter

Flutter is the primary framework used to build the mobile application.

---

## Dart

Dart is the programming language used for the application.

---

## Firebase Authentication

Used for:

* User registration
* Login
* Logout
* Password reset
* Account management

---

## Cloud Firestore

Used for:

* User profile data
* Saved news
* Cloud synchronization

---

## SharedPreferences

Used for local application preferences such as:

* Dark Mode
* Selected language
* Remember Me
* Remembered email

---

# 📦 Dependencies

Main dependencies include:

```yaml
flutter:
  sdk: flutter

flutter_localizations:
  sdk: flutter

cupertino_icons: ^1.0.8

firebase_core: ^4.1.0
firebase_auth: ^6.0.2
cloud_firestore: ^6.0.1
firebase_messaging: ^16.0.1

shared_preferences: ^2.5.3
```

---

# ⚙️ Installation

## 1. Clone the Project

Clone the repository:

```bash
git clone <YOUR_REPOSITORY_URL>
```

Then enter the project directory:

```bash
cd news_app
```

---

## 2. Install Flutter Dependencies

Run:

```bash
flutter pub get
```

---

## 3. Check Flutter Installation

Run:

```bash
flutter doctor
```

Make sure Flutter and Android development are properly configured.

---

# 🔥 Firebase Configuration

The application uses Firebase configuration generated by FlutterFire CLI.

The configuration file is:

```text
lib/firebase_options.dart
```

Firebase is initialized in:

```text
lib/main.dart
```

using:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

---

# ▶️ Running the Application

Connect an Android device or start an Android emulator.

Then run:

```bash
flutter run
```

The application should launch on the selected device.

---

# 🧪 Testing

Flutter widget tests are located inside:

```text
test/
```

The project includes a test for checking whether the main application loads successfully.

Tests can be executed using:

```bash
flutter test
```

---

# 📦 Building the APK

To generate a release APK:

```bash
flutter build apk --release
```

The generated APK can be found under the Flutter build output directory.

For an architecture-specific APK:

```bash
flutter build apk --split-per-abi
```

---

# 🐛 Error Handling

The application includes error handling for common Firebase Authentication errors.

Examples include:

* Email already registered
* Invalid email
* Weak password
* User not found
* Incorrect credentials
* Disabled account
* Too many requests
* Network errors
* Authentication configuration errors

User-facing error messages are displayed using Flutter `SnackBar` notifications.

---

# 🔒 Security

The application does not store user passwords locally.

Firebase Authentication is responsible for authentication credentials.

Firestore access is protected using authenticated-user rules.

Each user can access only the Firestore documents associated with their Firebase UID.

The Remember Me feature stores only the local preference and remembered email address.

---

# 🔄 User Flow

The general user flow is:

```text
Application Launch
        ↓
Splash Screen
        ↓
Home Screen
        ↓
Browse News
        ↓
Open Article
        ↓
Read Article
        ↓
Save Article
        ↓
Login/Register if Required
        ↓
Saved News
```

Registration flow:

```text
Register
   ↓
Validate Information
   ↓
Firebase Authentication
   ↓
Create Firestore User Profile
   ↓
Onboarding
   ↓
Main Application
```

Login flow:

```text
Login
   ↓
Validate Credentials
   ↓
Firebase Authentication
   ↓
Authenticated User
   ↓
Main Application
```

---

# 🧭 Navigation Structure

The application uses a main navigation structure containing:

```text
Home
Saved
Profile
```

Additional screens are opened through navigation from the relevant sections.

Authentication screens are accessed when the user needs protected functionality.

---

# 💾 Data Storage Strategy

The application uses two types of storage.

## Local Storage

`SharedPreferences` stores:

```text
Dark Mode preference
Language preference
Remember Me preference
Remembered email
```

---

## Cloud Storage

Firebase stores:

```text
Authentication accounts
User profiles
Saved news
```

This separation keeps local UI preferences lightweight while keeping account-related data synchronized in the cloud.

---

# 📊 Application Data Flow

```text
Flutter UI
    │
    ├── Home
    ├── Saved
    ├── Profile
    └── Settings
          │
          ↓
      Services
          │
    ┌─────┴─────┐
    ↓           ↓
Firebase     Local Storage
Auth         SharedPreferences
    │
    ↓
Firestore
    │
    ├── User Profiles
    └── Saved News
```

---

# 🧩 Design Principles

The application was structured around the following principles:

### Simplicity

The interface avoids unnecessary complexity and keeps the main user actions easy to discover.

### Reusability

Reusable widgets and services are separated from individual screens.

### Maintainability

The project is divided into logical folders so future changes can be made without modifying unrelated components.

### User Experience

The application provides both guest and authenticated experiences.

### Persistence

Important user preferences and cloud data persist between application sessions.

---

# 🔮 Future Improvements

Possible future improvements include:

* Connecting the application to a real news API.
* Loading live news instead of static local data.
* Real-time search against API results.
* Push notification implementation using Firebase Cloud Messaging.
* Persistent notification preferences.
* Reading history synchronization.
* More advanced category filtering.
* Pagination for large news feeds.
* Offline news caching.
* Improved accessibility.
* Automated integration testing.
* Automated Firebase testing.
* Production analytics.
* Crash reporting.
* App Store / Google Play release configuration.

---

# 🚀 Future Scalability

The current architecture allows additional functionality to be introduced without restructuring the entire project.

For example, the static:

```text
NewsData
```

can later be replaced or extended with a remote news service.

The UI can continue using:

```text
NewsModel
```

while the data source changes from local data to an API.

This makes the project suitable for future expansion.

---

# 📋 Project Checklist

## Core Application

* [x] Flutter application
* [x] Home screen
* [x] News cards
* [x] Featured news
* [x] Latest news
* [x] Categories
* [x] News details
* [x] Search
* [x] Saved news
* [x] Profile
* [x] Settings
* [x] Splash screen
* [x] Onboarding

## Authentication

* [x] Registration
* [x] Login
* [x] Logout
* [x] Forgot password
* [x] Remember Me
* [x] Profile editing

## Firebase

* [x] Firebase Core
* [x] Firebase Authentication
* [x] Cloud Firestore
* [x] Firebase configuration
* [x] User profiles
* [x] Saved news
* [x] Firestore security rules

## Personalization

* [x] Dark Mode
* [x] Language selection
* [x] Seven supported languages
* [x] Local preferences

## Assets

* [x] News images
* [x] Flutter asset configuration
* [x] News image paths

---

# 📝 Conclusion

The **News App** provides a complete Flutter-based news browsing experience with authentication, cloud data storage, saved articles, multilingual support, theme customization, search, onboarding, and profile management.

The application demonstrates the use of:

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* SharedPreferences
* Flutter localization
* Modular application architecture

The project is structured to remain maintainable and expandable, allowing future integration with real-time news APIs, push notifications, analytics, and additional production-level functionality.

---

# 👩‍💻 Project Information

**Project Name:** News App

**Framework:** Flutter

**Language:** Dart

**Backend:** Firebase

**Database:** Cloud Firestore

**Authentication:** Firebase Authentication

**Local Storage:** SharedPreferences

**Supported Languages:** 7

**Target Platform:** Android

---

# ❤️ Final Note

This project was built with the goal of combining a clean news-reading experience with practical mobile application features and cloud-based user functionality.

The modular structure makes it easier to maintain, test, improve, and extend the application in the future.
