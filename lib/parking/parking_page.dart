import 'package:flutter/material.dart';
import 'package:tiny_playground/parking/widgets/renders/canvas_render.dart';

import 'models/parking_lot.dart';
import 'utils/parking_lot_model_1.dart';
import 'utils/parking_lot_parser.dart';
import 'widgets/renders/grid_view_render.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _updateCells,
            icon: const Icon(Icons.update),
          ),
          ParkingLotGridViewRender(parkingLot: parkingLot),
          const SizedBox(height: 10),
          ParkingLotCanvasRender(parkingLot: parkingLot),
        ],
      ),
    );
  }
}
