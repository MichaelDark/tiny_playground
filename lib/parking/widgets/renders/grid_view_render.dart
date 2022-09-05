import 'package:flutter/material.dart';
import 'package:tiny_playground/parking/models/parking_lot.dart';

import '../../models/region_type.dart';

class ParkingLotGridViewRender extends StatelessWidget {
  final ParkingLot parkingLot;

  const ParkingLotGridViewRender({required this.parkingLot, super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: parkingLot.width / parkingLot.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final xSize = constraints.maxWidth / parkingLot.width;
          final ySize = constraints.maxHeight / parkingLot.height;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: parkingLot.height,
            ),
            padding: EdgeInsets.zero,
            itemCount: parkingLot.getCellCount(),
            itemBuilder: (context, index) {
              final x = index % parkingLot.width;
              final y = index ~/ parkingLot.width;

              return CellWidget(
                size: Size(xSize, ySize),
                parkingLot: parkingLot,
                x: x,
                y: y,
              );
            },
          );
        },
      ),
    );
  }
}

class CellWidget extends StatelessWidget {
  final Size size;
  final ParkingLot parkingLot;
  final int x;
  final int y;

  const CellWidget({
    required this.size,
    required this.parkingLot,
    required this.x,
    required this.y,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ParkingCell cell = parkingLot.getCell(x, y);
    final RegionType? type = cell.region?.type;

    Widget? child;

    if (type != null) {
      switch (type.terrain) {
        case Terrain.barrier:
          child = const BarrierCellWidget();
          break;
        case Terrain.road:
          child = const RoadCellWidget();
          break;
        case Terrain.parkPlace:
          child = ParkPlaceCellWidget(region: type as ParkPlaceRegion);
          break;
      }
    }

    child ??= DummyCell(x: x, y: y);

    return SizedBox.fromSize(
      size: size,
      child: child,
    );
  }
}

class DummyCell extends StatelessWidget {
  final int x;
  final int y;

  const DummyCell({required this.x, required this.y, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: x % 2 == 0
          ? (y % 2 == 0 ? Colors.blue : Colors.red)
          : (y % 2 == 0 ? Colors.green : Colors.yellow),
      child: Text(
        '$x; $y',
        style: const TextStyle(fontSize: 8),
      ),
    );
  }
}

class BarrierCellWidget extends StatelessWidget {
  const BarrierCellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
    );
  }
}

class RoadCellWidget extends StatelessWidget {
  const RoadCellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
    );
  }
}

class ParkPlaceCellWidget extends StatelessWidget {
  final ParkPlaceRegion region;

  const ParkPlaceCellWidget({super.key, required this.region});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: region.busy ? Colors.blue[900] : Colors.blue[600],
      child: Text(
        region.code,
        style: TextStyle(
          fontSize: 12,
          decoration: region.busy ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
