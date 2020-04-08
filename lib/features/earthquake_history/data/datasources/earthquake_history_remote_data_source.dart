import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:xml2json/xml2json.dart';

import '../../../../core/error/exception.dart';
import '../models/earthquake_history_model.dart';

abstract class EarthquakeHistoryRemoteDataSource {
  Future<EarthquakeHistoryModel> getEarthquakeHistory();
}

class EarthquakeHistroyRemoteDataSourceImpl
    implements EarthquakeHistoryRemoteDataSource {
  final http.Client client;
  final Xml2Json xml2json;

  EarthquakeHistroyRemoteDataSourceImpl({
    @required this.client,
    @required this.xml2json,
  });

  @override
  Future<EarthquakeHistoryModel> getEarthquakeHistory() async {
    try {
      final response =
          await client.get('https://data.bmkg.go.id/gempaterkini.xml');
      if (response.statusCode == 200) {
        xml2json.parse(response.body);
        final result = xml2json.toParker();
        return earthquakeHistoryFromJson(result);
      } else {
        throw ServerException();
      }
    } on Xml2JsonException {
      throw NoResultException();
    } on SocketException {
      throw ConnectionException();
    }
  }
}
