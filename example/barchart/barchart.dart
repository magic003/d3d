import 'package:d3d/d3d.dart' as d3d;

void main() {
  var data = [4, 8, 15, 16, 23, 42];
  d3d.select('.chart')
      .selectAll('div')
      .data(data)
      .enter().append('div')
        .style('width', (node, data, i, j) => "${data * 10}px")
        .text((node, data, i, j) => "$data");
}