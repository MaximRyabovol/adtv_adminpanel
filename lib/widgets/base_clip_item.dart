import 'package:flutter/material.dart';

abstract class BaseClipItem extends StatefulWidget {
  int index;
  Duration duration;
  String dataPath;
  String name;

  BaseClipItem({this.index, this.duration, this.dataPath, this.name});

  void setIndex(int newIndex) {
    index = newIndex;
  }

  void setDuration(Duration newDuration) {
    duration = newDuration;
  }
}

abstract class BaseClipItemState<ClipItem extends BaseClipItem>
    extends State<BaseClipItem> {}
