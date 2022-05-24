import 'package:flutter/material.dart';

///Default Container of pages. Defines a standard background color for it's child.
///
///Atributes:
/// - Widget child: child of PageContainer.
class PageContainer extends StatelessWidget {
  PageContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: child),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color.fromARGB(102, 237, 244, 248)],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          stops: [0.3, 1],
        ),
      ),
    );
  }
}
