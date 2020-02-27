import 'dart:math';
import 'package:flutter/material.dart';
import 'clip_item.dart';
import 'base_play_list_Item.dart';
import '../blocs/provider.dart';

class TargetableSpace extends BasePlayListItem {
  ClipItem child = null;

  TargetableSpace(int position) {
    super.index = position;
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
    final bloc = Provider.of(context);
    return StreamBuilder(
      stream: bloc.sendChangePlayList,
      builder: (BuildContext context, snapshot) {
        return DragTarget(
          builder: (context, candidate, rejected) {
            return Container(
              height: 100,
              width: animation.value,
              color: widgetColor,
            );
          },
          onWillAccept: (ClipItem clipItem) {
            var v = (widget.index - clipItem.index).abs();
            if (v <= 1) {
              return false;
            }
            controller.forward();
            return true;
          },
          onAccept: (ClipItem clipItem) {
            widget.child = clipItem;
            bloc.handleChangePlayList(widget);
            controller.reverse();
          },
          onLeave: (data) {
            controller.reverse();
          },
        );
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
