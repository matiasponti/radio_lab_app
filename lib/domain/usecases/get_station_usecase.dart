import 'package:radio_lab_app/data/models/radio_station_model.dart';
import 'package:radio_lab_app/domain/repositories/radio_repostory.dart';

class GetStationsUseCase {
  final RadioRepository repository;

  GetStationsUseCase(this.repository);

  Future<List<RadioStationModel>> call() {
    return repository.getStations();
  }
}
