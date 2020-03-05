import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:adtvadminpanel/widgets/base_clip_item.dart';
import 'clip_item_main_widget.dart';
import 'clip_item_feedback_widget.dart';

class VideoItem extends BaseClipItem {
  VideoItem({
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
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends BaseClipItemState<VideoItem> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('${widget.dataPath}')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
              child: _controller.value.initialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller..play()),
                    )
                  : Container(
                      height: baseHeight * 0.3,
                      width: baseWidth * 0.3,
                      child: CircularProgressIndicator(),
                    ),
            ),
          );
          showDialog(
            context: context,
            builder: (context) => dialog,
          );
        },
        child: ClipItemMainWidget(
          backgroundColor: Colors.green.withOpacity(0.8),
          icon: Icons.play_circle_outline,
          title: widget.name,
        ),
      ),
      childWhenDragging: ClipItemMainWidget(
        backgroundColor: Colors.green.withOpacity(0.8),
        icon: Icons.play_circle_outline,
        title: widget.name,
      ),
      feedback: ClipItemFeedbackWidget(
          backgroundColor: Colors.green.withOpacity(0.8),
          icon: Icons.play_circle_outline),
      data: widget,
    );
  }
}
