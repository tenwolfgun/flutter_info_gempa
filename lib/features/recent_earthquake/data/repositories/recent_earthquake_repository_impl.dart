import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/recent_earthquake.dart';
import '../../domain/repositories/recent_earthquake_repository.dart';
import '../datasources/recent_earthquake_remote_data_source.dart';

class RecentEarthquakeRepositoryImpl implements RecentEarthquakeRepository {
  final RecentEarthquakeRemoteDataSource remoteDataSource;

  RecentEarthquakeRepositoryImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, RecentEarthquake>> getRecentEarthquake() async {
    try {
      final result = await remoteDataSource.getRecentEarthquake();
      return Right(result);
    } on NoResultException {
      return Left(NoResultFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on ConnectionException {
      return Left(ConnectionFailure());
    }
  }
}
