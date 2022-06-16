part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class BottomNavgationInitial extends BottomNavigationState {}

// ignore: must_be_immutable
class ChangedPage extends BottomNavigationState {
  int newIndex;
  ChangedPage({this.newIndex});
  @override
  List<Object> get props => [newIndex];
}
