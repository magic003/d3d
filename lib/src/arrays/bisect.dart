part of d3d.arrays;

class _Bisector<T> {
  Comparator _comp;
  
  _Bisector(Comparator comparator): _comp = comparator;
  
  int left(List<T> a, T x, [int lo, int hi]) {
    if (lo == null) lo = 0;
    if (hi == null) hi = a.length;
    
    while (lo < hi) {
      int mid = ((lo + hi) & 0XFFFFFFFF) >> 1;
      if (_comp(a[mid], x) < 0) {
        lo = mid + 1;
      } else {
        hi = mid;
      }
    }
    
    return lo;
  }
  
  int right(List<T> a, T x, [int lo, int hi]) {
    if (lo == null) lo = 0;
    if (hi == null) hi = a.length;
    
    while (lo < hi) {
      int mid = ((lo + hi) & 0XFFFFFFFF) >> 1;
      if (_comp(a[mid], x) > 0) {
        hi = mid;
      } else {
        lo = mid + 1;
      }
    }
    
    return lo;
  }
}

var _bisector = new _Bisector(ascending);

var bisectLeft = _bisector.left;
var bisectRight = _bisector.right;
var bisect = bisectRight;