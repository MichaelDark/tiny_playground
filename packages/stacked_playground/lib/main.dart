import 'package:flutter/material.dart';

import 'app.dart';
import 'di/locator.dart';

Future<void> main() async {
  configureDependencies();
  runApp(const StackedPlaygroundApp());
}
