part of d3d.format;

const String _REQUOTE_RE = r'[\\\^\$\*\+\?\|\[\]\(\)\.\{\}]';

String requote(String s) {
  return s.replaceAllMapped(new RegExp(_REQUOTE_RE), (Match m) => "\\${m[0]}");
}