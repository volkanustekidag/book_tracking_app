import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'book_search_event.dart';
part 'book_search_state.dart';

class BookSearchBloc extends Bloc<BookSearchBlocEvent, BookSearchState> {
  BookSearchBloc() : super(CombineSearchBlocInitial()) {
    on<ChangeSearchVisibilityEvent>((event, emit) {
      emit(BookVisibilityState(visibility: event.visibility));
    });
  }
}
