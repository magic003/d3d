import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  test('empty()', () {
    var sel = d3d.selectAll('div');
    expect(sel.isEmpty, isFalse);
    
    sel = d3d.selectAll('span');
    expect(sel.isEmpty, isTrue);
  });
}