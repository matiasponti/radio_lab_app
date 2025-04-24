import 'package:radio_lab_app/data/models/radio_station_model.dart';
import 'package:radio_lab_app/data/source/radio_data_source.dart';
import 'package:radio_lab_app/domain/repositories/radio_repostory.dart';

class RadioRepositoryImpl implements RadioRepository {
  final RadioRemoteDataSource remoteDataSource;

  RadioRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<RadioStationModel>> getStations() async {
    final stationModels = await remoteDataSource.getStations();
    return stationModels.map((model) => model.toEntity()).toList();
  }
}
