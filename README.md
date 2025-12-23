# 🍳 Recipe NTI

A modern, feature-rich Flutter application for discovering, searching, and managing your favorite
recipes. Built with clean architecture principles and state-of-the-art Flutter packages.

<p align="center">
  <img src="assets/images/logo.png" alt="Recipe NTI Logo" width="200"/>
</p>

## ✨ Features

- 🔍 **Smart Search**: Quickly find recipes by name, ingredients, or category
- 📱 **Browse Recipes**: Explore a wide variety of meals and dishes
- ❤️ **Favorites**: Save and organize your favorite recipes for quick access
- 📖 **Detailed Instructions**: View comprehensive recipe details, ingredients, and cooking
  instructions
- 🌐 **Share Recipes**: Share your favorite recipes with friends and family
- 🎨 **Modern UI**: Clean, intuitive interface with smooth animations and skeletons
- 🌙 **Material Design 3**: Beautiful UI following Material Design 3 guidelines
- 💾 **Offline Support**: Cache recipes for offline viewing
- 🔒 **Secure Storage**: Secure storage for sensitive data

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a clear separation of concerns:

```
lib/
├── config/          # App configuration (routing, caching)
├── core/            # Core functionality (networking, service locator)
├── features/        # Feature modules (home, search, favorites, etc.)
│   ├── favorites/
│   ├── home/
│   ├── meals_list/
│   ├── meal_details/
│   ├── search/
│   └── shared/
└── views/           # Main view screens
```

### Key Architectural Patterns

- **BLoC Pattern**: State management using `flutter_bloc`
- **Dependency Injection**: Using `get_it` for service locator pattern
- **Repository Pattern**: Clean data layer abstraction
- **Layered Architecture**: Presentation, Domain, and Data layers

## 🛠️ Tech Stack

### Core Dependencies

- **State Management**: `flutter_bloc` ^9.1.1 - Reactive state management
- **Dependency Injection**: `get_it` ^9.2.0 - Service locator
- **Networking**: `dio` ^5.9.0 - HTTP client for API calls
- **Logging**: `pretty_dio_logger` ^1.4.0 - Beautiful HTTP logs
- **Responsive Design**: `flutter_screenutil` ^5.9.3 - Screen adaptation

### Storage & Caching

- **Preferences**: `shared_preferences` ^2.5.3 - Key-value storage
- **Image Caching**: `cached_network_image` ^3.4.1 - Efficient image loading

### UI/UX

- **Loading States**: `skeletonizer` ^1.4.3 - Skeleton screens
- **Material 3**: Latest Material Design components

### Utilities

- **URL Launcher**: `url_launcher` ^6.3.1 - Open external links
- **Sharing**: `share_plus` ^10.0.0 - Share content

## 📋 Prerequisites

Before running this project, make sure you have the following installed:

- **Flutter SDK**: ^3.5.2 or higher
- **Dart SDK**: ^3.5.2 or higher
- **Android Studio** or **VS Code** with Flutter extensions
- **Xcode** (for iOS development, macOS only)
- **Android SDK** (for Android development)

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Ibrahim-Yacoub/recipe_nti.git
cd recipe_nti
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

#### For Android:

```bash
flutter run
```

#### For iOS:

```bash
flutter run -d ios
```

#### For Web:

```bash
flutter run -d chrome
```

## 📱 Build for Production

### Android (APK)

```bash
flutter build apk --release
```

### Android (App Bundle)

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

## 🧪 Running Tests

```bash
flutter test
```

## 📂 Project Structure

```
recipe_nti/
├── android/              # Android-specific code
├── ios/                  # iOS-specific code
├── lib/                  # Main application code
│   ├── config/          # App configuration
│   │   ├── cache/       # Caching configuration
│   │   └── router/      # App routing
│   ├── core/            # Core utilities
│   │   ├── navigation/  # Navigation helpers
│   │   ├── networking/  # API client setup
│   │   └── service_locator.dart
│   ├── features/        # Feature modules
│   │   ├── favorites/   # Favorites feature
│   │   ├── home/        # Home screen feature
│   │   ├── meals_list/  # Meal listing feature
│   │   ├── meal_details/# Recipe details feature
│   │   ├── search/      # Search feature
│   │   └── shared/      # Shared components
│   ├── views/           # Main views
│   └── main.dart        # App entry point
├── assets/              # Images and assets
├── test/                # Unit and widget tests
├── web/                 # Web-specific files
├── windows/             # Windows-specific files
├── linux/               # Linux-specific files
└── macos/               # macOS-specific files
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Ibrahim Mohamed Yacoub**

- 📧 **Email:** [Ibrahim.Mohamed.Yacoub@gmail.com
  ](mailto:ibrahim.mohamed.yacoub@gmail.com
  )
- 👨‍💻 **GitHub:** [Ibrahim-Yacoub](https://github.com/Ibrahim-Yacoub)
- 🌐 **LinkedIn:** [Ibrahim Yacoub](https://www.linkedin.com/in/ibrahim-yacoub-35a382357)

## 🙏 Acknowledgments

- Recipe data provided by [MealDB API](https://www.themealdb.com/)
- Built with [Flutter](https://flutter.dev/)

## 📞 Support

For support open an issue in the repository.

## 🔮 Future Enhancements

- [ ] User authentication and profiles
- [ ] Create custom recipes
- [ ] Shopping list generation
- [ ] Meal planning calendar
- [ ] Nutritional information
- [ ] Recipe ratings and reviews
- [ ] Social features (follow users, share recipes)
- [ ] Dark mode support
- [ ] Multiple language support
- [ ] Voice-guided cooking mode

---

<p align="center">Made with ❤️ using Flutter</p>
