import 'package:equatable/equatable.dart';

import '../bloc_export.dart';

part 'tabs_event.dart';
part 'tabs_state.dart';

class TabsBloc extends HydratedBloc<TabsEvent, TabsState> {
  TabsBloc() : super(const TabsState(selectTab: 0)) {
    on<TabsPendingEvent>((event, emit) {
      emit(const TabsState(selectTab: 0));
    });
    on<TabsCompletedEvent>((event, emit) {
      emit(const TabsState(selectTab: 1));
    });
    on<TabsFavoriteEvent>((event, emit) {
      emit(const TabsState(selectTab: 2));
    });
  }

  @override
  TabsState? fromJson(Map<String, dynamic> json) {
    return TabsState.fromMap(json );
  }

  @override
  Map<String, dynamic>? toJson(TabsState state) {
   return state.toMap();
  }



}
