import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState([])) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
      LoadFavoritesEvent event, Emitter<FavoritesState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('favorites') ?? [];
    final stations =
        data.map((s) => RadioStationModel.fromJson(jsonDecode(s))).toList();
    emit(FavoritesState(stations));
  }

  Future<void> _onToggleFavorite(
      ToggleFavoriteEvent event, Emitter<FavoritesState> emit) async {
    final current = List<RadioStationModel>.from(state.favorites);
    final exists = current.any((s) => s.url == event.station.url);

    if (exists) {
      current.removeWhere((s) => s.url == event.station.url);
    } else {
      current.add(event.station);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'favorites',
      current.map((s) => jsonEncode(s.toJson())).toList(),
    );

    emit(FavoritesState(current));
  }

  bool isFavorite(RadioStationModel station) {
    return state.favorites.any((s) => s.url == station.url);
  }
}
