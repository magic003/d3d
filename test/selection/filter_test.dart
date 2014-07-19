import 'dart:html';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  test('filter(string)', () {
    var sel = d3d.selectAll('div');
    
    var newSel = sel.filter('.test');
    expect(newSel.isEmpty, isFalse);
    
    newSel = sel.filter('.notest');
    expect(newSel.isEmpty, isTrue);
  });
  
  test('filter(function)', () {
    var sel = d3d.selectAll('div');
    var filter = (Element node, data, i, j) => node.classes.contains('test');
    
    var newSel = sel.filter(filter);
    expect(newSel.isEmpty, isFalse);
    
    filter = (Element node, data, i, j) => node.classes.contains('notest');
    newSel = sel.filter(filter);
    expect(newSel.isEmpty, isTrue);
  });
}