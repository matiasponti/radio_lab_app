import 'package:equatable/equatable.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object?> get props => [];
}

class PlayStationEvent extends PlayerEvent {
  final RadioStationModel station;

  const PlayStationEvent(this.station);

  @override
  List<Object?> get props => [station];
}

class PauseStationEvent extends PlayerEvent {}

class SetVolumeEvent extends PlayerEvent {
  final double volume;

  const SetVolumeEvent(this.volume);

  @override
  List<Object?> get props => [volume];
}
