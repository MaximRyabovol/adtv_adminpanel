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

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            color: Colors.red,
            child: DragTarget(
              builder: (context, candidate, rejected) {
                return Container(
                  height: 100,
                  width: 0.5,
                  color: Colors.green,
                );
              },
              onWillAccept: (data) {
                print('Target: onWillAccept()');
                return true;
              },
              onAccept: (data) {
                print('Target: onAccept()');
              },
              onLeave: (data) {
                print('Target: onLeave()');
              },
            ),
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
}

class TargetItem {}

class ClipItem {
  final Color color;

  ClipItem(this.color);
}
