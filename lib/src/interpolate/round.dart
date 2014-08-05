part of d3d.interpolate;

InterNumber interpolateRound(num a, num b) {
  b -= a;
  return (t) => (a + b * t).round();
}