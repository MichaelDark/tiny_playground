import 'package:flutter/material.dart';
import 'package:tiny_playground/parking/utils/parking_lots.dart';
import 'package:tiny_playground/parking/widgets/parking_lot_playground.dart';

import 'models/models.dart';
import 'utils/parking_lot_parser.dart';

// https://docs.flutter.dev/codelabs/explicit-animations
// https://blog.logrocket.com/understanding-offsets-flutter/
// https://stackoverflow.com/a/60205853
class ParkingPage extends StatefulWidget {
  const ParkingPage({Key? key}) : super(key: key);

  @override
  State<ParkingPage> createState() => _ParkingPageState();
}

class _ParkingPageState extends State<ParkingPage> {
  late Future<ParkingLot> _parkingLotFuture;

  @override
  void initState() {
    super.initState();
    _parkingLotFuture = _getParkingLot();
  }

  Future<ParkingLot> _getParkingLot() async {
    return ParkingParser().parse(staticParkingLotJson);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _parkingLotFuture = _getParkingLot();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          _InfoAction(),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<ParkingLot>(
          future: _parkingLotFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.error != null) {
              return Center(child: Text('${snapshot.error}'));
            }

            final parkingLot = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 5,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ParkingLotPlayground(
                          parkingLot: parkingLot,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _InfoAction extends StatelessWidget {
  const _InfoAction();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Debug message. Someday it will be useful!',
            ),
          ),
        );
      },
    );
  }
}
