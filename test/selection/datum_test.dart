import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  group('nodeDatum()', () {
    test('nodeDatum()', () {
      var sel = d3d.selectAll('div');
      expect(sel.nodeDatum, isNull);
    });
  });
  
  group('datum(value)', () {
    test('datum(constant)', () {
      var sel = d3d.selectAll('div').datum('test');
      expect(sel.nodeDatum, equals('test'));
    });
    
    test('datum(function)', () {
      var sel = d3d.selectAll('div').datum((node, data, i, j) => 'test');
      expect(sel.nodeDatum, equals('test'));
    });
  });
}