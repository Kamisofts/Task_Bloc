part of 'tabs_bloc.dart';


abstract class TabsEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class TabsPendingEvent extends TabsEvent{}
class TabsCompletedEvent extends TabsEvent{}
class TabsFavoriteEvent extends TabsEvent{}
