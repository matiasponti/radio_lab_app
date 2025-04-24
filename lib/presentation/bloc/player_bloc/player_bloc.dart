import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart' as audio;
import 'player_event.dart';
import 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  int _sessionId = 0;
  final audio.AudioPlayer _audioPlayer = audio.AudioPlayer();

  PlayerBloc() : super(PlayerInitial()) {
    _audioPlayer.setVolume(1.0);
    on<PlayStationEvent>(_onPlay);
    on<PauseStationEvent>(_onPause);
    on<SetVolumeEvent>(_onSetVolume);
  }

  Future<void> _onPlay(
      PlayStationEvent event, Emitter<PlayerState> emit) async {
    try {
      if (state is PlayerPaused &&
          (state as PlayerPaused).station.url == event.station.url) {
        await _audioPlayer.play();
        emit(PlayerPlaying(
            event.station, DateTime.now().millisecondsSinceEpoch));
        return;
      }

      emit(PlayerLoading(event.station));
      await _audioPlayer
          .setUrl(event.station.url)
          .timeout(const Duration(seconds: 5));
      await _audioPlayer.play();
      emit(PlayerPlaying(event.station, DateTime.now().millisecondsSinceEpoch));
    } catch (_) {
      emit(PlayerError(event.station, 'No se pudo reproducir esta estación'));
    }
  }

  Future<void> _onPause(
      PauseStationEvent event, Emitter<PlayerState> emit) async {
    await _audioPlayer.pause();
    if (state is PlayerPlaying) {
      emit(PlayerPaused((state as PlayerPlaying).station, _sessionId));
    }
  }

  Future<void> _onSetVolume(
      SetVolumeEvent event, Emitter<PlayerState> emit) async {
    await _audioPlayer.setVolume(event.volume);
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
