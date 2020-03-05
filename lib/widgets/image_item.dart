import 'package:flutter/material.dart';

import 'package:adtvadminpanel/widgets/base_clip_item.dart';
import 'clip_item_main_widget.dart';
import 'clip_item_feedback_widget.dart';

class ImageItem extends BaseClipItem {
  ImageItem({
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
  _ImageItemState createState() => _ImageItemState();
}

class _ImageItemState extends BaseClipItemState<ImageItem> {
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
              child: Image.network(
                widget.dataPath,
              ),
            ),
          );
          showDialog(context: context, builder: (context) => dialog);
        },
        child: ClipItemMainWidget(
          icon: Icons.image,
          title: widget.name,
          backgroundDecoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.dataPath), fit: BoxFit.cover),
          ),
        ),
      ),
      childWhenDragging: ClipItemMainWidget(
        icon: Icons.image,
        title: widget.name,
        backgroundDecoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.dataPath), fit: BoxFit.cover),
        ),
      ),
      feedback: ClipItemFeedbackWidget(
        backgroundColor: Colors.yellow.withOpacity(0.8),
        icon: Icons.image,
      ),
      data: widget,
    );
  }
}
