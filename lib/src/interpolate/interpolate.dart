library d3d.interpolate;

import 'dart:math';

part 'number.dart';
part 'uninterpolate.dart';


typedef Object InterFunc(Object a);

typedef InterFunc Interpolator(Object a, Object b);


final List<Interpolator> interpolators = [
  (Object a, Object b) {
    if (b is num) {
      return interpolateNumber(a, b);
    }
  }
];

InterFunc interpolate(Object a, Object b) {
  var i = interpolators.length;
  
  while (--i >= 0) {
    var f = interpolators[i](a, b);
    if (f != null) {
      return f;
    }
  }
  
  return null;
}