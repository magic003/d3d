part of d3d.interpolate;

InterNumber interpolateNumber(num a, num b) {
  b -= a;
  return (t) => a + b * t;
}