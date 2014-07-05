import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';

import 'package:d3d/d3d.dart' as d3d;

void main() {
  useHtmlEnhancedConfiguration();
  
  group('data(value)', () {
    test('data(list)', () {
      var sel = d3d.select('body').selectAll('div').data([1, 2, 3, 4]);
      
      expect(sel, new isInstanceOf<d3d.Selection>());
      expect(sel.enter(), new isInstanceOf<d3d.SelectionEnter>());
      expect(sel.exit(), new isInstanceOf<d3d.Selection>());
      
      sel = d3d.select('body').selectAll('div').data([1, 2]);
      
      expect(sel, new isInstanceOf<d3d.Selection>());
      expect(sel.enter(), new isInstanceOf<d3d.SelectionEnter>());
      expect(sel.exit(), new isInstanceOf<d3d.Selection>());
    });
    
    test('data(list, key)', () {
      var sel = d3d.select('body').selectAll('div').data(
          [{'k':'a', 'v': 1}, {'k':'a', 'v': 2}, {'k':'b', 'v': 2}]);
      
      expect(sel, new isInstanceOf<d3d.Selection>());
      expect(sel.enter(), new isInstanceOf<d3d.SelectionEnter>());
      expect(sel.exit(), new isInstanceOf<d3d.Selection>());
      
      var key = (data, int i) {
        return data['k'];
      };
      
      sel = sel.data([{'k':'b', 'v': 3}, {'k':'c', 'v':4}, {'k':'c', 'v':5}], key);
      
      expect(sel, new isInstanceOf<d3d.Selection>());
      expect(sel.enter(), new isInstanceOf<d3d.SelectionEnter>());
      expect(sel.exit(), new isInstanceOf<d3d.Selection>());
    });
  });
  
  group('data(groupData)', () {
    test('data(list)', () {
      var groupData = (group, data, i) {
        return [1, 2, 3, 4];
      };
      var sel = d3d.select('body').selectAll('div').data(groupData);
      
      expect(sel, new isInstanceOf<d3d.Selection>());
      expect(sel.enter(), new isInstanceOf<d3d.SelectionEnter>());
      expect(sel.exit(), new isInstanceOf<d3d.Selection>());
      
      groupData = (group, data, i) {
              return [1, 2];
      };
      sel = d3d.select('body').selectAll('div').data(groupData);
      
      expect(sel, new isInstanceOf<d3d.Selection>());
      expect(sel.enter(), new isInstanceOf<d3d.SelectionEnter>());
      expect(sel.exit(), new isInstanceOf<d3d.Selection>());
    });
    
    test('data(list, key)', () {
      var groupData = (group, data, i) {
        return [{'k':'a', 'v': 1}, {'k':'a', 'v': 2}, {'k':'b', 'v': 2}];
      };
      var sel = d3d.select('body').selectAll('div').data(groupData);
      
      expect(sel, new isInstanceOf<d3d.Selection>());
      expect(sel.enter(), new isInstanceOf<d3d.SelectionEnter>());
      expect(sel.exit(), new isInstanceOf<d3d.Selection>());
      
      groupData = (group, data, i) {
        return [{'k':'b', 'v': 3}, {'k':'c', 'v':4}, {'k':'c', 'v':5}];
      };
      var key = (data, int i) {
        return data['k'];
      };
      
      sel = sel.data(groupData, key);
      
      expect(sel, new isInstanceOf<d3d.Selection>());
      expect(sel.enter(), new isInstanceOf<d3d.SelectionEnter>());
      expect(sel.exit(), new isInstanceOf<d3d.Selection>());
    });
  });
}