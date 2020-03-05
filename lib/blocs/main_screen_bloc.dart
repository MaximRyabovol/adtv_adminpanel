import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../widgets/targetable_space.dart';
import '../widgets/base_clip_item.dart';

//for downloading files
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class MainScreenBloc {
  List<BaseClipItem> playList = [];

  BehaviorSubject<List<BaseClipItem>> _allPlayListController =
      BehaviorSubject<List<BaseClipItem>>();
  Sink<List<BaseClipItem>> get inAllPlayList => _allPlayListController.sink;

  Stream<List<BaseClipItem>> get freshPlayList {
    return _allPlayListController.stream;
  }

  BehaviorSubject<TargetableSpace> _changePlayListController =
      BehaviorSubject<TargetableSpace>();

  Stream<TargetableSpace> get sendChangePlayList {
    return _changePlayListController.stream;
  }

  Sink<TargetableSpace> get inChangePlayList => _changePlayListController.sink;

  MainScreenBloc() {
    _changePlayListController.listen(handleChangePlayList);

    playList.add(TargetableSpace(0));
    arrangeListWithTargetSpaces();
    _notify();
  }

  void handleChangePlayList(TargetableSpace target) {
    int targetOldIndex = target.index;
    int insertClipOldIndex = target.child.index;

    BaseClipItem insertClip = target.child;
    insertClip.setIndex(targetOldIndex);

    playList.remove(insertClip);

    playList.insert(targetOldIndex, insertClip);
    clearPlayList();
    arrangeListWithTargetSpaces();
    setIndexPlayListItems();

    _notify();
  }

  void clearPlayList() {
    for (BaseClipItem item in playList) {
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

  //part for downloading files
  List<int> _selectedFile;
  Uint8List _bytesData;

  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result);
      });
      reader.readAsDataUrl(file);
      makeRequest();
    });
  }

  void _handleResult(Object result) {
    //setState?
    _bytesData = Base64Decoder().convert(result.toString().split(".").last);
    _selectedFile = _bytesData;
  }

  //sendFile
  Future makeRequest() async {
    var url = Uri.parse(''); //todo add real URL
    var request = http.MultipartRequest("POST", url);
    request.files.add(
      await http.MultipartFile.fromBytes('file', _selectedFile,
          contentType: MediaType('application', 'octet-stream'),
          filename: 'file_up'),
    );
    request.send().then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) print('Uploaded!');
    });
  }
}
