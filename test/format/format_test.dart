import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  group('requote()', () {
    test('requote()', () {
      expect(d3d.requote('\\test\\t\\'), equals('\\\\test\\\\t\\\\'));
      expect(d3d.requote('^test^t^'), equals('\\^test\\^t\\^'));
      expect(d3d.requote('\$test\$t\$'), equals('\\\$test\\\$t\\\$'));
      expect(d3d.requote('*test*t*'), equals('\\*test\\*t\\*'));
      expect(d3d.requote('+test+t+'), equals('\\+test\\+t\\+'));
      expect(d3d.requote('?test?t?'), equals('\\?test\\?t\\?'));
      expect(d3d.requote('[test]t}}'), equals('\\[test\\]t\\}\\}'));
    });
  });
}