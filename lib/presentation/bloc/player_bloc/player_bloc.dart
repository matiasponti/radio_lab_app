import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart' as audio;
import 'player_event.dart';
import 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final audio.AudioPlayer _audioPlayer = audio.AudioPlayer();

  PlayerBloc() : super(PlayerInitial()) {
    on<PlayStationEvent>(_onPlay);
    on<PauseStationEvent>(_onPause);
  }

  Future<void> _onPlay(
      PlayStationEvent event, Emitter<PlayerState> emit) async {
    try {
      await _audioPlayer.setUrl(event.station.url);
      await _audioPlayer.play();
      emit(PlayerPlaying(event.station));
    } catch (_) {}
  }

  Future<void> _onPause(
      PauseStationEvent event, Emitter<PlayerState> emit) async {
    await _audioPlayer.pause();
    if (state is PlayerPlaying) {
      emit(PlayerPaused((state as PlayerPlaying).station));
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
