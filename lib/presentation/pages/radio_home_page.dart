import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_event.dart';
import 'package:radio_lab_app/presentation/bloc/radio_list_bloc/radio_list_bloc.dart';
import 'package:radio_lab_app/presentation/widgets/mini_player.dart';

class RadioHomePage extends StatelessWidget {
  const RadioHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio Stations'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: BlocBuilder<RadioListBloc, RadioListState>(
              builder: (context, state) {
                if (state is RadioListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RadioListLoaded) {
                  return ListView.builder(
                    itemCount: state.stations.length,
                    itemBuilder: (context, index) {
                      final RadioStationModel station = state.stations[index];
                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          leading: station.favicon.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    station.favicon,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.radio),
                                  ),
                                )
                              : const Icon(Icons.radio,
                                  size: 36, color: Colors.white),
                          title: Text(
                            station.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${station.country} • ${station.tags}',
                            style: const TextStyle(color: Colors.white70),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            context
                                .read<PlayerBloc>()
                                .add(PlayStationEvent(station));
                          },
                        ),
                      );
                    },
                  );
                } else if (state is RadioListError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('Esperando acción...'));
                }
              },
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: MiniPlayer(),
          ),
        ],
      ),
    );
  }
}
