part of d3d.selection;

final _parentProp = new Expando<Node>('parentNode');

void _setParentNode(List<Element> group, Node node) {
  _parentProp[group] = node;
}
