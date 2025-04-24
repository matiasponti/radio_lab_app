import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_event.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_state.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  double _volume = 1.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        if (state is PlayerLoading) {
          return _baseBar('Cargando...');
        }

        if (state is PlayerError) {
          return _baseBar('Error: ${state.message}');
        }

        if (state is PlayerPlaying || state is PlayerPaused) {
          final RadioStationModel station = state is PlayerPlaying
              ? state.station
              : (state as PlayerPaused).station;

          final bool isPlaying = state is PlayerPlaying;

          return Container(
            color: Colors.black87,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
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
                          context
                              .read<PlayerBloc>()
                              .add(PlayStationEvent(station));
                        }
                      },
                    ),
                  ],
                ),
                Slider(
                  value: _volume,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  label: '${(_volume * 100).round()}%',
                  onChanged: (value) {
                    setState(() {
                      _volume = value;
                    });
                    context.read<PlayerBloc>().add(SetVolumeEvent(value));
                  },
                ),
              ],
            ),
          );
        }

        return _baseBar('Sin reproducción activa');
      },
    );
  }

  Widget _baseBar(String message) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.radio, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
