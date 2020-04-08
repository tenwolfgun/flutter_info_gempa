import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_gempa/core/error/failure.dart';
import 'package:info_gempa/features/earthquake_history/domain/entities/earthquake_history.dart';
import 'package:info_gempa/features/earthquake_history/domain/entities/gempa.dart';
import 'package:info_gempa/features/earthquake_history/domain/entities/info_gempa.dart';
import 'package:info_gempa/features/earthquake_history/domain/usecases/get_earthquake_history.dart';
import 'package:info_gempa/features/earthquake_history/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';

class MockGetEarthquakeHistory extends Mock implements GetEarthquakeHistoy {}

class MockEarthquakeHistoryBloc
    extends MockBloc<EarthquakeHistoryEvent, EarthquakeHistoryState>
    implements EarthquakeHistoryBloc {}

void main() {
  EarthquakeHistoryBloc bloc;
  MockGetEarthquakeHistory mockGetEarthquakeHistory;
  final tEarthquakeHistory =
      EarthquakeHistory(infogempa: Infogempa(gempa: List<Gempa>()));

  setUp(() {
    mockGetEarthquakeHistory = MockGetEarthquakeHistory();
    bloc = MockEarthquakeHistoryBloc();
  });

  group('whenListen', () {
    test('', () {
      whenListen(
          bloc,
          Stream.fromIterable([
            InitialEarthquakeHistoryState(),
            LoadingState(),
            LoadedState(earthquakeHistory: tEarthquakeHistory),
            ErrorState(errorMessage: 'error'),
          ]));

      expectLater(
          bloc,
          emitsInOrder([
            InitialEarthquakeHistoryState(),
            LoadingState(),
            LoadedState(earthquakeHistory: tEarthquakeHistory),
            ErrorState(errorMessage: 'error'),
          ]));
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
        when(mockGetEarthquakeHistory())
            .thenAnswer((_) async => Right(tEarthquakeHistory));
        return EarthquakeHistoryBloc(
            getEarthquakeHistoy: mockGetEarthquakeHistory);
      },
      act: (bloc) async => bloc.add(GetEarthquakeHistoryEvent()),
      expect: [
        LoadingState(),
        LoadedState(earthquakeHistory: tEarthquakeHistory)
      ],
    );

    blocTest(
      'should emmit [Loading, Error]',
      build: () async {
        when(mockGetEarthquakeHistory()).thenAnswer(
          (_) async => Left(ServerFailure()),
        );
        return EarthquakeHistoryBloc(
            getEarthquakeHistoy: mockGetEarthquakeHistory);
      },
      act: (bloc) => bloc.add(GetEarthquakeHistoryEvent()),
      expect: [
        LoadingState(),
        ErrorState(errorMessage: SERVER_FAILURE_MESSAGE),
      ],
    );
  });
}
