library d3d.selection;

import 'dart:html';
import 'dart:math';
import 'package:d3d/src/core/core.dart';

part 'expando.dart';
part 'enter.dart';

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

typedef Element Selector(Element node, data, int i, int j);

typedef List<Element> SelectorAll(Element node, data, int i, int j);

typedef String DataKey(data, int i);

typedef dynamic GroupData(List<Element> group, data, int i);

class Selection {
  List<List<Element>> _groups;
  
  Selection _enter;
  Selection _exit;
  
  Selection(List<List<Element>> groups): _groups = groups;

  Selection select(selector) {
    if (selector is String) {
      var str = selector;
      selector = (Element node, data, int i, int j) {
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

  Selection selectAll(selector) {
    if (selector is String) {
      var str = selector;
      selector = (Element node, data, int i, int j) {
        return node.querySelectorAll(str);
      };
    }

    var newGroups = [];   
    for (var i = 0, m = _groups.length; i < m; i++) {
      for (var j = 0, group = _groups[i], n = group.length; j < n; j++) {
        var node = group[j];
        if (node != null) {
          var newGroup = selector(node, _getNodeData(node), j, i);
          newGroups.add(newGroup);
          _setParentNode(newGroup, node);
        }
      }
    }
    
    return new Selection(newGroups);
  }

  Selection data(value, [DataKey key]) {

    var enter = new SelectionEnter([]),
        update = new Selection([]),
        exit = new Selection([]);
    
    var newDataNode = (data) {
      // TODO is there a better way?
      var node = new Element.tag('x-data');
      _setNodeData(node, data);
      return node;
    };
    
    var bind = (group, groupData) {
      var n = group.length,
          m = groupData.length,
          updateNodes = new List<Element>(m),
          enterNodes = new List<Element>(m),
          exitNodes = new List<Element>(n);
      
      if (key != null) {
        var nodeByKeyValue = new Map<String, Element>(),
            dataByKeyValue = new Map<String, dynamic>(),
            keyValues = [];
        
        for (int i = 0; i < n; i++) {
          var node = group[i],
              keyValue = key(_getNodeData(node), i);
          
          if (nodeByKeyValue.containsKey(keyValue)) {
            exitNodes[i] = node; // duplicate selection key
          } else {
            nodeByKeyValue.putIfAbsent(keyValue, () => node);
          }
          
          keyValues.add(keyValue);
        }
        
        for (int i = 0; i < m; i++) {
          var nodeData = groupData[i],
              keyValue = key(nodeData, i),
              node = nodeByKeyValue[keyValue];
          
          if (node != null) {
            updateNodes[i] = node;
            _setNodeData(node, nodeData);
          } else if (!dataByKeyValue.containsKey(keyValue)) { // no duplicate data key
            enterNodes[i] = newDataNode(nodeData);
          }
          
          dataByKeyValue.putIfAbsent(keyValue, () => nodeData);
          nodeByKeyValue.remove(keyValue);
        }
        
        for (int i = 0; i < n; i++) {
          if (nodeByKeyValue.containsKey(keyValues[i])) {
            exitNodes[i] = group[i];
          }
        }
      } else {
        var n0 = min(n, m),
            i;
        for (i = 0; i < n0; i++) {
          var node = group[i],
              nodeData = groupData[i];
          if (node != null) {
            updateNodes[i] = node;
            _setNodeData(node, nodeData);
          } else {
            enterNodes[i] = newDataNode(nodeData);
          }
        }
        
        for (; i < m; i++) {
          enterNodes[i] = newDataNode(groupData[i]);
        }
        
        for (; i < n; i++) {
          exitNodes[i] = group[i];
        }
      }
      
      _setUpdate(enterNodes, updateNodes);
      
      var parentNode = _getParentNode(group);
      _setParentNode(enterNodes, parentNode);
      _setParentNode(updateNodes, parentNode);
      _setParentNode(exitNodes, parentNode);
      
      enter._groups.add(enterNodes);
      update._groups.add(updateNodes);
      exit._groups.add(exitNodes);
    };
    
    var n = _groups.length;
    if (value is GroupData) {
      for (int i = 0; i < n; i++) {
        var group = _groups[i];
        bind(group, value(group, _getNodeData(_getParentNode(group)), i));
      }
    } else {
      for (int i = 0; i < n; i++) {
        bind(_groups[i], value);
      }
    }
    
    update._enter = enter;
    update._exit = exit;
    
    return update;
  }
  
  Selection enter() {
    return _enter;
  }
  
  Selection exit() {
    return _exit;
  }
  
  Selection append(name) {
    var nameCreator = name;
    if (name is String) {
      name = new NS.qualify(name);
      
      nameCreator = (node) {
        var space = name.space == null ? node.namespaceUri : name.space;
        return node.ownerDocument.createElementNS(space, name.local);
      };
    }
    
    return select((Element node, data, int i, int j) {
      node.append(nameCreator(node));
    });
  }
}
