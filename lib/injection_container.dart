import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:radio_lab_app/data/repositories/radio_repository_impl.dart';
import 'package:radio_lab_app/data/source/radio_data_source.dart';
import 'package:radio_lab_app/domain/repositories/radio_repostory.dart';
import 'package:radio_lab_app/domain/usecases/get_station_usecase.dart';
import 'package:radio_lab_app/presentation/bloc/radio_list_bloc/radio_list_bloc.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Registro base
  sl.registerLazySingleton(() => http.Client());

  // Data sources
  sl.registerLazySingleton<RadioRemoteDataSource>(
      () => RadioRemoteDataSource(sl()));

  // Repositories
  sl.registerLazySingleton<RadioRepository>(() => RadioRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetStationsUseCase(sl()));

  // Blocs
  sl.registerFactory(() => RadioListBloc(sl()));
}
