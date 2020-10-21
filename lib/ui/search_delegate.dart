
import 'package:flutter/material.dart';
import 'package:wikipedia_app/models/page.dart';
import 'package:wikipedia_app/ui/theme.dart';

class UniappSearch extends SearchDelegate<String> {

  UniappSearch();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    // if (dataList
    //     .where((q) =>
    //     q.projectFieldsString.toLowerCase().contains(query.toLowerCase()))
    //     .isEmpty) {
    //   return NoDataToDisplayWidget();
    // }
    //
    // final resultsList = dataList
    //     .where((q) =>
    //     q.projectFieldsString.toLowerCase().contains(query.toLowerCase()))
    //     .toList();

    List<WikiPage> resultList;
    // TODO: get resultList from server

    if (query != null && query.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 1000), () {
        close(context, null);
        // ScreenNavigateUtils().navigateToProjectListScreen(
        //     context,
        //     appId,
        //     null,
        //     null,
        //     null,
        //     resultsList,
        //     false,
        //     false
        // );
      });

      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Loading...',
              style: AppTheme.defaultErrorTextStyle,
            ),
          ],
        ),
      );
    } else {
      return UniappSearchTile(
        searchList: resultList,
        searchDelegate: this,
        query: query,
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // if (dataList
    //     .where((q) =>
    //     q.projectFieldsString.toLowerCase().contains(query.toLowerCase()))
    //     .isEmpty) {
    //   return NoDataToDisplayWidget();
    // }
    //
    // final searchList = dataList
    //     .where((q) =>
    //     q.projectFieldsString.toLowerCase().contains(query.toLowerCase()))
    //     .toList();


    //TODO: find results suggestion
    List<WikiPage> searchList;

    return UniappSearchTile(
      searchList: searchList,
      searchDelegate: this,
      query: query,
    );
  }
}

class UniappSearchTile extends StatelessWidget {
  List<WikiPage> searchList;
  final SearchDelegate searchDelegate;
  final String query;

  UniappSearchTile({
    this.searchDelegate,
    this.searchList,
    this.query,
  });

  @override
  Widget build(BuildContext context) {
    // app variable created for checking if map is enabled for it or not
    return ListView.builder(
      itemCount: searchList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.white,
          child: ListTile(
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.view_list,
                    color: Colors.grey,
                  ),
                  onPressed: () => searchDelegate.close(
                      context, searchList.elementAt(index)),
                ),
              ],
            ),

            title: Text(
              "${searchList[index].title}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(searchList[index].terms.description[0]),
            selected: true,
            onTap: () {
              searchDelegate.close(
                  context, searchList.elementAt(index));
            },
          ),
        );
      },
    );
  }
}

class UniappSearchHelper {

  void searchOnPressed(BuildContext context) {

    showSearch(
      context: context,
      delegate: UniappSearch(),
    ).then((onValue) {
      if (onValue != null && onValue.isNotEmpty) {

      }
    });
  }
}
