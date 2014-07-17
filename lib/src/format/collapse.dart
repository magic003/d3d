part of d3d.format;

String collapse(String s) {
  return s.trim().replaceAll(new RegExp(r'\s+'), ' ');
}