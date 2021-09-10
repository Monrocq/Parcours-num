import 'package:flutter/material.dart';
import 'package:parcours_numerique_app/views/pages/widgets/navigation_controls.dart';

class PageLayout extends StatelessWidget {
  final Widget widget;
  final NavigationControls navigationControls;
  const PageLayout({Key? key, required this.widget, required this.navigationControls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(child: widget),
        navigationControls
      ],
      alignment: AlignmentDirectional.bottomCenter,
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