part of d3d.interpolate;

InterNumber uninterpolateNumber(num a, num b) {
  b = (b - a) == 0 ? 0 : 1.0 / (b - a);
  return (x) => (x - a) * b;
}

InterNumber uninterpolateClamp(num a, num b) {
  b = (b - a) == 0 ? 0 : 1.0 / (b - a);
  return (x) => max(0, min(1, (x - a) * b));
}