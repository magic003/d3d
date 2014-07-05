part of d3d.selection;

final _parentProp = new Expando<Node>('parentNode');

void _setParentNode(List<Element> group, Node node) {
  _parentProp[group] = node;
}

Node _getParentNode(List<Element> group) {
  return _parentProp[group];
}

final _dataProp = new Expando<Object>('data');

void _setNodeData(Element node, Object data) {
  _dataProp[node] = data;
}

Object _getNodeData(Element node) {
  return _dataProp[node];
}

bool _hasNodeData(Element node) {
  return _dataProp[node] != null;
}

final _updateProp = new Expando<List<Element>>('update');

void _setUpdate(List<Element> enter, List<Element> update) {
  _updateProp[enter] = update;
}

List<Element> _getUpdate(List<Element> enter) {
  return _updateProp[enter];
}
