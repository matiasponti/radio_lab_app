import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart' as audio;
import 'player_event.dart';
import 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  int _sessionId = 0;
  double _volume = 1.0;
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
        _sessionId++;
        emit(PlayerPlaying(event.station, _volume, _sessionId));
        return;
      }

      emit(PlayerLoading(event.station));

      final future = _audioPlayer.setUrl(event.station.url);
      await future.timeout(const Duration(seconds: 5), onTimeout: () {
        throw Exception("Timeout en setUrl");
      });

      await _audioPlayer.play();
      _sessionId++;
      emit(PlayerPlaying(event.station, _volume, _sessionId));
    } catch (e) {
      emit(PlayerError(event.station, 'No se pudo reproducir esta estación'));
    }
  }

  Future<void> _onPause(
      PauseStationEvent event, Emitter<PlayerState> emit) async {
    await _audioPlayer.pause();
    if (state is PlayerPlaying) {
      emit(PlayerPaused((state as PlayerPlaying).station, _volume, _sessionId));
    }
  }

  Future<void> _onSetVolume(
      SetVolumeEvent event, Emitter<PlayerState> emit) async {
    _volume = event.volume;
    await _audioPlayer.setVolume(event.volume);

    if (state is PlayerPlaying) {
      emit(
          PlayerPlaying((state as PlayerPlaying).station, _volume, _sessionId));
    } else if (state is PlayerPaused) {
      emit(PlayerPaused((state as PlayerPaused).station, _volume, _sessionId));
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
