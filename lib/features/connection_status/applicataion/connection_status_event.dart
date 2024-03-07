part of 'connection_status_bloc.dart';

abstract class ConnectionStatusEvent extends Equatable {
  const ConnectionStatusEvent();
}

class CheckConnectionStatus extends ConnectionStatusEvent {
  @override
  List<Object> get props => [];
}

class NotifyConnectionStatus extends ConnectionStatusEvent {
  final bool isConnected;

  @override
  List<Object> get props => [
        isConnected,
      ];

  const NotifyConnectionStatus({
    required this.isConnected,
  });
}
