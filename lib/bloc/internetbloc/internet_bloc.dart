import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_connection/bloc/internetbloc/internet_event.dart';
import 'package:flutter_connection/bloc/internetbloc/internet_state.dart';

class Internetbloc extends Bloc<InternetEvent, InternetState> {
  Connectivity _connectivity = Connectivity();

  StreamSubscription?
      connectivitySubscription; // ? is a null value or can be null

  Internetbloc() : super(InternetInitialState()) {
    on<InternetLostEvent>((event, emit) => emit(InternetlostState()));
    on<InternetBackEvent>((event, emit) => emit(InternetBackState()));

    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetBackEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
