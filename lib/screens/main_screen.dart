import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

Widget getSquare() {
  return Container(
    height: 100,
    width: 100,
    color: Colors.purple,
  );
  ;
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = Tween<double>(begin: 5, end: 100).animate((controller))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DragTarget(
            builder: (context, candidate, rejected) {
              return Container(
                height: 100,
                width: animation.value,
                color: Colors.green,
              );
            },
            onWillAccept: (data) {
              print('Target: onWillAccept()');
              controller.forward();
              return true;
            },
            onAccept: (data) {
              print('Target: onAccept()');
            },
            onLeave: (data) {
              print('Target: onLeave()');
              Future.delayed(Duration(milliseconds: 300));
              controller.reverse();
            },
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.purple,
            child: Draggable(
              child: getSquare(),
              feedback: getSquare(),
              childWhenDragging: Container(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class TargetItem {}

class ClipItem {
  final Color color;

  ClipItem(this.color);
}
