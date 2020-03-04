import 'package:flutter/material.dart';

import 'package:adtvadminpanel/widgets/base_clip_item.dart';
import 'package:adtvadminpanel/widgets/default_clip_item_state.dart';

class VideoClipItem extends BaseClipItem {
  VideoClipItem({int index, Duration duration, String dataPath, String name})
      : super(index: index, duration: duration, dataPath: dataPath, name: name);

  @override
  _VideoClipItemState createState() => _VideoClipItemState();
}

class _VideoClipItemState extends BaseClipItemState<VideoClipItem>
    with DefaultCLipItemState {
  @override
  void initState() {
    super.initState();
    color = Colors.green.withOpacity(0.8);
    icon = Icons.play_circle_outline;
  }
}
