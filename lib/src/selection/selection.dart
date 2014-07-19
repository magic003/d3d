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

// TODO refactor the function types, to define one for the same signatures

typedef Element Selector(Element node, data, int i, int j);

typedef List<Element> SelectorAll(Element node, data, int i, int j);

typedef String DataKey(data, int i);

typedef dynamic GroupData(List<Element> group, data, int i);

typedef void EachCallback(Element node, data, int i, int j);

typedef String StyleValueFunc(Element node, data, int i, int j);

typedef String TextValueFunc(Element node, data, int i, int j);

typedef String AttrValueFunc(Element node, data, int i, int j);

typedef void SelectionCallback(Selection sel);

typedef String ClassedValueFunc(Element node, data, int i, int j);

typedef Object DatumValueFunc(Element node, data, int i, int j);

typedef bool FilterFunc(Element node, data, int i, int j);

typedef String HtmlValueFunction(Element node, data, int i, int j);

class Selection {
  List<List<Element>> _groups;
  
  Selection _enter;
  Selection _exit;
  
  Selection(List<List<Element>> groups): _groups = groups;

  Selection select(selector) {
    if (selector is String) {
      var str = selector;
      selector = (Element node, data, int i, int j) {
        return node.querySelector(str);
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
      return node.append(nameCreator(node));
    });
  }
  
  Selection each(EachCallback callback) {
    for (int j = 0, m = _groups.length; j < m; j++) {
      var group = _groups[j];
      for (int i = 0, n = group.length; i < n; i++) {
        var node = group[i];
        if (node != null) {
          callback(node, _getNodeData(node), i, j);
        }
      }
    }
    
    return this;
  }
  
  Selection style(String name, [Object value, String priority = ""]) {
    if (value == null) {
      _styleNull(name);
    } else if (value is StyleValueFunc) {
      _styleFunction(name, value, priority);
    } else {
      _styleConstant(name, value, priority);
    }
    
    return this;
  }
  
  Selection styleMap(Map<String, Object> styles, [String priority = ""]) {
    styles.forEach((String name, Object value) {
      style(name, value, priority);
    });
    
    return this;
  }
  
  void _styleNull(String name) {
    each((node, data, i, j) {
      node.style.removeProperty(name);
    });
  }
  
  void _styleConstant(String name, String value, [String priority = ""]) {
    each((node, data, i, j) {
      node.style.setProperty(name, value, priority);
    });
  }
  
  void _styleFunction(String name, StyleValueFunc value, [String priority = ""]) {
    each((node, data, i, j) {
      var v = value(node, data, i, j);
      if (v == null) {
        node.style.removeProperty(name);
      } else {
        node.style.setProperty(name, v, priority);
      }
    });
  }
  
  Element get node {
    for (int j = 0, m = _groups.length; j < m; j++) {
      var group = _groups[j];
      for (int i = 0, n = group.length; i < n; i++) {
        var node = group[i];
        if (node != null) {
          return node;
        }
      }
    }
    
    return null;
  }
  
  String get nodeText => node == null ? null : node.text;
  
  Selection text(Object value) {
    return each((node, data, i, j) {
      var v = value;
      if (value is TextValueFunc) {
        v = value(node, data, i, j);
      }
      
      node.text = v == null ? '' : v;
    });
  }
  
  String nodeAttr(String name) {
    var n = node;
    var ns = new NS.qualify(name);
    return ns.space == null ? node.getAttribute(ns.local) : 
      node.getAttributeNS(ns.space, ns.local);
  }
  
  Selection attr(String name, [Object value]) {
    var ns = new NS.qualify(name);
    
    if (value == null) {
      _attrNull(ns);
    } else if (value is AttrValueFunc) {
      _attrFunction(ns, value);
    } else {
      _attrConstant(ns, value);
    }
    
    return this;
  }
  
  Selection attrMap(Map<String, Object> attrs) {
    attrs.forEach((n, v) {
      attr(n, v);
    });
    
    return this;
  }
  
  void _attrNull(NS name) {
    each((node, data, i, j) {
      if (name.space == null) {
        node.attributes.remove(name.local);
      } else {
        node.getNamespacedAttributes(name.space).remove(name.local);
      }
    });
  }
  
  void _attrFunction(NS name, AttrValueFunc value) {
    each((node, data, i, j) {
      var v = value(node, data, i, j);
      if (v == null) {
        if (name.space == null) {
          node.attributes.remove(name.local);
        } else {
          node.getNamespacedAttributes(name.space).remove(name.local);
        }
      } else {
        if (name.space == null) {
          node.setAttribute(name.local, v);
        } else {
          node.setAttributeNS(name.space, name.local, v);
        }
      }
    });
  }
  
  void _attrConstant(NS name, String value) {
    each((node, data, i, j) {
      if (name.space == null) {
        node.setAttribute(name.local, value);
      } else {
        node.setAttributeNS(name.space, name.local, value);
      }
    });
  }
  
  Selection call(SelectionCallback callback) {
    callback(this);
    
    return this;
  }
  
  bool nodeClassed(String name) {
    var names = _classes(name),
        classes = node.classes;
    for (var i = 0, n = names.length; i < n; i++) {
      if (!classes.contains(names[i])) {
        return false;
      }
    }
    
    return true;
  }
  
  Selection classed(String name, Object value) {
    if (value is ClassedValueFunc) {
      _classedFunction(name, value);
    } else {
      _classedConstant(name, value);
    }
    
    return this;
  }
  
  Selection classedMap(Map<String, Object> classes) {
    classes.forEach((n, v) {
      classed(n, v);
    });
    
    return this;
  }
  
  List<String> _classes(String name) {
    return name.trim().split(new RegExp(r'^|\s+'));
  }
  
  void _classedConstant(String name, Object value) {
    var names = _classes(name);
    each((node, data, i, j) {
      for (var i = 0, n = names.length; i < n; i++) {
        (value != null && value != false) ? node.classes.add(names[i]) : node.classes.remove(names[i]);
      }
    });
  }
  
  void _classedFunction(String name, ClassedValueFunc value) {
    var names = _classes(name);
    each((node, data, i, j) {
      var v = value(node, data, i, j);
      for (var i = 0, n = names.length; i < n; i++) {
        (v != null && v != false) ? node.classes.add(names[i]) : node.classes.remove(names[i]);
      }
    });
  }
  
  Object get nodeDatum => _getNodeData(node);
  
  Selection datum(Object value) {
    if (value is DatumValueFunc) {
      _datumFunction(value);
    } else {
      _datumConstant(value);
    }
    
    return this;
  }
  
  void _datumFunction(DatumValueFunc value) {
    each((node, data, i, j) {
      var v = value(node, data, i, j);
      _setNodeData(node, v);
    });
  }
  
  void _datumConstant(Object value) {
    each((node, data, i, j) {
      _setNodeData(node, value);
    });
  }
  
  bool get isEmpty => node == null;
  
  Selection filter(Object filter) {
    if (!(filter is FilterFunc)) {
      var f = filter;
      filter = (Element node, data, i, j) => node.matches(f);
    }
    
    var newGroups = [];
    for (int j = 0, m = _groups.length; j < m; j++) {
      var newGroup = [],
          group = _groups[j];
      newGroups.add(newGroup);
      _setParentNode(newGroup, _getParentNode(group));
      for (int i = 0, n = group.length; i < n; i++) {
        var node = group[i];
        if (node != null && filter(node, _getNodeData(node), i, j)) {
          newGroup.add(node);
        }
      }
    }
    
    return new Selection(newGroups);
  }
  
  String get nodeHtml => node.innerHtml;
  
  Selection html(Object value) {
    return each((Element node, data, int i, int j) {
      var v = value;
      if (value is HtmlValueFunction) {
        v = value(node, data, i, j);
      }
      
      node.innerHtml = v == null ? '' : v;
    });
  }
}
