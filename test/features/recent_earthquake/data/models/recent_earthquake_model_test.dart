import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:info_gempa/features/recent_earthquake/data/models/recent_earthquake_model.dart';
import 'package:info_gempa/features/recent_earthquake/domain/entities/recent_earthquake.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tRecentEarthquakeModel =
      recentEarthquakeFromJson(fixture('recent_earthquake.json'));

  test(
    'should be a subclass of RecentEarthquake entity',
    () async {
      expect(tRecentEarthquakeModel, isA<RecentEarthquake>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        final result =
            recentEarthquakeFromJson(fixture('recent_earthquake.json'));

        expect(result, equals(tRecentEarthquakeModel));
      },
    );
  });

  group('toJson', () {
    test('should return a json map containing proper data', () async {
      final result = recentEarthquakeToJson(tRecentEarthquakeModel);

      expect(result, equals(json.encode(tRecentEarthquakeModel)));
    });
  });
}
