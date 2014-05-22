library d3d.selection;

import 'package:d3d/src/core.dart';

part 'expando.dart'

Selection select(node) {
  var group = [(node is String) ? d3dDocument.querySelector(node) : node];
  _setParentNode(group, d3dDocumentElement);
}
