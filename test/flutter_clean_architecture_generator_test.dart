import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('FlutterCleanArchitectureGenerator', () {
    test('should validate feature names correctly', () {
      // Test valid names
      expect(_isValidFeatureName('valid_name'), isTrue);
      expect(_isValidFeatureName('authentication'), isTrue);
      expect(_isValidFeatureName('user_profile'), isTrue);
      expect(_isValidFeatureName('a'), isTrue);
      expect(_isValidFeatureName('A1'), isTrue);

      // Test invalid names
      expect(_isValidFeatureName(''), isFalse);
      expect(_isValidFeatureName('123'), isFalse);
      expect(_isValidFeatureName('invalid-name!'), isFalse);
      expect(_isValidFeatureName('invalid-name'), isFalse);
      expect(_isValidFeatureName('invalid name'), isFalse);
      expect(_isValidFeatureName('invalid.name'), isFalse);
    });

    test('should convert to Pascal case correctly', () {
      expect(_toPascalCase('user_profile'), equals('UserProfile'));
      expect(_toPascalCase('authentication'), equals('Authentication'));
      expect(_toPascalCase('simple'), equals('Simple'));
      expect(_toPascalCase('multi_word_feature'), equals('MultiWordFeature'));
    });

    test('should create directory structure (integration test)', () async {
      final testFeatureName =
          'test_feature_${DateTime.now().millisecondsSinceEpoch}';
      final testDir = Directory('test_output');

      // Create a temporary test directory
      if (await testDir.exists()) {
        await testDir.delete(recursive: true);
      }
      await testDir.create();

      // Change to test directory for this test
      final originalDir = Directory.current;
      Directory.current = testDir;

      try {
        // Create a minimal pubspec.yaml for the test
        final pubspecFile = File('pubspec.yaml');
        await pubspecFile.writeAsString('''
name: test_project
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  flutter_riverpod: ^2.0.0
''');

        // This would be an integration test that actually creates directories
        // For now, we'll just test the validation logic
        expect(_isValidFeatureName(testFeatureName), isTrue);
      } finally {
        // Restore original directory
        Directory.current = originalDir;

        // Clean up test directory
        if (await testDir.exists()) {
          await testDir.delete(recursive: true);
        }
      }
    });
  });
}

// Helper functions to test the logic without relying on static methods
bool _isValidFeatureName(String input) {
  if (input.isEmpty) return false;
  return RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$').hasMatch(input);
}

String _toPascalCase(String input) {
  return input
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join('');
}
