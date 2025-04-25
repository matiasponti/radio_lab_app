import 'package:equatable/equatable.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent {}

class ToggleFavoriteEvent extends FavoritesEvent {
  final RadioStationModel station;

  const ToggleFavoriteEvent(this.station);

  @override
  List<Object?> get props => [station];
}
