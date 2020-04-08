import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'point.dart';

class Gempa extends Equatable {
  final String tanggal;
  final String jam;
  final Point point;
  final String lintang;
  final String bujur;
  final String magnitude;
  final String kedalaman;
  final String symbol;
  final String wilayah1;
  final String wilayah2;
  final String wilayah3;
  final String wilayah4;
  final String wilayah5;
  final String potensi;

  Gempa({
    @required this.tanggal,
    @required this.jam,
    @required this.point,
    @required this.lintang,
    @required this.bujur,
    @required this.magnitude,
    @required this.kedalaman,
    @required this.symbol,
    @required this.wilayah1,
    @required this.wilayah2,
    @required this.wilayah3,
    @required this.wilayah4,
    @required this.wilayah5,
    @required this.potensi,
  });

  Gempa copyWith({
    String tanggal,
    String jam,
    Point point,
    String lintang,
    String bujur,
    String magnitude,
    String kedalaman,
    String symbol,
    String wilayah1,
    String wilayah2,
    String wilayah3,
    String wilayah4,
    String wilayah5,
    String potensi,
  }) =>
      Gempa(
        tanggal: tanggal ?? this.tanggal,
        jam: jam ?? this.jam,
        point: point ?? this.point,
        lintang: lintang ?? this.lintang,
        bujur: bujur ?? this.bujur,
        magnitude: magnitude ?? this.magnitude,
        kedalaman: kedalaman ?? this.kedalaman,
        symbol: symbol ?? this.symbol,
        wilayah1: wilayah1 ?? this.wilayah1,
        wilayah2: wilayah2 ?? this.wilayah2,
        wilayah3: wilayah3 ?? this.wilayah3,
        wilayah4: wilayah4 ?? this.wilayah4,
        wilayah5: wilayah5 ?? this.wilayah5,
        potensi: potensi ?? this.potensi,
      );

  @override
  List<Object> get props => [
        tanggal,
        jam,
        point,
        lintang,
        bujur,
        magnitude,
        kedalaman,
        symbol,
        wilayah1,
        wilayah2,
        wilayah3,
        wilayah4,
        wilayah5,
        potensi,
      ];
}
