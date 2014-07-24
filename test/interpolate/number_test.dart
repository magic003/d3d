import 'package:unittest/unittest.dart';
import 'package:d3d/src/interpolate/interpolate.dart' as d3d;

void main() {
  test('interPolateNumber', () {
    var f = d3d.interpolateNumber(0, 5);
    expect(f(0.2), equals(1));
    expect(f(0), equals(0));
    expect(f(1), equals(5));
    
    f = d3d.interpolateNumber(5, 0);
    expect(f(0.2), equals(4));
    expect(f(0), equals(5));
    expect(f(1), equals(0));
  });
}