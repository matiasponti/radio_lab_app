import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:radio_lab_app/data/models/radio_station_model.dart';
import 'package:radio_lab_app/utils/crypto_helper.dart';
import 'package:radio_lab_app/utils/secure_constants.dart'; // 👈 importante

class RadioRemoteDataSource {
  final http.Client client;

  RadioRemoteDataSource(this.client);

  Future<List<RadioStationModel>> getStations() async {
    final response = await client.get(
      Uri.parse(SecureConstants.radioBrowserUrl),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      final filteredList = jsonList
          .where((json) =>
              json['url_resolved'] != null &&
              json['url_resolved'].toString().isNotEmpty &&
              (json['bitrate'] ?? 0) > 0 &&
              (json['clickcount'] ?? 0) > 1000)
          .map((json) {
        final encryptedUrl = CryptoHelper.encryptText(json['url_resolved']);
        return RadioStationModel.fromJson({
          ...json,
          'url_resolved': encryptedUrl, // 👈 reemplazamos con versión cifrada
        });
      }).toList();

      return filteredList;
    } else {
      throw Exception('Failed to load radio stations');
    }
  }
}
