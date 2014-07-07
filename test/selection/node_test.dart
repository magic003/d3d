import 'dart:html';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  test('no node', () {
    var sel = d3d.select('span');
    
    expect(sel.node(), same(null));
  });
  
  test('one node', () {
    var sel = d3d.select('body');
    
    expect(sel.node(), same(document.querySelector('body')));
  });
  
  test('multiple nodes', () {
    var sel = d3d.selectAll('div');
    
    expect(sel.node(), same(document.querySelector('div')));
  });
}