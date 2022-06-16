import 'package:book_tracking/blocs/book_bloc/book_bloc.dart';
import 'package:book_tracking/components/app_bar.dart';
import 'package:book_tracking/screens/book_details_page/book_details_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final TextEditingController textEditingController = TextEditingController();

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
            Flexible(
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
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                "All books(${state.books.length})",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: 0.5,
                                children: List.generate(books.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BookDetails(
                                                  book: books[index])));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              blurRadius: 10,
                                              offset: Offset(0, 6),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Hero(
                                              tag: "${books[index].id}",
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    books[index].image,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              books[index].title,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              books[index].author,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  books[index].genre,
                                                  style: TextStyle(
                                                      color: Colors.black38),
                                                ),
                                                Text(
                                                  books[index].published,
                                                  style: TextStyle(
                                                      color: Colors.black38),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
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
}
