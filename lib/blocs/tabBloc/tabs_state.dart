part of 'tabs_bloc.dart';

 class TabsState extends Equatable{

   final int selectTab;
   const TabsState({required this.selectTab});

   @override
  List<Object?> get props => [selectTab];


   Map<String, dynamic> toMap() {
     return {
       "selectTab": selectTab,
     };
   }

   factory TabsState.fromMap(Map<String, dynamic> map) {
     return TabsState(
       selectTab: map["selectTab"] ?? 0,
     );
   }

 }

class TabsInitial extends TabsState {
  const TabsInitial({required super.selectTab});
}
