import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Point extends Equatable {
  final String coordinates;

  Point({@required this.coordinates});

  Point copyWith({
    String coordinates,
  }) =>
      Point(
        coordinates: coordinates ?? this.coordinates,
      );

  @override
  List<Object> get props => [coordinates];
}
