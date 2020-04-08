import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_gempa/core/error/exception.dart';
import 'package:info_gempa/core/error/failure.dart';
import 'package:info_gempa/features/earthquake_history/data/datasources/earthquake_history_remote_data_source.dart';
import 'package:info_gempa/features/earthquake_history/data/models/earthquake_history_model.dart';
import 'package:info_gempa/features/earthquake_history/data/repositories/earthquake_history_repository_impl.dart';
import 'package:info_gempa/features/earthquake_history/domain/entities/earthquake_history.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock
    implements EarthquakeHistoryRemoteDataSource {}

void main() {
  EarthquakeHistoryRepositroyImpl earthquakeHistoryRepositroyImpl;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    earthquakeHistoryRepositroyImpl =
        EarthquakeHistoryRepositroyImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('Get Earthquake History', () {
    final tEarthquakeHistoryModel =
        earthquakeHistoryFromJson(fixture('earthquake_history.json'));

    final EarthquakeHistory tEarthquakeHistory = tEarthquakeHistoryModel;

    test(
      'should return remote data',
      () async {
        when(mockRemoteDataSource.getEarthquakeHistory())
            .thenAnswer((_) async => tEarthquakeHistoryModel);

        final result =
            await earthquakeHistoryRepositroyImpl.getEarthquakeHistory();

        verify(mockRemoteDataSource.getEarthquakeHistory());

        expect(result, equals(Right(tEarthquakeHistory)));
      },
    );

    test(
      'should return server failure',
      () async {
        when(mockRemoteDataSource.getEarthquakeHistory())
            .thenThrow(ServerException());

        final result =
            await earthquakeHistoryRepositroyImpl.getEarthquakeHistory();

        verify(mockRemoteDataSource.getEarthquakeHistory());

        expect(result, equals(Left(ServerFailure())));
      },
    );

    test(
      'should return connection failure',
      () async {
        when(mockRemoteDataSource.getEarthquakeHistory())
            .thenThrow(ConnectionException());

        final result =
            await earthquakeHistoryRepositroyImpl.getEarthquakeHistory();

        verify(mockRemoteDataSource.getEarthquakeHistory());

        expect(result, equals(Left(ConnectionFailure())));
      },
    );
  });
}
