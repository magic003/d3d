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

class Selection {
  List<List<Element>> _groups;

  Selection(List<List<Element>> groups): _groups = groups;
}
