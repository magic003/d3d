part of d3d.selection;

class SelectionEnter extends Selection {
  
  SelectionEnter(List<List<Element>> groups) : super(groups);
  
  Selection select(selector) {
    selector = _ensureSelector(selector);

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
  
  // TODO learn how this work in d3.js. Make sure this works.
  Selection insert(String name, [Object beforeSelector]) {
    if (beforeSelector == null) {
      beforeSelector = _enterInsertBefore(this);
    }
    return super.insert(name, beforeSelector);
  }
  
  Selector _enterInsertBefore(SelectionEnter enter) {
    var i0 = -1, j0 = -1;
    return (Element node, data, int i, int j) {
      var group = _getUpdate(enter._groups[j]),
          n = group.length,
          node;
      
      if (j != j0) {
        j0 = j;
        i0 = 0;
      }
      
      if (i >= i0) i0 = i + 1;
      node = group[i0];
      while (node == null && (i0+1) < n) {
        i0++;
        node = group[i0];
      }
      
      return node;
    };
  }
}