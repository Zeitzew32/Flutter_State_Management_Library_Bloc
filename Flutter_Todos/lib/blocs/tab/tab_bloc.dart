import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Flutter_Todos/models/models.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.todos);

  @override
  Stream<AppTab> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
