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
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => _detectSize());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(SizeDetectorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    //recheck size when widget changes or items change
    Future.microtask(() {
      _detectSize();
    });
  }

  @override
  Widget build(BuildContext context) {
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
