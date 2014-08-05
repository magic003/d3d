import 'package:unittest/unittest.dart';
import 'package:d3d/src/arrays/arrays.dart' as d3d;

void main() {
  test('ascending', () {
    expect(d3d.ascending(1, 2), equals(-1));
    expect(d3d.ascending(1, 1), equals(0));
    expect(d3d.ascending(2, 1), equals(1));
  });
  
  test('bisect', () {
    var a = [1, 3, 4, 5, 7, 9];
    expect(d3d.bisectLeft(a, 6), equals(4));
    expect(d3d.bisectLeft(a, 5), equals(3));
    
    expect(d3d.bisectRight(a, 6), equals(4));
    expect(d3d.bisectRight(a, 5), equals(4));
  });
  
  test('max', () {
    var a = [10, 2, 1, 3, 5];
    expect(d3d.max(a), equals(10));
    
    a = [2, 3, 5, 1, 4, 2];
    expect(d3d.max(a), equals(5));
    
    a = [7, 2, 3, 5, 1, 10];
    expect(d3d.max(a), equals(10));
    
    a = [2, -1, -20, 19, 7];
    expect(d3d.max(a, (arr, i) => arr[i] > 0 ? arr[i] : -arr[i]), equals(20));
  });
}