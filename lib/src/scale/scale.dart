library d3d.scale;

import 'dart:math';

import 'package:d3d/src/interpolate/interpolate.dart';
import 'package:d3d/src/arrays/arrays.dart';

part 'linear.dart';
part 'bilinear.dart';
part 'polylinear.dart';


typedef num ScaleNumber(num x);