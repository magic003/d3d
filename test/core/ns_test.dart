import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3d/src/core/core.dart';

void main() {
  useHtmlEnhancedConfiguration();

  test('NS(unqualified name)', () {
    var ns = new NS.qualify('div');

    expect(ns.space, isNull);
    expect(ns.local, equals('div'));

    ns = new NS.qualify('xml');
    expect(ns.space, equals('http://www.w3.org/XML/1998/namespace'));
    expect(ns.local, equals('xml'));
  });

  test('NS(qualified name)', () {
    var ns = new NS.qualify('x:div');

    expect(ns.space, isNull);
    expect(ns.local, equals('div'));

    ns = new NS.qualify('xml:div');
    expect(ns.space, equals('http://www.w3.org/XML/1998/namespace'));
    expect(ns.local, equals('div'));
  });
}
