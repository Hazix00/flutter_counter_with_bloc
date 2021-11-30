import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_with_bloc/extensions/enum_extensions.dart';
import 'package:flutter_counter_with_bloc/logic/cubit/counter_cubit.dart';
import 'package:flutter_counter_with_bloc/logic/cubit/internet/internet_cubit.dart';
import 'package:flutter_counter_with_bloc/presentation/screens/base_screen.dart';
import 'package:flutter_counter_with_bloc/presentation/screens/second_screen.dart';

import 'third_screen.dart';

class HomeScreen extends Screen {
  const HomeScreen({Key? key})
      : super(key: key, title: 'Home Screen', color: Colors.blue);

  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected) {
                  final connectionTypeText =
                      state.connectionType.enumToString();
                  return Text(
                    connectionTypeText,
                    style: Theme.of(context).textTheme.headline3,
                  );
                } else if (state is InternetDisconnected) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(context).textTheme.headline3,
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 30),
            Builder(
              builder: (context) {
                final counterState = context.watch<CounterCubit>().state;
                final internetState = context.watch<InternetCubit>().state;
                final counterValue = counterState.counterValue.toString();
                var connectionTypeText = '';
                switch (internetState.runtimeType) {
                  case InternetConnected:
                    connectionTypeText = (internetState as InternetConnected)
                        .connectionType
                        .enumToString();
                    break;
                  case InternetDisconnected:
                    connectionTypeText = 'Disconnected';
                    break;
                  default:
                }
                return Text(
                  'Counter: $counterValue Internet: $connectionTypeText',
                  style: Theme.of(context).textTheme.subtitle1,
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Builder(
              builder: (context) {
                final counterValue = context.select(
                    (CounterCubit counterCubit) =>
                        counterCubit.state.counterValue);
                return Text(
                  'Counter: $counterValue',
                  style: Theme.of(context).textTheme.subtitle1,
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                final message =
                    state.wasIncremented ? 'Incremented' : 'Decremeted';
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message),
                  duration: const Duration(milliseconds: 700),
                ));
              },
              builder: (context, state) {
                if (state.counterValue < 0) {
                  state.counterValue = 0;
                }
                return Text(
                  '${state.counterValue}',
                  style: Theme.of(context).textTheme.headline2,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  heroTag: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  heroTag: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).pushNamed(SecondScreen.routeName);
              },
              child: const Text('Go to Second Screen'),
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.of(context).pushNamed(ThirdScreen.routeName);
              },
              child: const Text('Go to Third Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
