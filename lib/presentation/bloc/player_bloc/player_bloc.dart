import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart' as audio;
import 'player_event.dart';
import 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final audio.AudioPlayer _audioPlayer = audio.AudioPlayer();

  PlayerBloc() : super(PlayerInitial()) {
    _audioPlayer.setVolume(1.0);
    on<PlayStationEvent>(_onPlay);
    on<PauseStationEvent>(_onPause);
    on<SetVolumeEvent>(_onSetVolume);
  }
  Future<void> _onPlay(
      PlayStationEvent event, Emitter<PlayerState> emit) async {
    emit(PlayerLoading(event.station));

    try {
      final future = _audioPlayer.setUrl(event.station.url);
      await future.timeout(const Duration(seconds: 5), onTimeout: () {
        throw Exception("Timeout en setUrl");
      });

      await _audioPlayer.play();
      emit(PlayerPlaying(event.station));
    } catch (e) {
      emit(PlayerError(event.station, 'No se pudo reproducir esta estación'));
    }
  }

  Future<void> _onPause(
      PauseStationEvent event, Emitter<PlayerState> emit) async {
    await _audioPlayer.pause();
    if (state is PlayerPlaying) {
      emit(PlayerPaused((state as PlayerPlaying).station));
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
