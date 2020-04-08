import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_gempa/features/recent_earthquake/domain/entities/gempa.dart';
import 'package:info_gempa/features/recent_earthquake/domain/entities/info_gempa.dart';
import 'package:info_gempa/features/recent_earthquake/domain/entities/point.dart';
import 'package:info_gempa/features/recent_earthquake/domain/entities/recent_earthquake.dart';
import 'package:info_gempa/features/recent_earthquake/domain/repositories/recent_earthquake_repository.dart';
import 'package:info_gempa/features/recent_earthquake/domain/usecases/get_recent_earthquake.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements RecentEarthquakeRepository {}

void main() {
  GetRecentEarthquake usecases;
  MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecases = GetRecentEarthquake(repository: mockRepository);
  });

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
        jam: "",
        potensi: "",
      ),
    ),
  );

  test(
    'should get recent earthquake entity',
    () async {
      when(mockRepository.getRecentEarthquake())
          .thenAnswer((_) async => Right(tRecentEarthquake));

      final result = await usecases();

      expect(result, Right(tRecentEarthquake));
      verify(mockRepository.getRecentEarthquake());
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
