import 'package:flutter_test/flutter_test.dart';
import 'package:info_gempa/core/error/exception.dart';
import 'package:info_gempa/features/earthquake_history/data/datasources/earthquake_history_remote_data_source.dart';
import 'package:info_gempa/features/earthquake_history/data/models/earthquake_history_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockXml2Json extends Mock implements Xml2Json {}

void main() {
  EarthquakeHistroyRemoteDataSourceImpl earthquakeHistroyRemoteDataSourceImpl;
  MockHttpClient mockHttpClient;
  MockXml2Json mockXml2Json;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockXml2Json = MockXml2Json();
    earthquakeHistroyRemoteDataSourceImpl =
        EarthquakeHistroyRemoteDataSourceImpl(
      client: mockHttpClient,
      xml2json: mockXml2Json,
    );
  });

  group('Get Earthquake History', () {
    final tEarthquakeHistoryModell =
        earthquakeHistoryFromJson(fixture('earthquake_history.json'));

    test(
      'should perform get request',
      () async {
        when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response(fixture('gempaterkini.xml'), 200));
        when(mockXml2Json.toParker())
            .thenReturn(fixture('earthquake_history.json'));

        earthquakeHistroyRemoteDataSourceImpl.getEarthquakeHistory();

        verify(mockHttpClient.get(any));
      },
    );

    test(
      'should return EarthquakeHistoryModel',
      () async {
        when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response(fixture('gempaterkini.xml'), 200));
        when(mockXml2Json.toParker())
            .thenReturn(fixture('earthquake_history.json'));

        final result =
            await earthquakeHistroyRemoteDataSourceImpl.getEarthquakeHistory();

        expect(result, equals(tEarthquakeHistoryModell));
      },
    );

    test('should throw server exception', () async {
      when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(fixture('gempaterkini.xml'), 404));

      final call = earthquakeHistroyRemoteDataSourceImpl.getEarthquakeHistory;

      expect(() => call(), throwsA(isInstanceOf<ServerException>()));
    });

    test('should throw connection exception', () async {
      when(mockHttpClient.get(any)).thenThrow(ConnectionException());

      final call = earthquakeHistroyRemoteDataSourceImpl.getEarthquakeHistory;

      expect(() => call(), throwsA(isInstanceOf<ConnectionException>()));
    });
  });
}
