part of d3d.core;

class NS {
  static final Map<String, String> _NS_PREFIX = {
    "svg": "http://www.w3.org/2000/svg",
    "xhtml": "http://www.w3.org/1999/xhtml",
    "xlink": "http://www.w3.org/1999/xlink",
    "xml": "http://www.w3.org/XML/1998/namespace",
    "xmlns": "http://www.w3.org/2000/xmlns/"                           
  };
  
  String space, local;
  
  NS._internal(this.space, this.local);
  
  factory NS.qualify(String name) {
    var i = name.indexOf(":"),
        prefix = name;
    if (i >= 0) {
      prefix = name.substring(0, i);
      name = name.substring(i+1);
    }
    
    return new NS._internal(_NS_PREFIX[prefix], name);
  }
}