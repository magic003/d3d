import 'dart:html';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  test('append(string)', () {
    var sel = d3d.select('div');
    
    sel = sel.append('span');
    expect(sel, new isInstanceOf<d3d.Selection>());
    
    sel = d3d.selectAll('div');
    sel = sel.append('span');
    expect(sel, new isInstanceOf<d3d.Selection>());
  });
  
  test('append(function)', () {
    var creator = (Element node) {
      return node.ownerDocument.createElement('span');
    };
    
    var sel = d3d.select('div');
    
    sel = sel.append(creator);
    expect(sel, new isInstanceOf<d3d.Selection>());
    
    sel = d3d.selectAll('div');
    sel = sel.append(creator);
    expect(sel, new isInstanceOf<d3d.Selection>());
  });
}