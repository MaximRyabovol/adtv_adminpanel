import 'package:flutter/material.dart';

import 'package:adtvadminpanel/widgets/base_clip_item.dart';

mixin DefaultCLipItemState<ClipItem extends BaseClipItem>
    on BaseClipItemState<ClipItem> {
  Color color;
  IconData icon;

  @override
  void initState() {
    super.initState();
    color = Colors.cyanAccent;
    icon = Icons.minimize;
  }

  @override
  Widget build(BuildContext context) {
    double baseHeight = MediaQuery.of(context).size.height;
    double baseWidth = MediaQuery.of(context).size.width;
    return Draggable(
      child: GestureDetector(
        onDoubleTap: () {
          Dialog dialog = Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: baseHeight * 0.8,
              width: baseWidth * 0.5,
            ),
          );
          showDialog(context: context, builder: (context) => dialog);
        },
        child: defaultLayout(context),
      ),
      childWhenDragging: defaultLayout(context),
      feedback: feedbackLayout(context),
      data: widget,
    );
  }

  Widget defaultLayout(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: color,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Icon(
                  icon,
                  size: MediaQuery.of(context).size.height * 0.05,
                ),
              ),
              Center(
                child: Text(
                  '${widget.name}',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    backgroundColor: Colors.white70,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget feedbackLayout(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: color,
      child: Icon(
        icon,
        size: MediaQuery.of(context).size.height * 0.1,
      ),
    );
  }
}
