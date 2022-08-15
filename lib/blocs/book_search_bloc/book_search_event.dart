part of 'book_search_bloc.dart';

abstract class BookSearchBlocEvent extends Equatable {
  const BookSearchBlocEvent();

  @override
  List<Object> get props => [];
}

class ChangeSearchVisibilityEvent extends BookSearchBlocEvent {
  bool visibility;
  ChangeSearchVisibilityEvent({this.visibility});

  @override
  List<Object> get props => [visibility];
}
