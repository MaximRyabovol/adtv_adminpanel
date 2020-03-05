import 'package:flutter/material.dart';

import 'main_screen_bloc.dart';

class MainScreenProvider extends InheritedWidget {
  final bloc = MainScreenBloc();

  MainScreenProvider({Key key, Widget child}) : super(key: key, child: child);

  static MainScreenBloc of(BuildContext context) {
    return (context
        .dependOnInheritedWidgetOfExactType<MainScreenProvider>()
        .bloc);
  }

  @override
  bool updateShouldNotify(_) => true;
}
