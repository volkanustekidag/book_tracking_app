import 'package:book_tracking/repositories/book_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;

  BookBloc({@required this.bookRepository}) : super(BookInitial()) {
    on<BookRequest>((event, emit) async {
      emit(BookLoading());

      try {
        final books = await bookRepository.getBooks();
        emit(BookSucces(books: books));
      } catch (e) {
        emit(BookFailure());
      }
    });

    on<BookSearch>((event, emit) async {
      emit(BookLoading());

      try {
        final books = bookRepository.searchBook(
            await bookRepository.getBooks(), event.query);
        emit(BookSucces(books: books));
      } catch (e) {}
    });
  }
}
