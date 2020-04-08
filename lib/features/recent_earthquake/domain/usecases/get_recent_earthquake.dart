import 'package:dartz/dartz.dart';
import 'package:info_gempa/core/error/failure.dart';
import 'package:info_gempa/features/recent_earthquake/domain/entities/recent_earthquake.dart';
import 'package:info_gempa/features/recent_earthquake/domain/repositories/recent_earthquake_repository.dart';
import 'package:meta/meta.dart';

class GetRecentEarthquake {
  final RecentEarthquakeRepository repository;

  GetRecentEarthquake({@required this.repository});

  Future<Either<Failure, RecentEarthquake>> call() async {
    return await repository.getRecentEarthquake();
  }
}
