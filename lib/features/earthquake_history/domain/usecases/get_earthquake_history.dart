import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../entities/earthquake_history.dart';
import '../repositories/earthquake_history_repository.dart';

class GetEarthquakeHistoy {
  final EarthquakeHistoryRepository repository;

  GetEarthquakeHistoy({@required this.repository});

  Future<Either<Failure, EarthquakeHistory>> call() async {
    return await repository.getEarthquakeHistory();
  }
}
