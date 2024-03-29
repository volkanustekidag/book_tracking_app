import 'package:book_tracking/blocs/reading_list_bloc/reading_list_bloc.dart';
import 'package:book_tracking/const/constant.dart';
import 'package:book_tracking/models/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

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
          backgroundColor: primaryColor,
          elevation: 0,
          backwardsCompatibility: false,
        ),
        body: Center(
          child: Container(
            width: getWidth(context, 1),
            height: getHeight(context, 1),
            color: primaryColor,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: getWidth(context, 1),
                    height: getHeight(context, 0.65),
                    decoration: detailsContainerDecoration,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70, left: 10),
                      child: ListView(
                        children: [
                          Text(
                            book.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.sp),
                          ),
                          Divider(color: Colors.transparent),
                          Text("Author", style: detailsTitleTextStyle),
                          Text(book.author),
                          Divider(color: Colors.transparent),
                          Text("Genre", style: detailsTitleTextStyle),
                          Text(book.genre),
                          Divider(color: Colors.transparent),
                          Text("Description", style: detailsTitleTextStyle),
                          Text(book.description),
                          Divider(color: Colors.transparent),
                          Text("Isbn", style: detailsTitleTextStyle),
                          Text(book.isbn),
                          Divider(color: Colors.transparent),
                          Text("Published", style: detailsTitleTextStyle),
                          Text(book.published),
                          Divider(color: Colors.transparent),
                          Text("Publisher", style: detailsTitleTextStyle),
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
                          height: 30.h,
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
