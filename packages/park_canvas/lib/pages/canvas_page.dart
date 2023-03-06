import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

const kStep = 50;

class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key});

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage>
    with SingleTickerProviderStateMixin {
  late final FocusNode _node;
  late final Ticker _ticker;

  Size? _size;
  Offset? _offset;
  Offset _direction = Offset.zero;
  Duration _lastTickerElapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _ticker = createTicker(_onTick);
    _ticker.start();
  }

  void _onTick(Duration elapsed) {
    if (elapsed - _lastTickerElapsed > const Duration(milliseconds: 100)) {
      _lastTickerElapsed = elapsed;
      _move(_direction * 2);
    }
  }

  Offset _getCenter(BoxConstraints constraints) {
    final centerOffset = Offset(
      constraints.maxWidth / 2,
      constraints.maxHeight / 2,
    );
    return Offset(
      centerOffset.dx - (centerOffset.dx % kStep),
      centerOffset.dy - (centerOffset.dy % kStep),
    );
  }

  void _onKeyEvent(KeyEvent keyEvent) {
    final offset = _getDirectionFromKey(keyEvent.logicalKey.keyLabel);
    print(keyEvent.runtimeType);
    if (keyEvent is KeyDownEvent) {
      _direction += offset;
    }
    if (keyEvent is KeyUpEvent) {
      _direction -= offset;
    }
  }

  Offset _getDirectionFromKey(String key) {
    switch (key) {
      case "W":
        return const Offset(0, -1);
      case "A":
        return const Offset(-1, 0);
      case "S":
        return const Offset(0, 1);
      case "D":
        return const Offset(1, 0);
      default:
        return Offset.zero;
    }
  }

  void _move(Offset delta) {
    final newOffset = _offset! + delta;
    final newOffsetClamped = Offset(
      newOffset.dx.clamp(0, _size!.width),
      newOffset.dy.clamp(0, _size!.height),
    );
    setState(() => _offset = newOffsetClamped);
  }

  @override
  void dispose() {
    _ticker.stop();
    _ticker.dispose();
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardListener(
        autofocus: true,
        focusNode: _node,
        onKeyEvent: _onKeyEvent,
        child: Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                _size = Size(constraints.maxWidth, constraints.maxHeight);
                _offset ??= _getCenter(constraints);

                return Container(
                  color: Colors.amber[50],
                  child: CustomPaint(
                    painter: Painter(),
                    foregroundPainter: ForegroundPainter(_offset!),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    drawGrid(canvas, size, step: kStep);
  }

  void drawGrid(Canvas canvas, Size size, {required int step}) {
    final gridPaint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.grey;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ForegroundPainter extends CustomPainter {
  final Offset offset;

  ForegroundPainter(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..color = Colors.red;

    canvas.drawCircle(offset, 5, gridPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is ForegroundPainter && oldDelegate.offset != offset;
  }
}
