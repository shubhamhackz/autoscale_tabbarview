import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SizeDetectorWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeDetect;

  const SizeDetectorWidget({
    Key? key,
    required this.child,
    required this.onSizeDetect,
  }) : super(key: key);

  @override
  _SizeDetectorWidgetState createState() => _SizeDetectorWidgetState();
}

class _SizeDetectorWidgetState extends State<SizeDetectorWidget> {
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((_) => _detectSize());
    return widget.child;
  }

  void _detectSize() {
    if (!mounted) {
      return;
    }
    final size = context.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeDetect(size!);
    }
  }
}
