import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_gempa/core/error/failure.dart';
import 'package:info_gempa/features/recent_earthquake/domain/entities/gempa.dart';
import 'package:info_gempa/features/recent_earthquake/domain/entities/info_gempa.dart';
import 'package:info_gempa/features/recent_earthquake/domain/entities/point.dart';
import 'package:info_gempa/features/recent_earthquake/domain/entities/recent_earthquake.dart';
import 'package:info_gempa/features/recent_earthquake/domain/usecases/get_recent_earthquake.dart';
import 'package:info_gempa/features/recent_earthquake/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';

class MockRecentEarthquake extends Mock implements GetRecentEarthquake {}

class MockRecentEarthquakeBloc
    extends MockBloc<RecentEarthquakeEvent, RecentEarthquakeState>
    implements RecentEarthquakeBloc {}

void main() {
  RecentEarthquakeBloc bloc;
  MockRecentEarthquake mockRecentEarthquake;
  final tRecentEarthquake = RecentEarthquake(
    infogempa: Infogempa(
      gempa: Gempa(
        bujur: "",
        lintang: "",
        point: Point(coordinates: ""),
        wilayah1: "",
        wilayah2: "",
        wilayah3: "",
        wilayah4: "",
        wilayah5: "",
        kedalaman: "",
        tanggal: "",
        symbol: "",
        magnitude: "",
        jam: "1",
        potensi: "",
      ),
    ),
  );

  final tRecentEarthquake2 = RecentEarthquake(
    infogempa: Infogempa(
      gempa: Gempa(
        bujur: "12",
        lintang: "",
        point: Point(coordinates: ""),
        wilayah1: "",
        wilayah2: "",
        wilayah3: "",
        wilayah4: "",
        wilayah5: "",
        kedalaman: "",
        tanggal: "",
        symbol: "",
        magnitude: "",
        jam: "12",
        potensi: "",
      ),
    ),
  );

  print(tRecentEarthquake == tRecentEarthquake2);

  setUp(() {
    mockRecentEarthquake = MockRecentEarthquake();
    bloc = MockRecentEarthquakeBloc();
    // bloc = RecentEarthquakeBloc(getRecentEarthquake: mockRecentEarthquake);
  });

  group('whenListen', () {
    test('', () {
      whenListen(
          bloc,
          Stream.fromIterable([
            InitialRecentEarthquakeState(),
            LoadingState(),
            LoadedState(recentEarthquake: tRecentEarthquake, isSame: true),
            ErrorState(errorMessage: 'error'),
          ]));

      expectLater(
        bloc,
        emitsInOrder(
          [
            InitialRecentEarthquakeState(),
            LoadingState(),
            LoadedState(recentEarthquake: tRecentEarthquake, isSame: true),
            ErrorState(errorMessage: 'error'),
          ],
        ),
      );
    });
  });

  group('bloc test', () {
    blocTest(
      'should emmit []',
      build: () async => bloc,
      expect: [],
    );

    blocTest(
      'should emmit [Loading, Loaded]',
      build: () async {
        when(mockRecentEarthquake()).thenAnswer(
          (_) async => Right(tRecentEarthquake),
        );
        return RecentEarthquakeBloc(getRecentEarthquake: mockRecentEarthquake);
      },
      act: (bloc) async => bloc.add(GetRecentEearthquakeEvent()),
      expect: [
        LoadingState(),
        LoadedState(
          recentEarthquake: tRecentEarthquake,
          isSame: true,
        )
      ],
    );

    blocTest(
      'should emmits [Loading, Error]',
      build: () async {
        when(mockRecentEarthquake()).thenAnswer(
          (_) async => Left(ServerFailure()),
        );
        return RecentEarthquakeBloc(getRecentEarthquake: mockRecentEarthquake);
      },
      act: (bloc) => bloc.add(GetRecentEearthquakeEvent()),
      expect: [
        LoadingState(),
        ErrorState(errorMessage: SERVER_FAILURE_MESSAGE),
      ],
    );
  });
}
