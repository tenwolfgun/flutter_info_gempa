import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/earthquake_history.dart';
import '../../domain/repositories/earthquake_history_repository.dart';
import '../datasources/earthquake_history_remote_data_source.dart';

class EarthquakeHistoryRepositroyImpl implements EarthquakeHistoryRepository {
  final EarthquakeHistoryRemoteDataSource remoteDataSource;

  EarthquakeHistoryRepositroyImpl({@required this.remoteDataSource});

  @override
  Future<Either<Failure, EarthquakeHistory>> getEarthquakeHistory() async {
    try {
      final result = await remoteDataSource.getEarthquakeHistory();
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
