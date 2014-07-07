part of d3d.selection;

class SelectionEnter extends Selection {
  
  SelectionEnter(List<List<Element>> groups) : super(groups);
  
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
          group = _groups[i],
          parentNode = _getParentNode(group),
          upgroup = _getUpdate(group);
      
      newGroups.add(newGroup);
      _setParentNode(newGroup, parentNode);
      
      for (var j = 0, n = group.length; j < n; j++) {
        var node = group[j];
        if (node != null) {
          var data = _getNodeData(node),
              newNode = selector(parentNode, data, j, i);
          
          upgroup[j] = newNode;
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