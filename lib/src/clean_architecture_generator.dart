import 'dart:io';
import 'dart:convert';

class CliColors {
  static const String reset = '\x1B[0m';
  static const String bold = '\x1B[1m';
  static const String dim = '\x1B[2m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';
}

class FlutterCleanArchitectureGenerator {
  static const String logo = '''
  ╔═══════════════════════════════════════════════════════════════╗
  ║                                                               ║
  ║    ${CliColors.cyan}🏗️  Flutter Clean Architecture Generator 🏗️${CliColors.reset}         ║
  ║                                                               ║
  ║         ${CliColors.dim}Generate perfect folder structures with ease${CliColors.reset}        ║
  ║                                                               ║
  ╚═══════════════════════════════════════════════════════════════╝
  ''';

  static Future<void> run(List<String> arguments) async {
    printLogo();

    try {
      final featureName = promptFeatureName();

      if (featureName == null) {
        printError('Invalid feature name. Exiting...');
        exit(1);
      }

      printInfo(
        'Generating clean architecture structure for: $featureName',
      );

      final success = await createDirectoryStructure(featureName);

      if (success) {
        print('\n');
        printTree(featureName);
        printCompletion(featureName);
      } else {
        printError('Failed to generate structure');
        exit(1);
      }
    } catch (e) {
      printError('An unexpected error occurred: $e');
      exit(1);
    }
  }

  static void printLogo() {
    print(logo);
  }

  static void printSuccess(String message) {
    print('${CliColors.green}✅ $message${CliColors.reset}');
  }

  static void printInfo(String message) {
    print('${CliColors.blue}ℹ️  $message${CliColors.reset}');
  }

  static void printWarning(String message) {
    print('${CliColors.yellow}⚠️  $message${CliColors.reset}');
  }

  static void printError(String message) {
    print('${CliColors.red}❌ $message${CliColors.reset}');
  }

  static void printHeader(String text) {
    final line = '═' * (text.length + 4);
    print('\n${CliColors.magenta}$line${CliColors.reset}');
    print(
      '${CliColors.magenta}║ ${CliColors.bold}$text${CliColors.reset}${CliColors.magenta} ║${CliColors.reset}',
    );
    print('${CliColors.magenta}$line${CliColors.reset}\n');
  }

  static void printTree(String featureName) {
    print(
      '${CliColors.cyan}📁 Generated folder structure:${CliColors.reset}\n',
    );
    print('${CliColors.bold}lib/${CliColors.reset}');
    print('└── ${CliColors.bold}$featureName/${CliColors.reset}');
    print('    ├── ${CliColors.yellow}presentation/${CliColors.reset}');
    print('    │   ├── ${CliColors.green}views/${CliColors.reset}');
    print('    │   └── ${CliColors.green}widgets/${CliColors.reset}');
    print('    ├── ${CliColors.yellow}data/${CliColors.reset}');
    print('    │   ├── ${CliColors.green}models/${CliColors.reset}');
    print('    │   └── ${CliColors.green}repositories/${CliColors.reset}');
    print('    └── ${CliColors.yellow}providers/${CliColors.reset}');
  }

  static String? promptFeatureName() {
    print('${CliColors.cyan}📝 Enter the feature name:${CliColors.reset}');
    print(
      '${CliColors.dim}   (e.g., drivers, authentication, profile, etc.)${CliColors.reset}',
    );
    stdout.write('${CliColors.bold}➤  ${CliColors.reset}');

    final input = stdin.readLineSync()?.trim();

    if (input == null || input.isEmpty) {
      printError('Feature name cannot be empty!');
      return null;
    }

    // Validate feature name (alphanumeric and underscores only)
    if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$').hasMatch(input)) {
      printError(
        'Feature name must start with a letter and contain only letters, numbers, and underscores!',
      );
      return null;
    }

    return input.toLowerCase();
  }

  static Future<Map<String, bool>> promptGenerationOptions() async {
    printHeader('Boilerplate Generation Options');

    final options = <String, bool>{};

    // Prompt for models
    print(
      '${CliColors.cyan}📋 Do you want to generate data models (Freezed classes)?${CliColors.reset}',
    );
    print(
      '${CliColors.dim}   This will create immutable data classes with JSON serialization${CliColors.reset}',
    );
    stdout.write(
      '${CliColors.bold}➤  Generate models? (Y/n): ${CliColors.reset}',
    );
    final modelsResponse = stdin.readLineSync()?.toLowerCase() ?? 'y';
    options['models'] = modelsResponse != 'n' && modelsResponse != 'no';

    // Prompt for repositories
    print(
      '\n${CliColors.cyan}🗄️  Do you want to generate repository classes?${CliColors.reset}',
    );
    print(
      '${CliColors.dim}   This will create repository interfaces and implementations for data access${CliColors.reset}',
    );
    stdout.write(
      '${CliColors.bold}➤  Generate repositories? (Y/n): ${CliColors.reset}',
    );
    final repoResponse = stdin.readLineSync()?.toLowerCase() ?? 'y';
    options['repositories'] = repoResponse != 'n' && repoResponse != 'no';

    // Prompt for providers
    print(
      '\n${CliColors.cyan}🔄 Do you want to generate Riverpod providers?${CliColors.reset}',
    );
    print(
      '${CliColors.dim}   This will create state management providers with AsyncNotifier${CliColors.reset}',
    );
    stdout.write(
      '${CliColors.bold}➤  Generate providers? (Y/n): ${CliColors.reset}',
    );
    final providerResponse = stdin.readLineSync()?.toLowerCase() ?? 'y';
    options['providers'] = providerResponse != 'n' && providerResponse != 'no';

    // Prompt for views
    print(
      '\n${CliColors.cyan}📱 Do you want to generate view/screen widgets?${CliColors.reset}',
    );
    print(
      '${CliColors.dim}   This will create a complete screen with state management integration${CliColors.reset}',
    );
    stdout.write(
      '${CliColors.bold}➤  Generate views? (Y/n): ${CliColors.reset}',
    );
    final viewsResponse = stdin.readLineSync()?.toLowerCase() ?? 'y';
    options['views'] = viewsResponse != 'n' && viewsResponse != 'no';

    // Prompt for README
    print(
      '\n${CliColors.cyan}📚 Do you want to generate documentation (README.md)?${CliColors.reset}',
    );
    print(
      '${CliColors.dim}   This will create comprehensive documentation for the feature${CliColors.reset}',
    );
    stdout.write(
      '${CliColors.bold}➤  Generate README? (Y/n): ${CliColors.reset}',
    );
    final readmeResponse = stdin.readLineSync()?.toLowerCase() ?? 'y';
    options['readme'] = readmeResponse != 'n' && readmeResponse != 'no';

    // Show summary
    print('\n${CliColors.magenta}📋 Generation Summary:${CliColors.reset}');
    options.forEach((key, value) {
      final icon = value ? '✅' : '❌';
      final status = value ? 'Yes' : 'No';
      print('   $icon ${_capitalize(key)}: $status');
    });

    print(
      '\n${CliColors.yellow}Continue with these options? (Y/n): ${CliColors.reset}',
    );
    final confirmResponse = stdin.readLineSync()?.toLowerCase() ?? 'y';
    if (confirmResponse == 'n' || confirmResponse == 'no') {
      printInfo('Operation cancelled.');
      return <String, bool>{};
    }

    return options;
  }

  static String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static Future<bool> createDirectoryStructure(String featureName) async {
    try {
      printHeader('Creating Directory Structure');

      final baseDir = Directory('lib/$featureName');

      if (await baseDir.exists()) {
        printWarning('Directory "lib/$featureName" already exists!');
        stdout.write(
          '${CliColors.yellow}Do you want to continue? (y/N): ${CliColors.reset}',
        );
        final response = stdin.readLineSync()?.toLowerCase();
        if (response != 'y' && response != 'yes') {
          printInfo('Operation cancelled.');
          return false;
        }
      }

      // Create directory structure
      final directories = [
        'lib/$featureName/presentation/views',
        'lib/$featureName/presentation/widgets',
        'lib/$featureName/data/models',
        'lib/$featureName/data/repositories',
        'lib/$featureName/providers',
      ];

      print('${CliColors.blue}🔨 Creating directories...${CliColors.reset}');

      for (final dir in directories) {
        await Directory(dir).create(recursive: true);
        printSuccess('Created: $dir');

        // Add a small delay for visual effect
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // Get user preferences for what to generate
      final generateOptions = await promptGenerationOptions();

      // Create sample files based on user preferences
      await createSampleFiles(featureName, generateOptions);

      // Run build_runner if models were generated
      if (generateOptions['models'] == true) {
        await runBuildRunner(featureName);
      }

      return true;
    } catch (e) {
      printError('Failed to create directory structure: $e');
      return false;
    }
  }

  static Future<void> createSampleFiles(
    String featureName,
    Map<String, bool> options,
  ) async {
    print(
      '\n${CliColors.blue}📄 Creating boilerplate files...${CliColors.reset}',
    );

    // Create files based on user preferences
    if (options['views'] == true) {
      await createViewFile(featureName);
    }

    if (options['models'] == true) {
      await createModelFile(featureName);
    }

    if (options['providers'] == true) {
      await createProviderFile(featureName);
    }

    if (options['repositories'] == true) {
      await createRepositoryFile(featureName);
    }

    if (options['readme'] == true) {
      await createReadmeFile(featureName);
    }

    // Create .gitkeep files for empty directories
    final gitkeepDirs = ['lib/$featureName/presentation/widgets'];

    for (final dir in gitkeepDirs) {
      final gitkeepFile = File('$dir/.gitkeep');
      await gitkeepFile.writeAsString(
        '# Keep this directory in version control\n',
      );
    }
  }

  static Future<void> createViewFile(String featureName) async {
    final className = _toPascalCase(featureName);
    final viewContent = '''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/${featureName}_provider.dart';

class ${className}View extends ConsumerWidget {
  const ${className}View({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ${featureName}List = ref.watch(${featureName}ListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('$className'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ${featureName}List.when(
        data: (items) => items.isEmpty
            ? const Center(
                child: Text(
                  'No $featureName found',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('ID: \${item.id}'),
                    leading: const Icon(Icons.folder),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: \$error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(${featureName}ListProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new $featureName item
          ref.read(${featureName}ListProvider.notifier).addSample$className();
        },
        tooltip: 'Add $className',
        child: const Icon(Icons.add),
      ),
    );
  }
}
''';

    final viewFile = File(
      'lib/$featureName/presentation/views/${featureName}_view.dart',
    );
    await viewFile.writeAsString(viewContent);
    printSuccess('Created: ${featureName}_view.dart');
  }

  static Future<void> createModelFile(String featureName) async {
    final className = _toPascalCase(featureName);
    final modelContent =
        '''import 'package:freezed_annotation/freezed_annotation.dart';

part '$featureName.freezed.dart';
part '$featureName.g.dart';

@freezed
abstract class $className with _\$$className {
  const factory $className({
    required String id,
    required String name,
    @Default('') String description,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _$className;

  factory $className.fromJson(Map<String, dynamic> json) =>
      _\$${className}FromJson(json);
}
''';

    final modelFile = File('lib/$featureName/data/models/$featureName.dart');
    await modelFile.writeAsString(modelContent);
    printSuccess('Created: $featureName.dart (Freezed model)');
  }

  static Future<void> createProviderFile(String featureName) async {
    final className = _toPascalCase(featureName);
    final providerContent =
        '''import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/$featureName.dart';
import '../data/repositories/${featureName}_repository.dart';

// Repository provider
final ${featureName}RepositoryProvider = Provider<${className}Repository>((ref) {
  return ${className}Repository();
});

// State provider for the list of $featureName
final ${featureName}ListProvider = AsyncNotifierProvider<${className}ListNotifier, List<$className>>(() {
  return ${className}ListNotifier();
});

class ${className}ListNotifier extends AsyncNotifier<List<$className>> {
  @override
  Future<List<$className>> build() async {
    final repository = ref.read(${featureName}RepositoryProvider);
    return await repository.getAll${className}s();
  }

  Future<void> add$className($className item) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(${featureName}RepositoryProvider);
      await repository.add$className(item);
      
      // Refresh the list
      state = AsyncValue.data([...?state.value, item]);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> update$className($className item) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(${featureName}RepositoryProvider);
      await repository.update$className(item);
      
      // Update the list
      final currentList = state.value ?? [];
      final updatedList = currentList.map((existingItem) {
        return existingItem.id == item.id ? item : existingItem;
      }).toList();
      
      state = AsyncValue.data(updatedList);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> delete$className(String id) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(${featureName}RepositoryProvider);
      await repository.delete$className(id);
      
      // Remove from list
      final currentList = state.value ?? [];
      final updatedList = currentList.where((item) => item.id != id).toList();
      
      state = AsyncValue.data(updatedList);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(${featureName}RepositoryProvider);
      final items = await repository.getAll${className}s();
      state = AsyncValue.data(items);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Helper method to add sample data
  Future<void> addSample$className() async {
    final sampleItem = $className(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Sample $className \${DateTime.now().millisecondsSinceEpoch}',
      description: 'This is a sample $featureName item',
      createdAt: DateTime.now(),
    );
    
    await add$className(sampleItem);
  }
}
''';

    final providerFile = File(
      'lib/$featureName/providers/${featureName}_provider.dart',
    );
    await providerFile.writeAsString(providerContent);
    printSuccess('Created: ${featureName}_provider.dart');
  }

  static Future<void> createRepositoryFile(String featureName) async {
    final className = _toPascalCase(featureName);
    final repositoryContent = '''import '../models/$featureName.dart';

abstract class I${className}Repository {
  Future<List<$className>> getAll${className}s();
  Future<$className?> get${className}ById(String id);
  Future<void> add$className($className item);
  Future<void> update$className($className item);
  Future<void> delete$className(String id);
}

class ${className}Repository implements I${className}Repository {
  // In-memory storage for demo purposes
  // Replace with your actual data source (API, Database, etc.)
  final List<$className> _items = [];

  @override
  Future<List<$className>> getAll${className}s() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return a copy of the list
    return List.from(_items);
  }

  @override
  Future<$className?> get${className}ById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> add$className($className item) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    _items.add(item);
  }

  @override
  Future<void> update$className($className item) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = _items.indexWhere((existingItem) => existingItem.id == item.id);
    if (index != -1) {
      _items[index] = item;
    }
  }

  @override
  Future<void> delete$className(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    _items.removeWhere((item) => item.id == id);
  }
}
''';

    final repositoryFile = File(
      'lib/$featureName/data/repositories/${featureName}_repository.dart',
    );
    await repositoryFile.writeAsString(repositoryContent);
    printSuccess('Created: ${featureName}_repository.dart');
  }

  static Future<void> createReadmeFile(String featureName) async {
    final className = _toPascalCase(featureName);
    final readmeContent = '''# $className Feature

This directory contains the implementation for the **$className** feature using Clean Architecture principles with Riverpod and Freezed.

## Structure

- **presentation/**: UI components and state management
  - `views/`: Screen widgets and pages
    - `${featureName}_view.dart`: Main view for $className feature
  - `widgets/`: Reusable UI components

- **data/**: Data layer implementation
  - `models/`: Data models and entities
    - `$featureName.dart`: Freezed model with JSON serialization
  - `repositories/`: Repository implementations
    - `${featureName}_repository.dart`: Repository interface and implementation

- **providers/**: Riverpod providers for state management
  - `${featureName}_provider.dart`: AsyncNotifier for managing $className list state

## Generated Files

### Model ($className)
- ✅ Freezed data class with immutability
- ✅ JSON serialization support
- ✅ Built-in copyWith and equality

### Repository (${className}Repository)
- ✅ Abstract interface for testability
- ✅ CRUD operations
- ✅ In-memory implementation (replace with your data source)

### Provider (${className}ListNotifier)
- ✅ AsyncNotifier for reactive state management
- ✅ CRUD operations with proper error handling
- ✅ Loading and error states

### View (${className}View)
- ✅ ConsumerWidget with Riverpod integration
- ✅ Loading, error, and data states handling
- ✅ Material Design UI

## Next Steps

1. **Run build_runner**: The tool will automatically run this for you
2. **Customize the model**: Add/remove fields in `$featureName.dart`
3. **Implement real data source**: Replace in-memory storage in repository
4. **Enhance the UI**: Add more widgets and improve the view
5. **Add business logic**: Create use cases if needed

## Dependencies Used

- `flutter_riverpod`: State management
- `freezed`: Immutable data classes
- `json_annotation`: JSON serialization

Happy coding! 🚀
''';

    final readmeFile = File('lib/$featureName/README.md');
    await readmeFile.writeAsString(readmeContent);
    printSuccess('Created: README.md');
  }

  static Future<void> runBuildRunner(String featureName) async {
    printHeader('Running Build Runner');

    // Check if we're in a Flutter project directory
    final pubspecFile = File('pubspec.yaml');
    if (!await pubspecFile.exists()) {
      printWarning(
        'pubspec.yaml not found. Make sure you\'re in a Flutter project directory.',
      );
      printInfo('You can manually run: dart run build_runner build');
      return;
    }

    printInfo('Checking for required dependencies...');

    // Check if build_runner dependencies exist
    final pubspecContent = await pubspecFile.readAsString();
    final hasBuildRunner = pubspecContent.contains('build_runner:');
    final hasFreezed = pubspecContent.contains('freezed:');
    final hasJsonSerializable = pubspecContent.contains('json_serializable:');

    if (!hasBuildRunner || !hasFreezed || !hasJsonSerializable) {
      printWarning(
        'Missing required dev dependencies. Please add these to your pubspec.yaml:',
      );
      print('\n${CliColors.yellow}dev_dependencies:');
      if (!hasBuildRunner) print('  build_runner: ^2.4.7');
      if (!hasFreezed) print('  freezed: ^2.4.6');
      if (!hasJsonSerializable) print('  json_serializable: ^6.7.1');
      print('\ndependencies:');
      print('  freezed_annotation: ^2.4.1');
      print('  json_annotation: ^4.8.1${CliColors.reset}');

      printInfo('After adding dependencies, run: flutter pub get');
      printInfo('Then run: dart run build_runner build');
      return;
    }

    try {
      printInfo(
        'Running: dart run build_runner build --delete-conflicting-outputs',
      );

      final process = await Process.start(
          'dart',
          [
            'run',
            'build_runner',
            'build',
            '--delete-conflicting-outputs',
          ],
          workingDirectory: Directory.current.path);

      // Show real-time output
      process.stdout.transform(utf8.decoder).listen((data) {
        print('${CliColors.dim}$data${CliColors.reset}');
      });

      process.stderr.transform(utf8.decoder).listen((data) {
        print('${CliColors.yellow}$data${CliColors.reset}');
      });

      final exitCode = await process.exitCode;

      if (exitCode == 0) {
        printSuccess('Build runner completed successfully!');
        printInfo(
          'Generated files: $featureName.freezed.dart and $featureName.g.dart',
        );
      } else {
        printWarning('Build runner finished with exit code: $exitCode');
        printInfo('You may need to run: flutter pub get');
        printInfo('Then run: dart run build_runner build');
      }
    } catch (e) {
      printWarning('Could not run build_runner automatically: $e');
      printInfo('Please run manually: dart run build_runner build');
    }
  }

  static String _toPascalCase(String input) {
    return input
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join('');
  }

  static void printCompletion(String featureName) {
    final successMessage = '''
${CliColors.green}╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║                    ${CliColors.bold}🎉 SUCCESS! 🎉${CliColors.reset}${CliColors.green}                        ║
║                                                               ║
║     Feature "$featureName" has been generated successfully!      ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝${CliColors.reset}
''';

    print(successMessage);

    print('${CliColors.cyan}📋 Next steps:${CliColors.reset}');
    print('   1. Navigate to the lib/$featureName directory');
    print(
      '   2. Check that Freezed files were generated ($featureName.freezed.dart & $featureName.g.dart)',
    );
    print('   3. Import and use ${_toPascalCase(featureName)}View in your app');
    print('   4. Customize the model, repository, and UI as needed');
    print('\n${CliColors.cyan}📱 Usage in your app:${CliColors.reset}');
    print(
      '   ${CliColors.dim}import \'$featureName/presentation/views/${featureName}_view.dart\';${CliColors.reset}',
    );
    print(
      '\n${CliColors.dim}💡 Tip: Check the README.md for detailed guidance${CliColors.reset}',
    );
  }
}
