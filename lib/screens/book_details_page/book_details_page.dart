import 'package:book_tracking/blocs/reading_list_bloc/reading_list_bloc.dart';
import 'package:book_tracking/models/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetails extends StatefulWidget {
  final Book book;
  const BookDetails({Key key, @required this.book}) : super(key: key);

  @override
  State<BookDetails> createState() => _BookDetailsState(book: book);
}

class _BookDetailsState extends State<BookDetails> {
  final Book book;

  _BookDetailsState({this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<ReadingListBloc, ReadingListState>(
              builder: (context, state) {
                List<Book> list;
                if (state is UpdatedList) {
                  list = state.readingList;

                  return IconButton(
                      onPressed: () {
                        if (list.contains(book)) {
                          BlocProvider.of<ReadingListBloc>(context)
                              .add(DeleteBookEvent(book: book));
                        } else {
                          BlocProvider.of<ReadingListBloc>(context)
                              .add(AddBookEvent(book));
                        }
                      },
                      icon: Icon(
                        list.contains(book)
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: Colors.white,
                      ));
                }
                if (state is ReadingListInitial) {
                  return IconButton(
                      onPressed: () {
                        BlocProvider.of<ReadingListBloc>(context)
                            .add(AddBookEvent(book));
                      },
                      icon: Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                      ));
                }
                return Container();
              },
            )
          ],
          backgroundColor: Color(0xff2d2d2d),
          elevation: 0,
          backwardsCompatibility: false,
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xff2d2d2d),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70, left: 10),
                      child: ListView(
                        children: [
                          Text(
                            book.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Divider(color: Colors.transparent),
                          Text("Author",
                              style: TextStyle(color: Colors.black45)),
                          Text(book.author),
                          Divider(color: Colors.transparent),
                          Text("Genre",
                              style: TextStyle(color: Colors.black45)),
                          Text(book.genre),
                          Divider(color: Colors.transparent),
                          Text("Description",
                              style: TextStyle(color: Colors.black45)),
                          Text(book.description),
                          Divider(color: Colors.transparent),
                          Text("Isbn", style: TextStyle(color: Colors.black45)),
                          Text(book.isbn),
                          Divider(color: Colors.transparent),
                          Text("Published",
                              style: TextStyle(color: Colors.black45)),
                          Text(book.published),
                          Divider(color: Colors.transparent),
                          Text("Publisher",
                              style: TextStyle(color: Colors.black45)),
                          Text(book.publisher),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Hero(
                    tag: "${book.id}",
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          book.image,
                          height: 230,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
