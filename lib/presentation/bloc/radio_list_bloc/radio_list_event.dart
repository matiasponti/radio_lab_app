part of 'radio_list_bloc.dart';

abstract class RadioListEvent extends Equatable {
  const RadioListEvent();

  @override
  List<Object?> get props => [];
}

class LoadStationsEvent extends RadioListEvent {}
