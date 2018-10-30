import 'package:flutter/material.dart';
import 'package:snaplist/snaplist.dart';
import 'episode_activity.dart';

class SnapListViewPage extends StatefulWidget {
  final List episodes;

  const SnapListViewPage({Key key, this.episodes}) : super(key: key);

  @override
  _SnapListViewPageState createState() => _SnapListViewPageState();
}

class _SnapListViewPageState extends State<SnapListViewPage> {
  final Size _cardSize = Size(300.0, 400.0);

  @override
  Widget build(BuildContext context) {
    return SnapList(
        padding: EdgeInsets.only(
            left: (MediaQuery.of(context).size.width - _cardSize.width) / 2),
        sizeProvider: (index, data) => _cardSize,
        builder: (context, index, data) {
          return Material(
            child: InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Container(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Hero(
                        tag: widget.episodes[index].name,
                        child: Image.network(
                          widget.episodes[index].image.original,
                          fit: BoxFit.cover,
//                        ),
                        ),
                      ),
                      new Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(top: 12.0),
                          width: 80.0,
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  bottomLeft: Radius.circular(4.0)),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 20.0,
                                ),
                              ]),
                          child: new Text(
                            "E${widget.episodes[index].number}-S${widget.episodes[index].season}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 60.0,
                          color: Colors.white12,
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              widget.episodes[index].name,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => EpisodeActivity(
                      name: widget.episodes[index].name,
                      imageUrl: widget.episodes[index].image.original,
                      summary: widget.episodes[index].summary,
                      number: widget.episodes[index].number,
                      season: widget.episodes[index].season,
                    ), fullscreenDialog: true
                ));
              },
            ),
          );
        },
        separatorProvider: (index, data) => Size(10.0, 10.0),
        count: widget.episodes.length);
  }
}
