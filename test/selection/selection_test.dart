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

  group('selectAll', () {
    test('select(void)', () {
      var sel = d3d.selectAll();
      expect(sel, new isInstanceOf<d3d.Selection>());
    });

    test('selectAll(document)', () {
      var sel = d3d.selectAll(document);
      expect(sel, new isInstanceOf<d3d.Selection>());
    });

    test('selectAll(body)', () {
      var sel = d3d.selectAll('body');
      expect(sel, new isInstanceOf<d3d.Selection>());

      sel = d3d.selectAll(document.querySelector('body'));
      expect(sel, new isInstanceOf<d3d.Selection>());
    });

    test('selectAll(div)', () {
      var sel = d3d.selectAll('div');
      expect(sel, new isInstanceOf<d3d.Selection>());

      sel = d3d.selectAll(document.querySelectorAll('div'));
      expect(sel, new isInstanceOf<d3d.Selection>());
    });
  });

}
