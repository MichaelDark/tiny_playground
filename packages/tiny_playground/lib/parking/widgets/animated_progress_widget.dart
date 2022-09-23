import 'package:flutter/material.dart';

class AnimatedProgressWidget extends AnimatedWidget {
  final Widget Function(BuildContext, double progress, Widget? child) builder;
  final Widget? child;

  const AnimatedProgressWidget({
    super.key,
    required Listenable controller,
    required this.builder,
    this.child,
  }) : super(listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) =>
      builder(context, _progress.value, child);
}
