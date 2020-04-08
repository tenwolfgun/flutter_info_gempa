import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/earthquake_history.dart';

abstract class EarthquakeHistoryRepository {
  Future<Either<Failure, EarthquakeHistory>> getEarthquakeHistory();
}
