part of d3d.scale;

ScaleNumber _bilinear(List<num> domain, List<num> range, 
                      Function uninterpolate, Function interpolate) {
  var u = uninterpolate(domain[0], domain[1]),
      i = interpolate(range[0], range[1]);
  
  return (x) => i(u(x));
}