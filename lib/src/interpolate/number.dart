part of d3d.interpolate;

typedef num InterNumber(num t);

InterNumber interpolateNumber(num a, num b) {
  b -= a;
  return (t) => a + b * t;
}