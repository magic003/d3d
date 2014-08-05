part of d3d.arrays;

num max(List<num> array, [Function f]) {
  if (array == null || array.length == 0) {
    return null;
  }
  
  if (f == null) {
    f = (List<num> arr, int i) => arr[i];
  }
  var i = 0,
      n = array.length,
      mv = f(array, 0);
  
  while (++i < n) {
    var v = f(array, i);
    if (v > mv) {
      mv = v;
    }
  }
  
  return mv;
}