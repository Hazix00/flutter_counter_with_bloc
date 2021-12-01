import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/settings/settings_cubit.dart';
import 'base_screen.dart';

class SettingsScreen extends Screen {
  const SettingsScreen({Key? key})
      : super(key: key, title: 'Settings', color: Colors.blueGrey);

  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              SwitchListTile(
                value: state.appNotifications,
                onChanged: (newValue) {
                  context
                      .read<SettingsCubit>()
                      .toggleAppNotifications(newValue);
                },
                title: const Text('App Notifications'),
              ),
              SwitchListTile(
                value: state.emailNotifications,
                onChanged: (newValue) {
                  context
                      .read<SettingsCubit>()
                      .toggleEmailNotifications(newValue);
                },
                title: const Text('Email Notifications'),
              ),
            ],
          );
        },
      ),
    );
  }
}
