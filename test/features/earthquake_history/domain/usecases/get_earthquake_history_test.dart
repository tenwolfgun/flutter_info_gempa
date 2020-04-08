import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_gempa/features/earthquake_history/domain/entities/earthquake_history.dart';
import 'package:info_gempa/features/earthquake_history/domain/entities/gempa.dart';
import 'package:info_gempa/features/earthquake_history/domain/entities/info_gempa.dart';
import 'package:info_gempa/features/earthquake_history/domain/repositories/earthquake_history_repository.dart';
import 'package:info_gempa/features/earthquake_history/domain/usecases/get_earthquake_history.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements EarthquakeHistoryRepository {}

void main() {
  GetEarthquakeHistoy usecases;
  MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecases = GetEarthquakeHistoy(repository: mockRepository);
  });

  final tEarthquakeHistroy = EarthquakeHistory(
    infogempa: Infogempa(
      gempa: List<Gempa>(),
    ),
  );

  test(
    'should get earthquake history entity',
    () async {
      when(mockRepository.getEarthquakeHistory())
          .thenAnswer((_) async => Right(tEarthquakeHistroy));

      final result = await usecases();

      expect(result, Right(tEarthquakeHistroy));
      verify(mockRepository.getEarthquakeHistory());
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
