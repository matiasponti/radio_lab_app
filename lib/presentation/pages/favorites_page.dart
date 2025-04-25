import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/favorites_bloc/favorites_state.dart';
import 'package:radio_lab_app/presentation/widgets/mini_player.dart';
import 'package:radio_lab_app/presentation/widgets/radio_station_tile.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                if (state.favorites.isEmpty) {
                  return const Center(child: Text('No hayfavoritas'));
                }
                return ListView.builder(
                  itemCount: state.favorites.length,
                  itemBuilder: (context, index) {
                    return RadioStationTile(station: state.favorites[index]);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 150, child: MiniPlayer()),
        ],
      ),
    );
  }
}
