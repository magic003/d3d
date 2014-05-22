part of selection;

final _parentProp = new Expando<Node>('parentNode');

void _setParentNode(List<Element> group, Node node) {
  parentProp[group] = node;
}
