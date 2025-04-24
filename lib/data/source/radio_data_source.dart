import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:radio_lab_app/data/models/radio_station_model.dart';

class RadioRemoteDataSource {
  final http.Client client;
  RadioRemoteDataSource(this.client);

  Future<List<RadioStationModel>> getStations() async {
    final response = await client
        .get(Uri.parse('https://de1.api.radio-browser.info/json/stations'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => RadioStationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load radio stations');
    }
  }
}
