import 'package:equatable/equatable.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object?> get props => [];
}

class PlayerInitial extends PlayerState {}

class PlayerLoading extends PlayerState {
  final RadioStationModel station;

  const PlayerLoading(this.station);

  @override
  List<Object?> get props => [station];
}

class PlayerPlaying extends PlayerState {
  final RadioStationModel station;
  final double volume;
  final int sessionId;

  const PlayerPlaying(this.station, this.volume, this.sessionId);

  @override
  List<Object?> get props => [station, volume, sessionId];
}

class PlayerPaused extends PlayerState {
  final RadioStationModel station;
  final double volume;
  final int sessionId;

  const PlayerPaused(this.station, this.volume, this.sessionId);

  @override
  List<Object?> get props => [station, volume, sessionId];
}

class PlayerError extends PlayerState {
  final RadioStationModel station;
  final String message;

  const PlayerError(this.station, this.message);

  @override
  List<Object?> get props => [station, message];
}
