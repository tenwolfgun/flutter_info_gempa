import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/recent_earthquake.dart';

abstract class RecentEarthquakeRepository {
  Future<Either<Failure, RecentEarthquake>> getRecentEarthquake();
}
