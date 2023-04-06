import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SizeDetectorWidget extends StatefulWidget {
  const SizeDetectorWidget({
    Key? key,
    required this.child,
    required this.onSizeDetect,
  }) : super(key: key);

  final Widget child;
  final ValueChanged<Size> onSizeDetect;

  @override
  State createState() => _SizeDetectorWidgetState();
}

class _SizeDetectorWidgetState extends State<SizeDetectorWidget> {

  void _listenSize() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      widget.onSizeDetect(context.size!);
    });
  }

  @override
  void initState() {
    super.initState();
    _listenSize();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        _listenSize();
        return false;
      },
      child: SizeChangedLayoutNotifier(child: widget.child),
    );
  }
}
