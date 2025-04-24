import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_event.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_state.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        if (state is PlayerPlaying || state is PlayerPaused) {
          final RadioStationModel station = state is PlayerPlaying
              ? state.station
              : (state as PlayerPaused).station;

          final bool isPlaying = state is PlayerPlaying;

          return Container(
            color: Colors.black54,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.radio, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    station.name,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (isPlaying) {
                      context.read<PlayerBloc>().add(PauseStationEvent());
                    } else {
                      context.read<PlayerBloc>().add(PlayStationEvent(station));
                    }
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
