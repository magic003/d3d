import 'package:unittest/unittest.dart';
import 'package:d3d/src/interpolate/interpolate.dart' as d3d;

void main() {
  test('uninterpolateNumber', () {
    var uninter = d3d.uninterpolateNumber(0, 10);
    expect(uninter(0), equals(0));
    expect(uninter(2), equals(0.2));
    expect(uninter(10), equals(1));
    
    uninter = d3d.uninterpolateNumber(1, 1);
    expect(uninter(1), equals(0));
  });
  
  test('uninterpolateClamp', () {
    var uninter = d3d.uninterpolateClamp(1, 3);
    expect(uninter(0), equals(0));
    expect(uninter(1), equals(0));
    expect(uninter(2), equals(0.5));
    expect(uninter(3), equals(1));
    expect(uninter(4), equals(1));
  });
}