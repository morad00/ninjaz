import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connection_status_event.dart';

part 'connection_status_state.dart';

class ConnectionStatusBloc extends Bloc<ConnectionStatusEvent, ConnectionStatusState> {
  bool firstConnectionCheck = true;
  bool streamOpened = false;

  ConnectionStatusBloc() : super(const ConnectionStatusInitial()) {
    on<NotifyConnectionStatus>(_onNotifyConnectionStatus);
    on<CheckConnectionStatus>(_onCheckConnectionStatus);
  }

  FutureOr<void> _onCheckConnectionStatus(CheckConnectionStatus event, Emitter<ConnectionStatusState> emit) async {
    final connectionStatus = await Connectivity().checkConnectivity();
    if (connectionStatus == ConnectivityResult.none) {
      add(const NotifyConnectionStatus(isConnected: false));
    } else {
      add(const NotifyConnectionStatus(isConnected: true));
    }
    if (!streamOpened) {
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          if (!firstConnectionCheck) {
            add(const NotifyConnectionStatus(isConnected: false));
          }
        } else {
          if (!firstConnectionCheck) {
            add(const NotifyConnectionStatus(isConnected: true));
          }
        }
        firstConnectionCheck = false;
      });
      streamOpened = true;
    }
  }

  FutureOr<void> _onNotifyConnectionStatus(NotifyConnectionStatus event, Emitter<ConnectionStatusState> emit) async {
    emit(
      event.isConnected ? const Connected() : const DisConnected(),
    );
  }
}
