import 'dart:io';

String fixture(String name) => File('assets/$name').readAsStringSync();
