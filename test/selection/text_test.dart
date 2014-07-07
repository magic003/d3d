import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();

  group('text(value)', () {
    test('text(string)', () {
      var sel = d3d.selectAll('div');
      var newSel = sel.text('test');

      expect(newSel, same(sel));
      sel.each((node, data, i, j) {
        expect(node.text, equals('test'));
      });

      sel = d3d.selectAll('div');
      newSel = sel.text(null);

      expect(newSel, same(sel));
      sel.each((node, data, i, j) {
        expect(node.text, equals(''));
      });
    });
    
    test('text(function)', () {
      var sel = d3d.selectAll('div');
      var newSel = sel.text((node, data, i, j) => 'test');

      expect(newSel, same(sel));
      sel.each((node, data, i, j) {
        expect(node.text, equals('test'));
      });

      sel = d3d.selectAll('div');
      newSel = sel.text((node, data, i, j) => null);

      expect(newSel, same(sel));
      sel.each((node, data, i, j) {
        expect(node.text, equals(''));
      });
    });
  });
  
  group('nodeText()', () {
    
    test('null', () {
      var sel = d3d.selectAll('span');
      
      expect(sel.nodeText, isNull);
    });
    
    test('empty text', () {
      var sel = d3d.selectAll('div');
      
      expect(sel.nodeText, equals(''));
    });
    
    test('has text', () {
      var sel = d3d.selectAll('div').text('test');
      expect(sel.nodeText, equals('test'));
    });
  });
}
