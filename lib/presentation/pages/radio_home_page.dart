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
                      return ListTile(
                        leading: station.favicon.isNotEmpty
                            ? Image.network(
                                station.favicon,
                                width: 40,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.radio),
                              )
                            : const Icon(Icons.radio),
                        title: Text(station.name),
                        subtitle: Text('${station.country} • ${station.tags}'),
                        onTap: () {
                          context
                              .read<PlayerBloc>()
                              .add(PlayStationEvent(station));
                        },
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
