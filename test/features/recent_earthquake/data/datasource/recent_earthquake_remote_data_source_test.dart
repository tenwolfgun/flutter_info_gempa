import 'package:flutter_test/flutter_test.dart';
import 'package:info_gempa/core/error/exception.dart';
import 'package:info_gempa/features/recent_earthquake/data/datasources/recent_earthquake_remote_data_source.dart';
import 'package:info_gempa/features/recent_earthquake/data/models/recent_earthquake_model.dart';
import 'package:mockito/mockito.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockXml2Json extends Mock implements Xml2Json {}

void main() {
  RecentEarthquakeRemoteDataSourceImpl recentEarthquakeRemoteDataSourceImpl;
  MockHttpClient mockHttpClient;
  MockXml2Json mockXml2Json;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockXml2Json = MockXml2Json();
    recentEarthquakeRemoteDataSourceImpl = RecentEarthquakeRemoteDataSourceImpl(
      xml2json: mockXml2Json,
      client: mockHttpClient,
    );
  });

  group('Get Recent Earthquake', () {
    final tRecentEarthquakeModel =
        recentEarthquakeFromJson(fixture('recent_earthquake.json'));

    test(
      'should perform get request',
      () async {
        when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response(fixture('autogempa.xml'), 200));
        when(mockXml2Json.toParker())
            .thenReturn(fixture('recent_earthquake.json'));

        recentEarthquakeRemoteDataSourceImpl.getRecentEarthquake();

        verifyInOrder([
          mockHttpClient.get(any),
        ]);
      },
    );

    test(
      'should return RecentEarthquakeModel',
      () async {
        when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response(fixture('autogempa.xml'), 200));

        when(mockXml2Json.toParker())
            .thenReturn(fixture('recent_earthquake.json'));

        final result =
            await recentEarthquakeRemoteDataSourceImpl.getRecentEarthquake();

        expect(result, equals(tRecentEarthquakeModel));
      },
    );

    test(
      'should throw server exception',
      () async {
        when(mockHttpClient.get(any))
            .thenAnswer((_) async => http.Response('not found', 404));

        final call = recentEarthquakeRemoteDataSourceImpl.getRecentEarthquake;

        expect(() => call(), throwsA(isInstanceOf<ServerException>()));
      },
    );
  });
}
