# Flutter Clean Architecture Generator - Example Usage

This example demonstrates how to use the Flutter Clean Architecture Generator to create clean architecture structures in your Flutter projects.

## Installation

First, install the generator globally:

```bash
dart pub global activate flutter_clean_architecture_generator
```

## Usage Example

Navigate to your Flutter project root and run:

```bash
flutter_clean_architecture_generator
```

## Example Session

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

═══════════════════════════════════════
║ Boilerplate Generation Options ║
═══════════════════════════════════════

📋 Do you want to generate data models (Freezed classes)?
   This will create immutable data classes with JSON serialization
➤  Generate models? (Y/n): y

🗄️  Do you want to generate repository classes?
   This will create repository interfaces and implementations for data access
➤  Generate repositories? (Y/n): y

🔄 Do you want to generate Riverpod providers?
   This will create state management providers with AsyncNotifier
➤  Generate providers? (Y/n): y

📱 Do you want to generate view/screen widgets?
   This will create a complete screen with state management integration
➤  Generate views? (Y/n): y

📚 Do you want to generate documentation (README.md)?
   This will create comprehensive documentation for the feature
➤  Generate README? (Y/n): y

📋 Generation Summary:
   ✅ Models: Yes
   ✅ Repositories: Yes
   ✅ Providers: Yes
   ✅ Views: Yes
   ✅ Readme: Yes

Continue with these options? (Y/n): y
```

## Generated Project Structure

After running the generator, you'll get a complete feature structure as shown below.

## Using the Generator

You can use the generator from the command line. Here’s how to generate a clean architecture structure for a new feature:

1. **Run the generator**:
   ```bash
   flutter_clean_architecture_generator
   ```

2. **Follow the prompts** to enter the feature name and select the options for generating models, repositories, providers, views, and README files.

3. **Check the generated structure** in the `lib` directory of your Flutter project. You should see a new folder for your feature with the specified structure.

## Example Output

After running the generator, you might see an output like this:

```
📁 Generated folder structure:

lib/
└── my_feature/
    ├── presentation/
    │   ├── views/
    │   └── widgets/
    ├── data/
    │   ├── models/
    │   └── repositories/
    └── providers/
```

## Next Steps

- Customize the generated files according to your project requirements.
- Implement the actual data source in the repository.
- Enhance the UI components in the presentation layer.

## Contributing

If you would like to contribute to the Flutter Clean Architecture Generator, please fork the repository at https://github.com/RamyBouchareb25/flutter-clean-architecture-generator and submit a pull request. For more details, check the main README file.

Happy coding! 🚀