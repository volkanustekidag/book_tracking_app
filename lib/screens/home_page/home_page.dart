import 'package:book_tracking/blocs/book_bloc/book_bloc.dart';
import 'package:book_tracking/blocs/home_page_bottom_nav_bloc/bottom_navigation_bloc.dart';
import 'package:book_tracking/screens/book_list_page/book_list_page.dart';
import 'package:book_tracking/screens/reading_list_page/reading_list_page.dart';
import 'package:book_tracking/screens/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookBloc>(context).add(BookRequest());
  }

  List<Widget> widgetOptions = [
    BookListPage(),
    ReadingListPage(),
    SettingsPage()
  ];

  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar:
        BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        if (state is ChangedPage) {
          current = state.newIndex;
          print(state.newIndex);
        }
        return BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          backgroundColor: Color(0xff2d2d2d),
          currentIndex: current,
          onTap: (value) {
            BlocProvider.of<BottomNavigationBloc>(context)
                .add(ChangeCurrentItemNavBar(value));
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.book), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        );
      },
    ), body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        if (state is ChangedPage) return widgetOptions[state.newIndex];

        return BookListPage();
      },
    ));
  }
}
