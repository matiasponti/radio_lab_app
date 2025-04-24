import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_event.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_state.dart';

class PlayPauseButton extends StatefulWidget {
  final RadioStationModel station;
  const PlayPauseButton({super.key, required this.station});

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  late ValueNotifier<bool> isPlayingNotifier;

  @override
  void initState() {
    super.initState();
    isPlayingNotifier = ValueNotifier(false);
  }

  @override
  void dispose() {
    isPlayingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PlayerBloc>().state;

    final bool isBlocPlaying =
        state is PlayerPlaying && (state).station.url == widget.station.url;

    // Sincronizamos con el estado real
    if (isPlayingNotifier.value != isBlocPlaying) {
      isPlayingNotifier.value = isBlocPlaying;
    }

    return ValueListenableBuilder<bool>(
      valueListenable: isPlayingNotifier,
      builder: (_, isPlaying, __) {
        return IconButton(
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
          onPressed: () {
            isPlayingNotifier.value = !isPlaying;

            if (isPlaying) {
              context.read<PlayerBloc>().add(PauseStationEvent());
            } else {
              context.read<PlayerBloc>().add(PlayStationEvent(widget.station));
            }
          },
        );
      },
    );
  }
}
