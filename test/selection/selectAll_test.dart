import 'dart:html';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();

  group('selection.select', () {
    test('select(string)', () {
      var sel = d3d.select('body').select('div');
      expect(sel, new isInstanceOf<d3d.Selection>());

      sel = d3d.selectAll('div').selectAll('span');
      expect(sel, new isInstanceOf<d3d.Selection>());
    });

    test('select(func)', () {
      var selector = (node, data, i, j) {
        node.querySelector('div');
      };

      var sel = d3d.select('body').select(selector);
      expect(sel, new isInstanceOf<d3d.Selection>());

      sel = d3d.selectAll('div').selectAll(selector);
      expect(sel, new isInstanceOf<d3d.Selection>());
    });
  });
}
