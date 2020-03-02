import 'package:flutter/material.dart';
import 'base_play_list_Item.dart';

class ClipItem extends BasePlayListItem {
  final Color color;

  ClipItem(this.color, int position) {
    super.index = position;
  }

  @override
  _ClipItemState createState() => _ClipItemState();
}

class _ClipItemState extends State<ClipItem> {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: GestureDetector(
        onDoubleTap: () {
          Dialog dialog = Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          );
          showDialog(context: context, builder: (context) => dialog);
        },
        child: Container(
          height: 100,
          width: 100,
          color: widget.color,
        ),
      ),
      childWhenDragging: Container(
        height: 100,
        width: 100,
        color: widget.color.withOpacity(0.4),
      ),
      feedback: Container(
        height: 100,
        width: 100,
        color: widget.color,
      ),
      data: widget,
    );
  }
}
