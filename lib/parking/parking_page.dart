import 'package:flutter/material.dart';
import 'package:tiny_playground/parking/widgets/dynamic_parking_lot.dart';

import 'models/parking_lot.dart';
import 'utils/parking_lot_model_1.dart';
import 'utils/parking_lot_parser.dart';

class ParkingPage extends StatefulWidget {
  const ParkingPage({Key? key}) : super(key: key);

  @override
  State<ParkingPage> createState() => _ParkingPageState();
}

class _ParkingPageState extends State<ParkingPage> {
  ParkingLot parkingLot = ParkingLot(width: 16, height: 16);

  void _updateCells() {
    setState(() {
      parkingLot = ParkingParser().parse(parkingLotModel1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _updateCells,
              icon: const Icon(Icons.update),
            ),
            const SizedBox(height: 10),
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
