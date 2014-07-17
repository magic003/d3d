import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  group('nodeClassed(name)', () {
    test('nodeClassed(name)', () {
      var sel = d3d.selectAll('div');
      expect(sel.nodeClassed('abc'), isFalse);
      expect(sel.nodeClassed('test'), isTrue);
      expect(sel.nodeClassed('abc test foo'), isFalse);
      expect(sel.nodeClassed('foo bar'), isTrue);
      expect(sel.nodeClassed('bar foo test'), isTrue);
    });
  });
  
  group('classed(name, value)', () {
    test('classed(name, true)', () {
      var sel = d3d.selectAll('div');
      var newSel = sel.classed('a b', true);
      expect(newSel, same(sel));
      expect(sel.nodeClassed('a'), isTrue);
      expect(sel.nodeClassed('b'), isTrue);
    });
    
    test('classed(name, false)', () {
      var sel = d3d.selectAll('div');
      var newSel = sel.classed('test bar', false);
      expect(newSel, same(sel));
      expect(sel.nodeClassed('test'), isFalse);
      expect(sel.nodeClassed('bar'), isFalse);
    });
  });
  
  group('classedMap(classes)', () {
    test('classedMap(classes)', () {
      var sel = d3d.selectAll('div');
      var classes = {'test bar': false, 'a b': true};
      var newSel = sel.classedMap(classes);
      expect(newSel, same(sel));
      expect(sel.nodeClassed('a b'), isTrue);
      expect(sel.nodeClassed('test bar'), isFalse);
    });
  });
}