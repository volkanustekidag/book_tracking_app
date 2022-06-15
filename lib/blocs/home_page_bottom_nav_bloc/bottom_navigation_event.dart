part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ChangeCurrentItemNavBar extends BottomNavigationEvent {
  int newIndex;

  ChangeCurrentItemNavBar(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}
