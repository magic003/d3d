part of d3d.scale;

ScaleNumber _polylinear(List<num> domain, List<num> range, 
                      Function uninterpolate, Function interpolate) {
  var u = [],
      i = [],
      j = 0,
      k = min(domain.length, range.length) - 1;
  
  // Handle descending domains.
  if (domain[k] < domain[0]) {
    domain = domain.reversed.toList(growable: true);
    range = range.reversed.toList(growable: true);
  }
  
  while (++j <= k) {
    u.add(uninterpolate(domain[j-1], domain[j]));
    i.add(interpolate(range[j-1], range[j]));
  }
  
  return (x) {
    var j = bisect(domain, x, 1, k) - 1;
    return i[i](u[i](x));
  };
}