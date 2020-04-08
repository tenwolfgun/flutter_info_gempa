import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:xml2json/xml2json.dart';

import '../../../../core/error/exception.dart';
import '../models/recent_earthquake_model.dart';

abstract class RecentEarthquakeRemoteDataSource {
  Future<RecentEarthquakeModel> getRecentEarthquake();
}

class RecentEarthquakeRemoteDataSourceImpl
    implements RecentEarthquakeRemoteDataSource {
  final http.Client client;
  final Xml2Json xml2json;

  RecentEarthquakeRemoteDataSourceImpl({
    @required this.xml2json,
    @required this.client,
  });

  @override
  Future<RecentEarthquakeModel> getRecentEarthquake() async {
    try {
      final response = await client.get('http://data.bmkg.go.id/autogempa.xml');
      if (response.statusCode == 200) {
        xml2json.parse(response.body);
        final result = xml2json.toParker();
        return recentEarthquakeFromJson(result);
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
