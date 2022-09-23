import 'package:flutter/material.dart';

class CanvasTheme {
  static final CanvasTheme _instance = CanvasTheme._();
  CanvasTheme._();
  factory CanvasTheme() => _instance;

  final currentPositionPaint = Paint()..color = Colors.green[300]!;
  final currentPositionBlockedPaint = Paint()..color = Colors.red[200]!;
  final targetPositionPaint = Paint()..color = Colors.red[400]!;

  final dirtPaint = Paint()..color = Colors.brown[300]!;

  final roadPaint = Paint()..color = Colors.grey[400]!;
  final roadArrowPaint = Paint()..color = Colors.grey[600]!;
  final barrierPaint = Paint()..color = Colors.grey[800]!;

  final busyParkPlacePaint = Paint()..color = Colors.blue[900]!;
  final freeParkPlacePaint = Paint()..color = Colors.blue[600]!;
  final parkPlaceBorderPaint = Paint()
    ..color = Colors.grey[600]!
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
}
