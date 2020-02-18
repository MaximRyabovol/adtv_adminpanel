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
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> playList = [];

  @override
  void initState() {
    initPlayList();
    changePlayList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width * 0.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: playList.length,
              itemBuilder: (context, index) {
                return playList[index];
              },
            ),
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.purple,
            child: Draggable(
              data: Colors.purple,
              child: getSquare(),
              feedback: getSquare(),
              childWhenDragging: Container(),
            ),
          ),
        ],
      ),
    );
  }

  void initPlayList() {
    playList.add(ClipItem(Colors.blue, 0));
    playList.add(ClipItem(Colors.red, 1));
    playList.add(ClipItem(Colors.black, 2));
  }

  void changePlayList() {
    for (int i = 1; i < playList.length; i++) {
      if (!i.isEven) {
        playList.insert(i, TargetableSpace(i));
      }
    }
    playList.insert(0, TargetableSpace(0));
    playList.add(TargetableSpace(playList.length - 1));
  }
}

class TargetableSpace extends StatefulWidget {
  int position;

  TargetableSpace(this.position);

  int changePosition(int position) {
    position = position;
    return position;
  }

  @override
  _TargetableSpaceState createState() => _TargetableSpaceState();
}

class _TargetableSpaceState extends State<TargetableSpace>
    with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Color widgetColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, candidate, rejected) {
        return Container(
          height: 100,
          width: animation.value,
          color: widgetColor,
        );
      },
      onWillAccept: (data) {
        print('Target: onWillAccept()');
        controller.forward();
        return true;
      },
      onAccept: (MaterialColor color) {
        //print('Target: onAccept()');
        widgetColor = color;
        print('COLORS!!!!!');
      },
      onLeave: (data) {
        print('Target: onLeave()');
        controller.reverse();
      },
    );
  }

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = Tween<double>(begin: 10, end: 100).animate((controller))
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ClipItem extends StatefulWidget {
  final Color color;
  int position;

  ClipItem(this.color, this.position);

  int changePosition(int position) {
    position = position;
    return position;
  }

  @override
  _ClipItemState createState() => _ClipItemState();
}

class _ClipItemState extends State<ClipItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: widget.color,
    );
  }
}
