import 'package:flutter/material.dart';
import 'package:tiny_playground/parking/utils/parking_lots.dart';
import 'package:tiny_playground/parking/widgets/dynamic_parking_lot.dart';

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
  late ParkingLot parkingLot;

  @override
  void initState() {
    super.initState();
    parkingLot = ParkingParser().parse(staticParkingLotJson);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      parkingLot = ParkingParser().parse(staticParkingLotJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.update),
                ),
              ],
            ),
            Expanded(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 5,
                child: Center(
                  child: DynamicParkingLot(
                    parkingLot: parkingLot,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
