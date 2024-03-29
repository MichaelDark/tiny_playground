import 'package:flutter/material.dart';

import 'imsea/imsea_search_page.dart';
import 'parking/parking_page.dart';

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
      home: const FeaturesPage(),
      routes: {
        '/imsea': (context) => const ImseaSearchPage(),
        '/parking': (context) => const ParkingPage(),
      },
    );
  }
}

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All features'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Parking'),
              leading: const Icon(Icons.local_parking_rounded),
              onTap: () => Navigator.of(context).pushNamed('/parking'),
            ),
            ListTile(
              title: const Text('Imsea'),
              leading: const Icon(Icons.image_search),
              onTap: () => Navigator.of(context).pushNamed('/imsea'),
            ),
          ],
        ),
      ),
    );
  }
}
