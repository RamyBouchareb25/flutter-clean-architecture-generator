# Flutter Clean Architecture Generator

[![pub package](https://img.shields.io/pub/v/flutter_clean_architecture_generator.svg)](https://pub.dev/packages/flutter_clean_architecture_generator)

A command-line tool for generating clean architecture folder structures and boilerplate code for Flutter applications using Riverpod and Freezed.

## ✨ Features

- 🏗️ **Clean Architecture Structure**: Automatically generates well-organized feature folders
- 📱 **Complete Boilerplate**: Creates models, repositories, providers, and views
- 🔄 **Riverpod Integration**: State management with AsyncNotifier patterns
- 🧊 **Freezed Models**: Immutable data classes with JSON serialization
- 📚 **Documentation**: Generates comprehensive README files for each feature
- ⚡ **Fast Setup**: Get your feature structure ready in seconds

## 🚀 Installation

Install globally using Dart pub:

```bash
dart pub global activate flutter_clean_architecture_generator
```

## 📋 Usage

Navigate to your Flutter project root directory and run:

```bash
flutter_clean_architecture_generator
```

Follow the interactive prompts to:
1. Enter your feature name (e.g., `authentication`, `profile`, `users`)
2. Select which boilerplate files to generate
3. Let the tool create your clean architecture structure

## 📁 Generated Structure

```
lib/
└── your_feature/
    ├── presentation/
    │   ├── views/
    │   │   └── your_feature_view.dart
    │   └── widgets/
    ├── data/
    │   ├── models/
    │   │   └── your_feature.dart (Freezed model)
    │   └── repositories/
    │       └── your_feature_repository.dart
    └── providers/
        └── your_feature_provider.dart (Riverpod)
```

## 🎯 What Gets Generated

### 📋 Models (Freezed)
- Immutable data classes
- JSON serialization support
- Built-in `copyWith` and equality

### 🗄️ Repositories
- Abstract interfaces for testability
- CRUD operations
- Clean separation of data access logic

### 🔄 Providers (Riverpod)
- AsyncNotifier for reactive state management
- Proper error handling and loading states
- CRUD operations with optimistic updates

### 📱 Views
- ConsumerWidget with Riverpod integration
- Loading, error, and data state handling
- Material Design UI components

### 📚 Documentation
- Comprehensive README for each feature
- Usage examples and next steps
- Architecture explanation

## 🔧 Requirements

For the generated code to work properly, your Flutter project needs these dependencies:

```yaml
dependencies:
  flutter_riverpod: ^2.0.0
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
```

The tool will automatically run `build_runner` to generate the required Freezed files.

## 📖 Example

```bash
$ flutter_clean_architecture_generator

  ╔═══════════════════════════════════════════════════════════════╗
  ║                                                               ║
  ║    🏗️  Flutter Clean Architecture Generator 🏗️                ║
  ║                                                               ║
  ║         Generate perfect folder structures with ease          ║
  ║                                                               ║
  ╚═══════════════════════════════════════════════════════════════╝

📝 Enter the feature name:
   (e.g., drivers, authentication, profile, etc.)
➤  users

🔨 Creating directories...
✅ Created: lib/users/presentation/views
✅ Created: lib/users/presentation/widgets
✅ Created: lib/users/data/models
✅ Created: lib/users/data/repositories
✅ Created: lib/users/providers

📄 Creating boilerplate files...
✅ Created: users_view.dart
✅ Created: users.dart (Freezed model)
✅ Created: users_provider.dart
✅ Created: users_repository.dart
✅ Created: README.md
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🐛 Issues

If you encounter any issues or have feature requests, please file them in the [issue tracker](https://github.com/RamyBouchareb25/flutter-clean-architecture-generator/issues).