part of 'book_bloc.dart';

@immutable
abstract class BookState extends Equatable {
  const BookState();
  List<Object> get probs => [];
}

class BookInitial extends BookState {
  @override
  List<Object> get props => [];
}

class BookLoading extends BookState {
  @override
  List<Object> get props => [];
}

class BookFailure extends BookState {
  @override
  List<Object> get props => [];
}

class BookSucces extends BookState {
  final books;
  const BookSucces({this.books});

  @override
  List<Object> get props => [books];
}
