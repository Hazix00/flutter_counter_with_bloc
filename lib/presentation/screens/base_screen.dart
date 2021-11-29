import 'package:flutter/material.dart';

abstract class Screen extends StatefulWidget {
  const Screen({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;
}
