import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';
import 'package:radio_lab_app/presentation/bloc/radio_list_bloc/radio_list_bloc.dart';
import 'package:radio_lab_app/presentation/widgets/mini_player.dart';
import 'package:radio_lab_app/presentation/widgets/radio_home_appbar.dart';
import 'package:radio_lab_app/presentation/widgets/radio_station_tile.dart';

class RadioHomePage extends StatelessWidget {
  const RadioHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RadioHomeAppBar(),
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
                      return RadioStationTile(station: station);
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
