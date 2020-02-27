import 'package:flutter/material.dart';

abstract class BasePlayListItem extends StatefulWidget {
  int index;

  void setIndex(int newIndex) {
    index = newIndex;
  }
}
