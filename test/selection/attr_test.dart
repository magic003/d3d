import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  group('nodeAttr', () {
    test('nodeAttr() is null', () {
      var attr = d3d.selectAll('div').nodeAttr('style');
      expect(attr, isNull);
    });
    
    test('nodeAttr() is not null', () {
      var attr = d3d.selectAll('div').nodeAttr('class');
      expect(attr, equals('test'));
    });
  });
  
  group('attr', () {
    test('attr(name)', () {
      var sel = d3d.selectAll('div');
      sel.attr('class');
      expect(sel.nodeAttr('class'), isNull);
    });
    
    test('attr(name, func)', () {
      var sel = d3d.selectAll('div');
      sel.attr('class', (node, data, i, j) => 'foobar');
      expect(sel.nodeAttr('class'), equals('foobar'));
    });
    
    test('attr(name, const)', () {
      var sel = d3d.selectAll('div');
      sel.attr('class', 'foobar');
      expect(sel.nodeAttr('class'), equals('foobar'));
    });
  });
  
  group('attrMap', () {
    test('attrMap(map)', () {
      var sel = d3d.selectAll('div');
      var map = {'class': null, 'title': 'test', 'style': (node, data, i, j) => 'test'};
      sel.attrMap(map);
      
      expect(sel.nodeAttr('class'), isNull);
      expect(sel.nodeAttr('title'), equals('test'));
      expect(sel.nodeAttr('style'), equals('test'));
    });
  });
}