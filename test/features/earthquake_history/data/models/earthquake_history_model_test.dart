import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_gempa/features/earthquake_history/data/models/earthquake_history_model.dart';
import 'package:info_gempa/features/earthquake_history/domain/entities/earthquake_history.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tEarthquakeHistoryModel =
      earthquakeHistoryFromJson(fixture('earthquake_history.json'));

  test(
    'should be a subclass of EarthquakeHistory entity',
    () async {
      expect(tEarthquakeHistoryModel, isA<EarthquakeHistory>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        final result =
            earthquakeHistoryFromJson(fixture('earthquake_history.json'));

        expect(result, equals(tEarthquakeHistoryModel));
      },
    );

    group('toJson', () {
      test(
        'should return a json map containing proper data',
        () async {
          final result = earthquakeHistoryToJson(tEarthquakeHistoryModel);

          expect(result, equals(json.encode(tEarthquakeHistoryModel)));
        },
      );
    });
  });
}
