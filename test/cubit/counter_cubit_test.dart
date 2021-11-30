import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_counter_with_bloc/logic/cubit/counter_cubit.dart';
import 'package:flutter_counter_with_bloc/logic/cubit/internet/internet_cubit.dart';
import 'package:test/test.dart';

void main() {
  group('CounterCubit', () {
    late Connectivity connectivity;
    late InternetCubit internetCubit;
    late CounterCubit counterCubit;

    setUp(() {
      connectivity = Connectivity();
      internetCubit = InternetCubit(connectivity: connectivity);
      counterCubit = CounterCubit(internetCubit: internetCubit);
    });
    tearDown(() {
      counterCubit.close();
    });

    test(
      'The initial state for the CounterCubit is CounterState(counterValue:0)',
      () {
        expect(counterCubit.state, CounterState(counterValue: 0));
      },
    );

    blocTest(
      'the cubit should emit a CounterState(counterValue:1,wasIncremented:true) when cubit.increment() method is called ',
      build: () => counterCubit,
      act: (CounterCubit cubit) => cubit.increment(),
      expect: () => [CounterState(counterValue: 1, wasIncremented: true)],
    );

    blocTest(
      'the cubit should emit a CounterState(counterValue:-1,wasIncremented:false) when cubit.decrement() method is called ',
      build: () => counterCubit,
      act: (CounterCubit cubit) => cubit.decrement(),
      expect: () => [CounterState(counterValue: -1, wasIncremented: false)],
    );
  });
}
