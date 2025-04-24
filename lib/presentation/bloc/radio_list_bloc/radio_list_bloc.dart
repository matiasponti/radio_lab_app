import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_lab_app/data/models/radio_station_model.dart';
import 'package:radio_lab_app/domain/usecases/get_station_usecase.dart';

part 'radio_list_event.dart';
part 'radio_list_state.dart';

class RadioListBloc extends Bloc<RadioListEvent, RadioListState> {
  final GetStationsUseCase getStations;

  RadioListBloc(this.getStations) : super(RadioListInitial()) {
    on<LoadStationsEvent>((event, emit) async {
      emit(RadioListLoading());
      try {
        final stations = await getStations();
        emit(RadioListLoaded(stations));
      } catch (_) {
        emit(const RadioListError("Error loading stations"));
      }
    });
  }
}
