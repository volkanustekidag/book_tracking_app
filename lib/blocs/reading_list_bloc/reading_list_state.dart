part of 'reading_list_bloc.dart';

abstract class ReadingListState extends Equatable {
  const ReadingListState();

  @override
  List<Object> get props => [];
}

class ReadingListInitial extends ReadingListState {
  final List<Book> readingList = [];

  ReadingListInitial({readingList});

  @override
  List<Object> get props => [readingList];
}

// ignore: must_be_immutable
class UpdatedList extends ReadingListState {
  final readingList;

  UpdatedList(this.readingList);

  @override
  List<Object> get props => [readingList];
}

class Loading extends ReadingListState {
  @override
  List<Object> get props => [];
}
