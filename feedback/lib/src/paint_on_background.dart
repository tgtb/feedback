// ignore_for_file: public_member_api_docs

import 'package:feedback/src/painter.dart';
import 'package:flutter/material.dart';

class PaintOnChild extends StatelessWidget {
  const PaintOnChild({
    super.key,
    required this.child,
    required this.isPaintingActive,
    required this.shouldViewPainting,
    required this.controller,
  });

  final Widget child;
  final bool isPaintingActive;
  final bool shouldViewPainting;

  final PainterController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        if (shouldViewPainting)
          Painter(controller, isPainting: isPaintingActive),
      ],
    );
  }
}
