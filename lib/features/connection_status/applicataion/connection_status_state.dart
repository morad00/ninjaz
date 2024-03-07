part of 'connection_status_bloc.dart';

abstract class ConnectionStatusState extends Equatable {

  const ConnectionStatusState();

  @override
  List<Object> get props => [];
}

class ConnectionStatusInitial extends ConnectionStatusState {
  const ConnectionStatusInitial();

  @override
  List<Object> get props => [];
}

class Connected extends ConnectionStatusState {
  @override
  List<Object> get props => [];

  const Connected();
}

class DisConnected extends ConnectionStatusState {
  @override
  List<Object> get props => [];

  const DisConnected();
}
