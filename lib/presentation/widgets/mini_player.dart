import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_event.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_state.dart';
import 'package:radio_lab_app/presentation/widgets/play_pause_button.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PlayerBloc>().state;

    final bool isLoading = state is PlayerLoading;
    final bool isError = state is PlayerError;

    final RadioStationModel? station = switch (state) {
      PlayerPlaying s => s.station,
      PlayerPaused s => s.station,
      PlayerLoading s => s.station,
      PlayerError s => s.station,
      _ => null
    };

    final double volume = switch (state) {
      PlayerPlaying s => s.volume,
      PlayerPaused s => s.volume,
      _ => 1.0
    };

    if (station == null) {
      return _baseBar('Sin reproducción activa');
    }

    if (isLoading) return _baseBar('Cargando...');
    if (isError) return _baseBar('Error al reproducir');

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PlayPauseButton(station: station),
            ],
          ),
          const SizedBox(height: 4),
          Slider(
            value: volume,
            min: 0.0,
            max: 1.0,
            divisions: 10,
            label: '${(volume * 100).round()}%',
            onChanged: (value) {
              context.read<PlayerBloc>().add(SetVolumeEvent(value));
            },
          ),
        ],
      ),
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
