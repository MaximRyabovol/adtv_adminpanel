import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../widgets/base_play_list_Item.dart';
import '../widgets/targetable_space.dart';
import '../widgets/clip_item.dart';

class Bloc {
  List<BasePlayListItem> playList = [];

  BehaviorSubject<List<BasePlayListItem>> _allPlayListController =
      BehaviorSubject<List<BasePlayListItem>>();
  Sink<List<BasePlayListItem>> get inAllPlayList => _allPlayListController.sink;

  Stream<List<BasePlayListItem>> get freshPlayList {
    return _allPlayListController.stream;
  }

  BehaviorSubject<TargetableSpace> _changePlayListController =
      BehaviorSubject<TargetableSpace>();

  Stream<TargetableSpace> get sendChangePlayList {
    return _changePlayListController.stream;
  }

  Sink<TargetableSpace> get inChangePlayList => _changePlayListController.sink;

  Bloc() {
    _changePlayListController.listen(handleChangePlayList);
    playList.add(ClipItem(Colors.black, 2));
    playList.add(ClipItem(Colors.amber, 2));
    playList.add(ClipItem(Colors.deepPurpleAccent, 2));
    playList.add(ClipItem(Colors.blue, 0));
    playList.add(ClipItem(Colors.red, 1));
    playList.add(ClipItem(Colors.black, 2));
    playList.add(ClipItem(Colors.amber, 2));
    playList.add(ClipItem(Colors.deepPurpleAccent, 2));
    playList.add(ClipItem(Colors.blue, 0));
    playList.add(ClipItem(Colors.red, 1));
    playList.add(ClipItem(Colors.black, 2));
    playList.add(ClipItem(Colors.blue, 0));
    playList.add(ClipItem(Colors.red, 1));
    playList.add(ClipItem(Colors.black, 2));
    playList.add(ClipItem(Colors.blue, 0));
    playList.add(ClipItem(Colors.red, 1));
    playList.add(ClipItem(Colors.black, 2));
    arrangeListWithTargetSpaces();
    _notify();
  }

  void handleChangePlayList(TargetableSpace target) {
    int targetOldIndex = target.index;
    int insertClipOldIndex = target.child.index;

    ClipItem insertClip = target.child;
    insertClip.setIndex(targetOldIndex);

    playList.remove(insertClip);

    playList.insert(targetOldIndex, insertClip);
    clearPlayList();
    arrangeListWithTargetSpaces();
    setIndexPlayListItems();

    _notify();
  }

  void clearPlayList() {
    for (BasePlayListItem item in playList) {
      if (item is TargetableSpace) {
        playList.remove(item);
      }
    }
  }

  void arrangeListWithTargetSpaces() {
    clearPlayList();
    for (int i = 1; i < playList.length; i++) {
      if (!i.isEven) {
        playList.insert(i, TargetableSpace(i));
      }
    }
    playList.insert(0, TargetableSpace(0));
    playList.insert(playList.length, TargetableSpace(playList.length - 1));

    setIndexPlayListItems();
  }

  void setIndexPlayListItems() {
    for (int i = 0; i < playList.length; i++) {
      playList[i].setIndex(i);
    }
  }

  void dispose() {
    _allPlayListController.close();
    _changePlayListController.close();
  }

  void _notify() {
    inAllPlayList.add(playList);
  }
}
