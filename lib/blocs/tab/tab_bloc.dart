import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:goalsflutter/blocs/tab/tab.dart';
import 'package:goalsflutter/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.goals;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
