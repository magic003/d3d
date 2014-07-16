import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  test('call()', () {
    var sel = d3d.selectAll('div');
    var call = (d3d.Selection sel) {
      sel.attr('class');
    };
    
    var newSel = sel.call(call);
    expect(sel.nodeAttr('class'), isNull);
    expect(newSel, same(sel));
  });
}