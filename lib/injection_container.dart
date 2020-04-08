import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:info_gempa/features/earthquake_history/data/repositories/earthquake_history_repository_impl.dart';
import 'package:info_gempa/features/earthquake_history/domain/usecases/get_earthquake_history.dart';
import 'package:info_gempa/features/earthquake_history/presentation/bloc/earthquake_history_bloc.dart';
import 'package:xml2json/xml2json.dart';

import 'features/earthquake_history/data/datasources/earthquake_history_remote_data_source.dart';
import 'features/earthquake_history/domain/repositories/earthquake_history_repository.dart';
import 'features/recent_earthquake/data/datasources/recent_earthquake_remote_data_source.dart';
import 'features/recent_earthquake/data/repositories/recent_earthquake_repository_impl.dart';
import 'features/recent_earthquake/domain/repositories/recent_earthquake_repository.dart';
import 'features/recent_earthquake/domain/usecases/get_recent_earthquake.dart';
import 'features/recent_earthquake/presentation/bloc/bloc.dart';

var sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => RecentEarthquakeBloc(
      getRecentEarthquake: sl(),
    ),
  );

  sl.registerFactory(
    () => EarthquakeHistoryBloc(
      getEarthquakeHistoy: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => GetRecentEarthquake(repository: sl()));
  sl.registerLazySingleton(() => GetEarthquakeHistoy(repository: sl()));

  // Repository
  sl.registerLazySingleton<RecentEarthquakeRepository>(
    () => RecentEarthquakeRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<EarthquakeHistoryRepository>(
    () => EarthquakeHistoryRepositroyImpl(
      remoteDataSource: sl(),
    ),
  );

  // DataSource
  sl.registerLazySingleton<RecentEarthquakeRemoteDataSource>(
    () => RecentEarthquakeRemoteDataSourceImpl(
      xml2json: sl(),
      client: sl(),
    ),
  );

  sl.registerLazySingleton<EarthquakeHistoryRemoteDataSource>(
    () => EarthquakeHistroyRemoteDataSourceImpl(
      xml2json: sl(),
      client: sl(),
    ),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Xml2Json());
}
