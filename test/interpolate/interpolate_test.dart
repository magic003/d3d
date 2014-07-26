import 'package:unittest/unittest.dart';
import 'package:d3d/src/interpolate/interpolate.dart' as d3d;

void main() {
  test('interpolate', () {
    var inter = d3d.interpolate(1, 2);
    expect(inter, isNotNull);
  });
}