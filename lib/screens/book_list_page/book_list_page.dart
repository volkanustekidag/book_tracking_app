import 'package:book_tracking/blocs/book_bloc/book_bloc.dart';
import 'package:book_tracking/blocs/book_search_bloc/book_search_bloc.dart';
import 'package:book_tracking/components/app_bar.dart';
import 'package:book_tracking/screens/book_details_page/book_details_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();

    BlocProvider.of<BookSearchBloc>(context)
        .add(ChangeSearchVisibilityEvent(visibility: true));

    scrollController.addListener(() {
      print(scrollController.position.pixels);
      if (scrollController.position.pixels > 0) {
        BlocProvider.of<BookSearchBloc>(context)
            .add(ChangeSearchVisibilityEvent(visibility: false));
      } else {
        BlocProvider.of<BookSearchBloc>(context)
            .add(ChangeSearchVisibilityEvent(visibility: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuild("BOOKTRACKİNG"),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            searchTextFormFieldBuild(),
            Expanded(
              flex: 9,
              child: Container(
                  color: Colors.white,
                  child: BlocBuilder<BookBloc, BookState>(
                    builder: (context, state) {
                      if (state is BookLoading) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        ));
                      }
                      if (state is BookSucces) {
                        final books = state.books;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "All books(${state.books.length})",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 2,
                                controller: scrollController,
                                childAspectRatio: 0.5,
                                children: List.generate(books.length, (index) {
                                  return listItemBuild(context, books, index);
                                }),
                              ),
                            ),
                          ],
                        );
                      }
                      if (state is BookFailure) {
                        return Center(
                          child: Text("Something went wrong!"),
                        );
                      }
                      return Container();
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  BlocConsumer<BookSearchBloc, BookSearchState> searchTextFormFieldBuild() {
    return BlocConsumer<BookSearchBloc, BookSearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is BookVisibilityState) {
          return AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: state.visibility ? 1 : 0,
            child: Visibility(
              visible: state.visibility,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffF6F8FA),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: textEditingController,
                  onChanged: (query) {
                    BlocProvider.of<BookBloc>(context)
                        .add(BookSearch(query: query));
                    print(textEditingController.text);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xffD0D0D2),
                    ),
                    suffixIcon: IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (textEditingController.text.isNotEmpty) {
                            BlocProvider.of<BookBloc>(context)
                                .add(BookSearch(query: ""));
                          }
                          textEditingController.clear();
                          FocusScope.of(context).unfocus();
                        });
                      },
                      icon: Icon(Icons.close),
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(
                        color: Color(0xffD0D0D2), fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  GestureDetector listItemBuild(BuildContext context, books, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetails(book: books[index])));
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Hero(
                tag: "${books[index].id}",
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      books[index].image,
                    ),
                  ),
                ),
              ),
              Text(
                books[index].title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15.sp),
              ),
              Text(
                books[index].author,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    books[index].genre,
                    style: TextStyle(color: Colors.black38),
                  ),
                  Text(
                    books[index].published,
                    style: TextStyle(color: Colors.black38),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
