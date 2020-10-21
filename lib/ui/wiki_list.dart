import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:wikipedia_app/models/page.dart';
import 'package:wikipedia_app/wiki_info_bloc.dart';
import 'theme.dart';
import 'package:url_launcher/url_launcher.dart';


class WikiListViewWidget extends StatefulWidget {

  WikiListViewWidget();

  @override
  _WikiListViewWidgetState createState() => _WikiListViewWidgetState();
}

class _WikiListViewWidgetState extends State<WikiListViewWidget> {

  WikiInfoBloc wikiInfoBloc = WikiInfoBloc();
  _WikiListViewWidgetState(){
    wikiInfoBloc.fetchWikiInfo("Sachin");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      wikiInfoBloc.fetchWikiInfo(controller.text);
    });
  }
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _renderProejctListFromStream();
  }

  _renderProejctListFromStream() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Wiki Search"),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: controller,
                  ),
                ),
              ),
              Expanded(
                  flex: 12,
                  child:
                  StreamBuilder(
                      stream: wikiInfoBloc.wikiInfoStream,
                      builder: (
                          context,
                          AsyncSnapshot<List<WikiPage>> snapshot,
                          ) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: AppTheme.defaultErrorTextStyle,
                            ),
                          );
                        }

                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child: Text(
                                'Loading...',
                                style: AppTheme.defaultErrorTextStyle,
                              ),
                            );
                          default:
                            if (snapshot == null || snapshot?.data == null || snapshot?.data.isEmpty) {
                              return Center(
                                child: Text(
                                  'No Pages Found.',
                                  style: AppTheme.defaultErrorTextStyle,
                                ),
                              );
                            }
                            return getListViewForPages(snapshot.data);
                        }
                      })
              )
            ],
          ),
        )
    );
  }

  getListViewForPages(List<WikiPage> pages) {
    double radius = 40.0;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: pages?.length ?? 0,
        itemBuilder: (context, index) {
          final item = pages[index];
          if (item != null) {
            return Card(
                elevation: 4.0,
                child: ListTile(
                  leading: Container(
                    width: radius,
                    height: radius,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: item.thumbnail == null || item.thumbnail.source == null
                            ?  AssetImage("assets/default_logo.png") : NetworkImage(item.thumbnail.source),
                      ),
                    ),
                  ),
                  // trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text(item.title,
                    // StringUtils.getTranslatedString(item),
                    style: AppTheme.largeHeader,
                  ),
                  subtitle: Text(item.terms?.description[0], style: AppTheme.smallHeader,),
                  onTap: () async {
                    String url = "https://en.wikipedia.org/?curid=" + pages[index].pageId.toString();
                    if (await canLaunch(url))
                      await launch(url);
                    else
                      // can't launch url, there is some error
                      throw "Could not launch $url";
                  },
                )
            );
          } else {
            return Container(
              width: 0.0,
              height: 0.0,
            );
          }
        },
      ),
    );
  }
}
