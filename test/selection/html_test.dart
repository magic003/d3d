import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  group('nodeHtml', () {
    test('nodeHtml', () {
      var sel = d3d.selectAll('div');
      expect(sel.nodeHtml, equals('test'));
    });
  });
  
  group('html(value)', () {
    test('html(null)', () {
      var sel = d3d.selectAll('div');
      sel.html(null);
      expect(sel.nodeHtml, equals(''));
    });
    
    test('html(string)', () {
      var sel = d3d.selectAll('div');
      sel.html('foo');
      expect(sel.nodeHtml, equals('foo'));
    });
    
    test('html(function)', () {
      var sel = d3d.selectAll('div');
      sel.html((node, data, i, j) => 'foo');
      expect(sel.nodeHtml, equals('foo'));
    });
  });
}