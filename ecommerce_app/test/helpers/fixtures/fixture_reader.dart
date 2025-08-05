import 'dart:io';
String fixture(String name) => File('test/helpers/fixtures/$name').readAsStringSync();