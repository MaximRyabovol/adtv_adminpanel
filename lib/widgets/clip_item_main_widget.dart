import 'package:flutter/material.dart';

class ClipItemMainWidget extends StatefulWidget {
  Color backgroundColor;
  IconData icon;
  String title;
  BoxDecoration backgroundDecoration;

  ClipItemMainWidget({
    this.backgroundColor,
    @required this.icon,
    @required this.title,
    this.backgroundDecoration,
  });

  @override
  _ClipItemMainWidgetState createState() => _ClipItemMainWidgetState();
}

class _ClipItemMainWidgetState extends State<ClipItemMainWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: widget.backgroundColor ?? null,
      decoration: widget.backgroundDecoration ?? null,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Icon(
                  widget.icon,
                  size: MediaQuery.of(context).size.height * 0.05,
                ),
              ),
              Center(
                child: Text(
                  '${widget.title}',
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
      color: widget.backgroundColor,
      child: Icon(
        Icons.play_circle_outline,
        size: MediaQuery.of(context).size.height * 0.1,
      ),
    );
  }
}
