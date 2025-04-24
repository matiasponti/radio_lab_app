import 'package:radio_lab_app/data/models/radio_station_model.dart';

abstract class RadioRepository {
  Future<List<RadioStationModel>> getStations();
}
