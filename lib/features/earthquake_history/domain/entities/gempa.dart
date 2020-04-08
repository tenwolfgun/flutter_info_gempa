import 'package:equatable/equatable.dart';
import 'package:info_gempa/features/earthquake_history/domain/entities/point.dart';
import 'package:meta/meta.dart';

class Gempa extends Equatable {
  final String tanggal;
  final String jam;
  final Point point;
  final String lintang;
  final String bujur;
  final String magnitude;
  final String kedalaman;
  final String symbol;
  final String wilayah;

  Gempa({
    @required this.tanggal,
    @required this.jam,
    @required this.point,
    @required this.lintang,
    @required this.bujur,
    @required this.magnitude,
    @required this.kedalaman,
    @required this.symbol,
    @required this.wilayah,
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
    String wilayah,
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
        wilayah: wilayah ?? this.wilayah,
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
        wilayah,
      ];
}
