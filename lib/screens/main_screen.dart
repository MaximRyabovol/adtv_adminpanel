import 'package:flutter/material.dart';
import '../widgets/clip_item.dart';
import '../widgets/targetable_space.dart';
import '../widgets/base_play_list_Item.dart';
import '../blocs/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

Widget getSquare() {
  return Container(
    height: 100,
    width: 100,
    color: Colors.purple,
  );
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  //List<Widget> playList = [];

  @override
  void initState() {
    //initPlayList();
    //arrangeListWithTargetSpaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return StreamBuilder(
      stream: bloc.freshPlayList,
      builder: (BuildContext context,
          AsyncSnapshot<List<BasePlayListItem>> snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return snapshot.data[index];
                      },
                    ),
                  ),
                ),
                ClipItem(Colors.teal, 100),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
/*  void initPlayList() {
    playList.add(ClipItem(Colors.blue, 0));
    playList.add(ClipItem(Colors.red, 1));
    playList.add(ClipItem(Colors.black, 2));
  }

  void arrangeListWithTargetSpaces() {
    for (int i = 1; i < playList.length; i++) {
      if (!i.isEven) {
        playList.insert(i, TargetableSpace(i));
      }
    }
    playList.insert(0, TargetableSpace(0));
    playList.add(TargetableSpace(playList.length - 1));
  }*/
}
