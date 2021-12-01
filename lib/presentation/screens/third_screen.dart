import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/counter/counter_cubit.dart';
import 'base_screen.dart';

class ThirdScreen extends Screen {
  const ThirdScreen({Key? key})
      : super(key: key, title: 'Third Screen', color: Colors.greenAccent);

  static const routeName = '/third';

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: Theme.of(context).textTheme.headline6,
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
                  backgroundColor: widget.color,
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  heroTag: 'Increment',
                  child: const Icon(Icons.add),
                  backgroundColor: widget.color,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
