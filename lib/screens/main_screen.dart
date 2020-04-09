import 'package:flutter/material.dart';

import '../blocs/main_screen_bloc.dart';
import '../widgets/base_clip_item.dart';
import '../blocs/main_screen_provider.dart';
import '../widgets/image_item.dart';
import '../widgets/video_item.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainScreenBloc bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = MainScreenProvider.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Text('1'),
            Text('1'),
            Text('1'),
            Text('1'),
            Text('1'),
          ],
        ),
      ),
      backgroundColor: Colors.blue.withOpacity(0.5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                color: Colors.blue.withOpacity(0.8),
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.85,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Галерея креативов',
                        style: TextStyle(fontSize: 30),
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder(
                stream: bloc.freshPlayList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<BaseClipItem>> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  height: 130,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return snapshot.data[index];
                                    },
                                  ),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {},
                                child: Text('Сформировать клип'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        width: 100,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              labelText: '#Теги'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: 100,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              labelText: 'Поиск'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: GridView.count(
                                    crossAxisCount: 10,
                                    padding: EdgeInsets.all(10),
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    children: <Widget>[
                                      ImageItem(
                                        index: 100,
                                        duration: Duration(minutes: 1),
                                        dataPath:
                                            'https://cdn.pixabay.com/photo/2020/02/28/09/42/willow-4887000_1280.jpg',
                                        name: 'Image #3',
                                      ),
                                      ImageItem(
                                        index: 50,
                                        duration: Duration(minutes: 1),
                                        dataPath:
                                            'https://cdn.pixabay.com/photo/2020/02/26/16/30/butterfly-4882217_1280.jpg',
                                        name: 'Image #2',
                                      ),
                                      ImageItem(
                                        index: 34,
                                        duration: Duration(minutes: 1),
                                        dataPath:
                                            'https://cdn.pixabay.com/photo/2020/02/27/20/57/dresden-4885833_1280.jpg',
                                        name: 'Image #1',
                                      ),
                                      VideoItem(
                                        index: 44,
                                        duration: Duration(minutes: 1),
                                        dataPath:
                                            'https://ak3.picdn.net/shutterstock/videos/1011845243/preview/stock-footage--d-render-abstract-seamless-background-looped-animation-fluorescent-ultraviolet-light-glowing.webm',
                                        name: 'Video #1',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
