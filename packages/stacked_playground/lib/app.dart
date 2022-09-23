import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'generated/generated.router.dart';

class StackedPlaygroundApp extends StatelessWidget {
  const StackedPlaygroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: StackedService.navigatorKey,
      // Construct the StackedRouter and set the onGenerateRoute function
      onGenerateRoute: StackedRouter().onGenerateRoute,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
