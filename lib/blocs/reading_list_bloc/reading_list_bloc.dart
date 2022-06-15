import 'package:bloc/bloc.dart';
import 'package:book_tracking/models/books.dart';
import 'package:equatable/equatable.dart';

part 'reading_list_event.dart';
part 'reading_list_state.dart';

class ReadingListBloc extends Bloc<ReadingListEvent, ReadingListState> {
  final List<Book> list;
  ReadingListBloc({this.list}) : super(ReadingListInitial()) {
    on<AddBookEvent>((event, emit) {
      emit(Loading());
      final book = event.book;
      list.add(book);
      emit(UpdatedList(list));
    });

    on<ChangeShortBookEvent>((event, emit) {
      emit(Loading());
      if (event.newIndex > event.olderIndex) {
        event.newIndex -= 1;
      }
      final item = list.removeAt(event.olderIndex);
      list.insert(event.newIndex, item);
      emit(UpdatedList(list));
    });

    on<DeleteBookEvent>((event, emit) {
      emit(Loading());

      list.remove(event.book);

      emit(UpdatedList(list));
    });
  }
}
