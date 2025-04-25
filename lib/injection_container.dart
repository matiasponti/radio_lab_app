import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:radio_lab_app/data/repositories/radio_repository_impl.dart';
import 'package:radio_lab_app/data/source/radio_data_source.dart';
import 'package:radio_lab_app/domain/repositories/radio_repostory.dart';
import 'package:radio_lab_app/domain/usecases/get_station_usecase.dart';
import 'package:radio_lab_app/presentation/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/player_bloc/player_bloc.dart';
import 'package:radio_lab_app/presentation/bloc/radio_list_bloc/radio_list_bloc.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton<RadioRemoteDataSource>(
      () => RadioRemoteDataSource(sl()));

  sl.registerLazySingleton<RadioRepository>(() => RadioRepositoryImpl(sl()));

  sl.registerLazySingleton(() => GetStationsUseCase(sl()));

  sl.registerFactory(() => RadioListBloc(sl()));
  sl.registerFactory(() => PlayerBloc());
  sl.registerFactory(() => FavoritesBloc());
}
