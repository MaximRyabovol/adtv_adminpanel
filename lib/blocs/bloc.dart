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
    playList.add(ClipItem(Colors.blue, 0));
    playList.add(ClipItem(Colors.red, 1));
    playList.add(ClipItem(Colors.black, 2));
    playList.add(ClipItem(Colors.amber, 3));
    playList.add(ClipItem(Colors.cyanAccent, 4));
    playList.add(ClipItem(Colors.deepPurple, 5));
    arrangeListWithTargetSpaces();
    _notify();
  }

  void handleChangePlayList(TargetableSpace target) {
    int targetOldIndex = target.index;
    int insertClipOldIndex = target.child.index;

    ClipItem insertClip = target.child;
    insertClip.setIndex(targetOldIndex);

    if (targetOldIndex == playList.length - 1) {
      playList.removeLast();
      insertClip.setIndex(playList.length - 1);
      playList.insert(playList.length, TargetableSpace(0));
      playList.insert(playList.length, insertClip);
      playList.insert(playList.length, TargetableSpace(0));
      playList.removeRange(insertClipOldIndex - 1, insertClipOldIndex + 1);
      setIndexPlayListItems();
    } else {
      print('targetOldIndex: $targetOldIndex');
      print('insertClipOldIndex: $insertClipOldIndex');
      if (insertClipOldIndex - 1 < 0) {
        playList.removeAt(insertClipOldIndex - 1);
      }
      if (insertClipOldIndex + 1 < playList.length) {
        playList.removeAt(insertClipOldIndex + 1);
      }
      playList.removeAt(insertClipOldIndex);

      insertClip.setIndex(targetOldIndex);
      playList.replaceRange(
          targetOldIndex, targetOldIndex, [TargetableSpace(0), insertClip]);

      setIndexPlayListItems();
    }
    _notify();
  }

  void insertTargetsSpaces(BasePlayListItem baseItem) {
    int start = baseItem.index - 1;
    print('START: $start');
    int end = baseItem.index;
    print('END: $end');

    if (start < 0) {
      start = 0;
    }

    if (end > playList.length - 1) {
      end = playList.length - 1;
    }

    playList.insert(start, TargetableSpace(start));
    playList.insert(end, TargetableSpace(end));
    setIndexPlayListItems();
  }

  void arrangeListWithTargetSpaces() {
    for (int i = 1; i < playList.length; i++) {
      if (!i.isEven) {
        playList.insert(i, TargetableSpace(i));
      }
    }
    playList.insert(0, TargetableSpace(0));
    playList.add(TargetableSpace(playList.length - 1));

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
