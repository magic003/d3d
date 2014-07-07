import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();

  group('style', () {
    test('styleNull', () {
      var sel = d3d.selectAll('div');

      var newSel = sel.style('height');
      expect(newSel, same(sel));
    });

    test('styleConstant', () {
      var sel = d3d.selectAll('div');

      var newSel = sel.style('height', '100px');
      expect(newSel, same(sel));
    });

    test('styleFunction', () {
      var sel = d3d.selectAll('div');

      var func = (node, data, i, j) {
        return '100px';
      };

      var newSel = sel.style('height', func);
      expect(newSel, sel);
    });

    test('with priority', () {
      var sel = d3d.selectAll('div');
      var newSel = sel.style('height', '100px', '!important');
      expect(newSel, same(sel));
    });
  });

  group('styleMap', () {
    test('styleNull', () {
      var sel = d3d.selectAll('div');
      var newSel = sel.styleMap({
        'height': null
      });
      expect(newSel, same(sel));
    });

    test('styleConstant', () {
      var sel = d3d.selectAll('div');

      var newSel = sel.styleMap({
        'height': '100px'
      });
      expect(newSel, same(sel));
    });

    test('styleFunction', () {
      var sel = d3d.selectAll('div');

      var func = (node, data, i, j) {
        return '100px';
      };

      var newSel = sel.styleMap({'height': func});
      expect(newSel, sel);
    });
    
    test('width priority', () {
      var sel = d3d.selectAll('div');
      var newSel = sel.styleMap({'height': '100px'}, '!important');
      expect(newSel, same(sel));
    });
  });
}
