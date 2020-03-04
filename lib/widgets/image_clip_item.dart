import 'package:flutter/material.dart';

import 'package:adtvadminpanel/widgets/base_clip_item.dart';
import 'default_clip_item_state.dart';

class ImageClipItem extends BaseClipItem {
  ImageClipItem({
    int index,
    Duration duration,
    String dataPath,
    String name,
  }) : super(
          index: index,
          duration: duration,
          dataPath: dataPath,
          name: name,
        );

  @override
  _ImageClipItemState createState() => _ImageClipItemState();
}

class _ImageClipItemState extends BaseClipItemState<ImageClipItem>
    with DefaultCLipItemState {
  @override
  void initState() {
    super.initState();
    color = Colors.yellow.withOpacity(0.8);
    icon = Icons.image;
  }
}
