import 'package:flutter/material.dart';

void main() {
  runApp(const TinyApp());
}

class TinyApp extends StatelessWidget {
  const TinyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ApartmentMapPage(),
    );
  }
}

class ApartmentMapPage extends StatelessWidget {
  const ApartmentMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text('Hello'),
      ),
    );
  }
}
