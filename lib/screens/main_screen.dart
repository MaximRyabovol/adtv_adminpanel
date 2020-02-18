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
  List<Widget> playList = [getSquare(), getSquare(), getSquare()];

  @override
  void initState() {
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
                final item = playList[index];
                if (item is TargetableSpace) {
                  return TargetableSpace();
                } else {
                  return getSquare();
                }
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

  void changePlayList() {
    playList.insert(0, TargetableSpace());

    for (int i = 1; i < playList.length; i++) {
      if (!i.isEven) {
        playList.insert(i, TargetableSpace());
      }
    }
    playList.add(TargetableSpace());
  }
}

class TargetableSpace extends StatefulWidget {
  @override
  _TargetableSpaceState createState() => _TargetableSpaceState();
}

class _TargetableSpaceState extends State<TargetableSpace>
    with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
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

/*class TargetableSpace extends StatelessWidget {
  const TargetableSpace({
    Key key,
    @required this.animation,
    @required this.controller,
  }) : super(key: key);

  final Animation<double> animation;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
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
    );
  }
}*/

class TargetItem {}

class ClipItem {
  final Color color;

  ClipItem(this.color);
}
