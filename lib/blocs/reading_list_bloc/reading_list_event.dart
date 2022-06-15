part of 'reading_list_bloc.dart';

abstract class ReadingListEvent extends Equatable {
  const ReadingListEvent();

  @override
  List<Object> get props => [];
}

class AddBookEvent extends ReadingListEvent {
  final Book book;
  AddBookEvent(this.book);

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class DeleteBookEvent extends ReadingListEvent {
  Book book;
  DeleteBookEvent({this.book});

  @override
  List<Object> get props => [book];
}

// ignore: must_be_immutable
class ChangeShortBookEvent extends ReadingListEvent {
  int olderIndex, newIndex;
  ChangeShortBookEvent({this.newIndex, this.olderIndex});

  @override
  List<Object> get props => [];
}
