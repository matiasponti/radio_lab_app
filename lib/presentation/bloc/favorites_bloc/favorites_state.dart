import 'package:equatable/equatable.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';

class FavoritesState extends Equatable {
  final List<RadioStationModel> favorites;

  const FavoritesState(this.favorites);

  @override
  List<Object?> get props => [favorites];
}
