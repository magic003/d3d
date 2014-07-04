part of d3d.selection;

final _parentProp = new Expando<Node>('parentNode');

void _setParentNode(List<Element> group, Node node) {
  _parentProp[group] = node;
}

Node _getParentNode(List<Element> group) {
  return _parentProp[group];
}

final _dataProp = new Expando<Object>('data');

void _setNodeData(Node node, Object data) {
  _dataProp[node] = data;
}

Object _getNodeData(Node node) {
  return _dataProp[node];
}

bool _hasNodeData(Node node) {
  return _dataProp[node] != null;
}
