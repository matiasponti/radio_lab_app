import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:radio_lab_app/data/models/radio_station_model.dart';

class RadioRemoteDataSource {
  final http.Client client;

  RadioRemoteDataSource(this.client);

  Future<List<RadioStationModel>> getStations() async {
    final response = await client.get(
      Uri.parse(
          'https://de1.api.radio-browser.info/json/stations?hidebroken=true&codec=MP3&order=clickcount&reverse=true'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      final filteredList = jsonList
          .where((json) =>
              json['url_resolved'] != null &&
              json['url_resolved'].toString().isNotEmpty &&
              (json['bitrate'] ?? 0) > 0 &&
              (json['clickcount'] ?? 0) > 1000)
          .map((json) => RadioStationModel.fromJson(json))
          .toList();

      return filteredList;
    } else {
      throw Exception('Failed to load radio stations');
    }
  }
}
