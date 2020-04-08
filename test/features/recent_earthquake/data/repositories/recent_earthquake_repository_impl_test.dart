import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_gempa/core/error/exception.dart';
import 'package:info_gempa/core/error/failure.dart';
import 'package:info_gempa/features/recent_earthquake/data/datasources/recent_earthquake_remote_data_source.dart';
import 'package:info_gempa/features/recent_earthquake/data/models/recent_earthquake_model.dart';
import 'package:info_gempa/features/recent_earthquake/data/repositories/recent_earthquake_repository_impl.dart';
import 'package:info_gempa/features/recent_earthquake/domain/entities/recent_earthquake.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock
    implements RecentEarthquakeRemoteDataSource {}

void main() {
  RecentEarthquakeRepositoryImpl recentEarthquakeRepositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    recentEarthquakeRepositoryImpl = RecentEarthquakeRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('Get Recent Earthquake', () {
    final tRecentEarthquakeModel =
        recentEarthquakeFromJson(fixture('recent_earthquake.json'));
    final RecentEarthquake tRecentEarthquake = tRecentEarthquakeModel;

    test(
      'should return remote data',
      () async {
        when(mockRemoteDataSource.getRecentEarthquake())
            .thenAnswer((_) async => tRecentEarthquakeModel);
        final result =
            await recentEarthquakeRepositoryImpl.getRecentEarthquake();

        verify(mockRemoteDataSource.getRecentEarthquake());

        expect(result, equals(Right(tRecentEarthquake)));
      },
    );

    test(
      'should return server failure',
      () async {
        when(mockRemoteDataSource.getRecentEarthquake())
            .thenThrow(ServerException());
        final result =
            await recentEarthquakeRepositoryImpl.getRecentEarthquake();

        verify(mockRemoteDataSource.getRecentEarthquake());

        expect(result, equals(Left(ServerFailure())));
      },
    );

    test(
      'should return connection failure',
      () async {
        when(mockRemoteDataSource.getRecentEarthquake())
            .thenThrow(ConnectionException());
        final result =
            await recentEarthquakeRepositoryImpl.getRecentEarthquake();

        verify(mockRemoteDataSource.getRecentEarthquake());

        expect(result, equals(Left(ConnectionFailure())));
      },
    );
  });
}
