part of 'book_bloc.dart';

@immutable
abstract class BookEvent extends Equatable {
  const BookEvent();

  List<Object> get probs => [];
}

class BookRequest extends BookEvent {
  @override
  List<Object> get props => [];
}

class BookRefresh extends BookEvent {
  @override
  List<Object> get props => [];
}

class BookSearch extends BookEvent {
  final String query;

  BookSearch({@required this.query});

  @override
  List<Object> get props => [];
}
