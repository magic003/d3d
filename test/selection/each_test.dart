import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  test('each()', () {
    var sel = d3d.select('div');
    
    var newSel = sel.each((node, data, i, j) => {});
    expect(newSel, same(sel));
  });
}