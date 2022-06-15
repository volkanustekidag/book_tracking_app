import 'package:book_tracking/blocs/reading_list_bloc/reading_list_bloc.dart';
import 'package:book_tracking/models/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReadingListPage extends StatefulWidget {
  const ReadingListPage({Key key}) : super(key: key);

  @override
  State<ReadingListPage> createState() => _ReadingListPageState();
}

class _ReadingListPageState extends State<ReadingListPage> {
  List<String> item = ["Clients", "Designer", "Developer", "Director", "Owner"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: Icon(
            Icons.menu,
            color: Color(0xff2d2d2d),
          ),
          elevation: 0,
          title: Text(
            "READİNG LİST",
            style: TextStyle(
                color: Color(0xff2d2d2d),
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
        ),
        body: BlocBuilder<ReadingListBloc, ReadingListState>(
          builder: (context, state) {
            if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UpdatedList) {
              return ReorderableListView(
                children: <Widget>[
                  for (Book items in state.readingList)
                    GestureDetector(
                      key: ValueKey(items),
                      onTap: () {},
                      child: Slidable(
                        key: ValueKey(items),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                BlocProvider.of<ReadingListBloc>(context)
                                    .add(DeleteBookEvent(book: items));
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                              title: Column(
                                children: [
                                  Text(items.title),
                                  Text(items.author),
                                ],
                              ),
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(items.image))),
                        ),
                      ),
                    ),
                ],
                onReorder: reorderData,
              );
            }
            return Container();
          },
        ));
  }

  void reorderData(int oldindex, int newindex) {
    BlocProvider.of<ReadingListBloc>(context)
        .add(ChangeShortBookEvent(newIndex: newindex, olderIndex: oldindex));
  }
}
