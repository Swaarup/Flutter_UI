import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListState();
  }
}

class _ListState extends State<ListDetails> with TickerProviderStateMixin {
  _showSnackBar(BuildContext context, String s) {
    final snackBar = SnackBar(content: Text(s));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  List<String> allItems;
  List<String> archivedItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Details'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

             Container (
               constraints: BoxConstraints(
                 maxHeight: 300.0,
               ),
               child:getArchiveView(),
             ),

            Container(
              child: Text("This is second list"),
             height: 40.0,
              margin: EdgeInsets.only(top: 5.0),
            ),
            Expanded(
              child: getSlideableView(),
            )

          ],
        )
    );
  }

  Widget getSlideableView() {
    if (allItems == null) {
      allItems = getListElements();
    }

    return ListView.builder(
        itemCount: allItems.length,
        itemBuilder: (context, index) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.lightGreenAccent,
                child: Text(allItems[index]),
                foregroundColor: Colors.white,
              ),
              title: Text('List Title:' + allItems[index]),
              subtitle: Text('Swipe Right to Archive'),
            ),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Add Item',
                color: Colors.lime,
                icon: Icons.archive,
                onTap: () {
                  updateList(allItems[index]);
                  print("Add to upper list $index");
                },
              )
            ],
          );
        },
        shrinkWrap: true);
  }

  Widget getArchiveView() {
    if (archivedItems == null || archivedItems.length == 0) {
      return Container(
        color: Colors.red,
        height: 20.0,
        alignment: Alignment.center,
        child: Text("Please add Something Here"),
      );
    } else {
      var listView = ListView.builder(
          itemCount: archivedItems.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.lightGreenAccent,
                  child: Text(archivedItems[index]),
                  foregroundColor: Colors.white,
                ),
                title: Text('List Title: ' + archivedItems[index]),
                subtitle: Text('Swipe Left to Remove'),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Remove',
                  color: Colors.redAccent,
                  icon: Icons.remove_circle,
                  onTap: () {
                    updateArchive(archivedItems[index]);
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

  getListElements() {
    var items = List<String>.generate(15, (counter) => "$counter");
    return items;
  }

  void updateList(String index) {
    int x = int.parse(index);
    if (archivedItems == null) {
      archivedItems = [index];
    } else {
      archivedItems.add(index);
    }

    allItems.remove(index);
    allItems = sortList(allItems);
    archivedItems = sortList(archivedItems);
    setState(() {});
  }

  void updateArchive(String index) {
    archivedItems.remove(index);
    allItems.add(index);
    allItems = sortList(allItems);
    archivedItems = sortList(archivedItems);
    setState(() {});
  }

  List<String> sortList(List<String> listItem) {
    List<int> newlist = listItem.map(int.parse).toList();
    newlist.sort();
    List<String> orderedList = [];

    for (int j = 0; j < newlist.length; j++) {
      String x = newlist[j].toString();

      orderedList.add(x);
    }
    return orderedList;
  }
}
