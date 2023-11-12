import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'size_detector_widget.dart';

class SizedPageView extends StatefulWidget {
  final List<Widget> children;
  final PageController pageController;
  final DragStartBehavior dragStartBehavior;
  final ScrollPhysics physics;

  const SizedPageView({
    Key? key,
    required this.children,
    required this.pageController,
    required this.dragStartBehavior,
    required this.physics,
  }) : super(key: key);

  @override
  _SizedPageViewState createState() => _SizedPageViewState();
}

class _SizedPageViewState extends State<SizedPageView> with TickerProviderStateMixin {
  late List<double> _heights;
  int _currentIndex = 0;

  double get _currentHeight => _heights[_currentIndex];

  @override
  void initState() {
    super.initState();
    _heights = List.generate(widget.children.length, (index) => 0.0);

    widget.pageController.addListener(() {
      final _newIndex = widget.pageController.page?.round();
      if (_currentIndex != _newIndex) {
        if (!mounted) {
          return;
        }
        setState(() => _currentIndex = _newIndex!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      onEnd: () {
        if (!mounted) {
          return;
        }
        setState(() {});
      },
      duration: const Duration(milliseconds: 100),
      tween: Tween<double>(begin: _heights[0], end: _currentHeight),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: PageView(
        controller: widget.pageController,
        physics: widget.physics,
        dragStartBehavior: widget.dragStartBehavior,
        children: List.generate(widget.children.length, (index) {
          return OverflowBox(
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeDetectorWidget(
              onSizeDetect: (size) {
                if (!mounted) return;
                setState(() => _heights[index] = size.height);
              },
              child: Align(child: widget.children[index]),
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }
}
