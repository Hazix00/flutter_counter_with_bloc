import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_with_bloc/constants/enums.dart';
import 'package:flutter_counter_with_bloc/logic/cubit/internet/internet_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  late InternetCubit internetCubit;
  late StreamSubscription internetScreenSubscrition;
  CounterCubit({required this.internetCubit})
      : super(CounterState(counterValue: 0)) {
    monitorInternetCubit();
  }

  void monitorInternetCubit() {
    internetScreenSubscrition = internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected) {
        switch (internetState.connectionType) {
          case ConnectionType.wifi:
            increment();
            break;
          case ConnectionType.mobile:
            decrement();
            break;
          default:
        }
      }
    });
  }

  void increment() => emit(
        CounterState(
          counterValue: state.counterValue + 1,
          wasIncremented: true,
        ),
      );
  void decrement() => emit(
        CounterState(
          counterValue: state.counterValue - 1,
          wasIncremented: false,
        ),
      );

  @override
  Future<void> close() {
    internetScreenSubscrition.cancel();
    return super.close();
  }
}
