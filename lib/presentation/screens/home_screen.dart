import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_with_bloc/constants/enums.dart';
import 'package:flutter_counter_with_bloc/presentation/screens/settings_screen.dart';

import '../../extensions/enum_extensions.dart';
import '../../logic/cubit/counter/counter_cubit.dart';
import '../../logic/cubit/internet/internet_cubit.dart';
import 'base_screen.dart';
import 'second_screen.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
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
                  if (state.connectionType == ConnectionType.wifi) {
                    context.read<CounterCubit>().increment();
                  } else {
                    context.read<CounterCubit>().decrement();
                  }
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
            BlocSelector<CounterCubit, CounterState, int>(
              selector: (state) => state.counterValue,
              builder: (context, counterValue) {
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    duration: const Duration(milliseconds: 700),
                  ),
                );
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
                    context.read<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  heroTag: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    context.read<CounterCubit>().increment();
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
