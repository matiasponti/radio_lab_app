part of 'radio_list_bloc.dart';

abstract class RadioListState extends Equatable {
  const RadioListState();

  @override
  List<Object?> get props => [];
}

class RadioListInitial extends RadioListState {}

class RadioListLoading extends RadioListState {}

class RadioListLoaded extends RadioListState {
  final List<RadioStationModel> stations;

  const RadioListLoaded(this.stations);

  @override
  List<Object?> get props => [stations];
}

class RadioListError extends RadioListState {
  final String message;

  const RadioListError(this.message);

  @override
  List<Object?> get props => [message];
}
