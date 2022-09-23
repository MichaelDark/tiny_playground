import 'package:stacked/stacked_annotations.dart';

import '../pages/home_page.dart';

@StackedApp(
  logger: StackedLogger(logHelperName: 'getStackedLogger'),
  routes: [
    MaterialRoute(page: HomePage, initial: true),
    // CupertinoRoute(page: CharacterPage),
  ],
)
// ignore: unused_element
class _Noop {}
