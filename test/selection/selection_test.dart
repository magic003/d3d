import 'dart:html';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();


  group('select', () {
    test('select(void)', () {
      var sel = d3d.select();
      expect(sel, new isInstanceOf<d3d.Selection>());
    });

    test('select(document)', () {
      var sel = d3d.select(document);
      expect(sel, new isInstanceOf<d3d.Selection>());
    });

    test('select(body)', () {
      var sel = d3d.select('body');
      expect(sel, new isInstanceOf<d3d.Selection>());

      sel = d3d.select(document.querySelector('body'));
      expect(sel, new isInstanceOf<d3d.Selection>());
    });

    test('select(div)', () {
      var sel = d3d.select('div');
      expect(sel, new isInstanceOf<d3d.Selection>());

      sel = d3d.select(document.querySelector('div'));
      expect(sel, new isInstanceOf<d3d.Selection>());
    });
  });
}
