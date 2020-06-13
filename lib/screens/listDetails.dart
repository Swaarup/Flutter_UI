import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:uitask/helpers/floatingactbutton.dart';
import 'package:uitask/models/content.dart';

class ListDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListState();
  }
}

class _ListState extends State<ListDetails> with TickerProviderStateMixin {
  ScrollController scrollController;
  bool dialVisible = true;

  List<Content> listContent = [];

  List<Content> archivedContent = [];

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Details'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              maxHeight: 300.0,
            ),
            child: getArchiveListView(),
          ),
          Container(
            child: Text("This is second list"),
            height: 40.0,
            margin: EdgeInsets.only(top: 5.0),
          ),
          Expanded(
            child: getListFromClass(),
          )
        ],
      ),
      floatingActionButton: FloatingActButton(dialVisible),
    );
  }

  List<Content> getContentList(int numOfArray) {
    List<Content> list = [];

    for (int i = 0; i < numOfArray; i++) {
      list.add(Content("Title $i", 'Subtitle', 'Description of Subtitle.'));
    }
    return list;
  }

  Widget getListFromClass() {
    if (listContent == null || listContent.isEmpty) {
      listContent = getContentList(15);
    }
    return ListView.builder(
        itemCount: listContent.length,
        itemBuilder: (context, index) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: GestureDetector(
              child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightGreenAccent,
                    child: Icon(Icons.keyboard_arrow_right),
                    foregroundColor: Colors.white,
                  ),
                  title: Text(listContent[index].title),
                  subtitle: Visibility(
                    visible: listContent[index].isSelected ? true : false,
                      child: Row(
                        children: <Widget>[
                          Text(listContent[index].subtitle2, ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(listContent[index].subtitle),
                          )
                        ],
                      )
                  )),
              onTap: () {
                setState(() {
                  listContent[index].isSelected =
                      !listContent[index].isSelected;
                });
              },
            ),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Add Item',
                color: Colors.lime,
                icon: Icons.archive,
                onTap: () {
                  setState(() {
                    updateLists(index, context);
                  });
                  print("Add to upper list $index");
                },
              )
            ],
          );
        },
        shrinkWrap: true);
  }

  void updateArchiveList(int index) {
    listContent.add(archivedContent[index]);
    archivedContent.remove(archivedContent[index]);
  }

  void updateLists(int index, BuildContext context) {
    if (archivedContent == null || archivedContent.isEmpty) {
      archivedContent = <Content>[listContent[index]];
      listContent.remove(listContent[index]);
    } else if (archivedContent.length >= 3) {
      createSnackBar("Already three activities running.", context);
    } else {
      archivedContent.add(listContent[index]);
      listContent.remove(listContent[index]);
    }
  }

  Widget getArchiveListView() {
    if (archivedContent == null || archivedContent.length == 0) {
      return Container(
        color: Colors.red,
        height: 20.0,
        alignment: Alignment.center,
        child: Text("Please add Something Here"),
      );
    } else {
      var listView = ListView.builder(
          itemCount: archivedContent.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: GestureDetector(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightGreenAccent,
                    child: Icon(Icons.keyboard_arrow_right),
                    foregroundColor: Colors.white,
                  ),
                  title: Text(archivedContent[index].title),
                  subtitle: Visibility(
                      visible:
                          (archivedContent[index].isSelected) ? true : false,
                      child: Row(
                        children: <Widget>[
                          Text(archivedContent[index].subtitle2, ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(archivedContent[index].subtitle),
                          )
                        ],
                      )),
                ),
                onTap: () {
                  setState(() {
                    archivedContent[index].isSelected =
                        !archivedContent[index].isSelected;
                  });
                },
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Remove',
                  color: Colors.redAccent,
                  icon: Icons.remove_circle,
                  onTap: () {
                    setState(() {
                      updateArchiveList(index);
                    });
                    print("Remove from archive $index");
                  },
                )
              ],
            );
          },
          shrinkWrap: true);
      return listView;
    }
  }

  void createSnackBar(String message, BuildContext context) {
    final snackBar =
        new SnackBar(content: new Text(message), backgroundColor: Colors.red);

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
