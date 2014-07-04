library d3d.selection;

import 'dart:html';
import 'package:d3d/src/core/core.dart';

part 'expando.dart';

Selection select([node]) {
  if (node == null) {
    node = d3dDocument;
  }
  
  var group = [(node is String) ? d3dDocument.querySelector(node) : node];
  _setParentNode(group, d3dDocumentElement);
  return new Selection([group]);
}

Selection selectAll([nodes]) {
  if (nodes == null) {
    nodes = d3dDocument;
  }
  
  var group = (nodes is String) ? d3dDocument.querySelectorAll(nodes) : nodes;
  if (!(group is List)) {
    group = [group];
  }
  
  _setParentNode(group, d3dDocumentElement);
  return new Selection([group]);
}

typedef Element Selector(Element node, Object data, int i, int j);

class Selection {
  List<List<Element>> _groups;

  Selection(List<List<Element>> groups): _groups = groups;

  Selection select(selector) {
    if (selector is String) {
      var str = selector;
      selector = (Element node, Object data, int i, int j) {
        node.querySelector(str);
      };
    }

    var newGroups = [];   
    for (var i = 0, m = _groups.length; i < m; i++) {
      var newGroup = [],
          group = _groups[i];
      
      newGroups.add(newGroup);
      _setParentNode(newGroup, _getParentNode(group));
      
      for (var j = 0, n = group.length; j < n; j++) {
        var node = group[j];
        if (node != null) {
          var data = _getNodeData(node),
              newNode = selector(node, data, j, i);
          
          newGroup.add(newNode);
          if (newNode != null && data != null) {
            _setNodeData(newNode, data);
          }
        } else {
          newGroup.add(null);
        }
      }
    }
    
    return new Selection(newGroups);
  }
}
