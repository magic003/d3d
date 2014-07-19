import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  test('insert(name, selector)', () {
    var sel = d3d.selectAll('div');
    var newSel = sel.insert('input', 'span');
    expect(newSel.length, equals(sel.length));
    expect(newSel.node.nodeName, equalsIgnoringCase('input'));
  });
}