import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_event.dart';
import 'package:radio_lab_app/presentation/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/favorites_bloc/favorites_event.dart';
import 'package:radio_lab_app/presentation/bloc/favorites_bloc/favorites_state.dart';

class RadioStationTile extends StatelessWidget {
  final RadioStationModel station;

  const RadioStationTile({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, favState) {
        final isFav = favState.favorites.any((s) => s.url == station.url);

        return Card(
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            leading: station.favicon.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      station.favicon,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.radio),
                    ),
                  )
                : const Icon(Icons.radio, size: 36, color: Colors.white),
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
            trailing: IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.purpleAccent : Colors.white38,
              ),
              onPressed: () {
                context.read<FavoritesBloc>().add(ToggleFavoriteEvent(station));
              },
            ),
            onTap: () {
              context.read<PlayerBloc>().add(PlayStationEvent(station));
            },
          ),
        );
      },
    );
  }
}
