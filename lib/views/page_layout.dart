import 'package:flutter/material.dart';
import 'package:parcours_numerique_app/views/pages/widgets/navigation_controls.dart';

class PageLayout extends StatefulWidget {
  final Widget widget;
  final NavigationControls navigationControls;
  const PageLayout({Key? key, required this.widget, required this.navigationControls}) : super(key: key);

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Container(), onVerticalDragUpdate: (details) {
              if (details.delta.dy > 0) {
                _controller.reverse();
              } else if (details.delta.dy < 0) {
                _controller.forward();
              }
            },),
            widget.widget,
            Transform.translate(child: widget.navigationControls, offset: Offset(0, -_controller.value * 64),),
          ],
          alignment: AlignmentDirectional.bottomCenter,
        ),
      ),
    );
  }
}

/**
    BottomNavigationBar(items: [
    BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.business),
    label: 'Business',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.school),
    label: 'School',
    ),
    ])

    */