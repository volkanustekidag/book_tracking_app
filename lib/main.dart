import 'package:book_tracking/blocs/block_observer.dart';
import 'package:book_tracking/blocs/book_bloc/book_bloc.dart';
import 'package:book_tracking/blocs/book_search_bloc/book_search_bloc.dart';
import 'package:book_tracking/blocs/home_page_bottom_nav_bloc/bottom_navigation_bloc.dart';
import 'package:book_tracking/blocs/reading_list_bloc/reading_list_bloc.dart';
import 'package:book_tracking/models/books.dart';
import 'package:book_tracking/repositories/book_repository.dart';
import 'package:book_tracking/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

void main() {
  final BookRepository bookRepository =
      BookRepository(httpClient: http.Client());
  final List<Book> list = [];
  BlocOverrides.runZoned(
    () => runApp(MyApp(
      bookRepository: bookRepository,
      readingList: list,
    )),
    blocObserver: BooksBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final BookRepository bookRepository;
  final readingList;

  const MyApp({Key key, this.bookRepository, this.readingList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookBloc(bookRepository: bookRepository),
        ),
        BlocProvider(
          create: (context) => ReadingListBloc(list: readingList),
        ),
        BlocProvider(
          create: (context) => BottomNavigationBloc(),
        ),
        BlocProvider(
          create: (context) => BookSearchBloc(),
        ),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Book Tracking',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
        );
      }),
    );
  }
}
