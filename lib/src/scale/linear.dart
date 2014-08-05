part of d3d.scale;

Linear linear() {
  return new Linear([0, 1], [0, 1], interpolate, false);
}

class Linear {
  List<num> _domain;
  List<num> _range;
  Function _interpolate;
  bool _clamp;
  ScaleNumber _output, _input;
  
  Linear(List<num> domain, List<num> range, Function interpolate, bool clamp)
      : _domain = domain,
        _range = range,
        _interpolate = interpolate,
        _clamp = clamp {
    _rescale();
  }
  
  num call(num x) {
    return _output(x);
  }
  
  num invert(num y) {
    return _input(y);
  }
  
  List<num> get domain => _domain;
  
  Linear setDomain(List<num> x) {
    _domain = new List<num>.from(x, growable: false);
    return _rescale();
  }
  
  List<num> get range => _range;
  
  Linear setRange(List<num> x) {
    _range = new List<num>.from(x, growable: false);
    return _rescale();
  }
  
  Linear setRangeRound(List<num> x) {
    return setRange(x).setInterpolate(interpolateRound);  
  }
  
  bool get clamp => _clamp;
  
  Linear setClamp(bool x) {
    _clamp = x;
    return _rescale();
  }
  
  Function get interpolate => _interpolate;
  
  Linear setInterpolate(Function x) {
    _interpolate = x;
    return _rescale();
  }
  
  Linear _rescale() {
    var linear = min(_domain.length, _range.length) > 2 ? _polylinear : _bilinear,
        uninterpolate = _clamp ? uninterpolateNumber : uninterpolateNumber;
    _output = linear(_domain, _range, uninterpolate, _interpolate);
    _input = linear(_domain, _range, uninterpolate, interpolate);
    
    return this;
  }
}