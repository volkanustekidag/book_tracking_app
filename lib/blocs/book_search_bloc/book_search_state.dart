part of 'book_search_bloc.dart';

abstract class BookSearchState extends Equatable {
  const BookSearchState();

  @override
  List<Object> get props => [];
}

class CombineSearchBlocInitial extends BookSearchState {}

class BookVisibilityState extends BookSearchState {
  bool visibility;
  BookVisibilityState({this.visibility});

  @override
  List<Object> get props => [visibility];
}
