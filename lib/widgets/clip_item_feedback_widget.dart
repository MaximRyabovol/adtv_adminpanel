import 'package:flutter/material.dart';

class ClipItemFeedbackWidget extends StatefulWidget {
  Color backgroundColor;
  IconData icon;

  ClipItemFeedbackWidget({
    @required this.backgroundColor,
    @required this.icon,
  });

  @override
  _ClipItemFeedbackWidgetState createState() => _ClipItemFeedbackWidgetState();
}

class _ClipItemFeedbackWidgetState extends State<ClipItemFeedbackWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: widget.backgroundColor,
      child: Icon(
        widget.icon,
        size: MediaQuery.of(context).size.height * 0.1,
      ),
    );
  }
}
