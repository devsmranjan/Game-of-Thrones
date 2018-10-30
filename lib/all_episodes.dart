import 'package:flutter/material.dart';
import 'grid_view.dart';
import 'snaplist_view.dart';

class AllEpisodes extends StatefulWidget {
  final List episodes;
  final VoidCallback refresh;
  const AllEpisodes({Key key, this.episodes, this.refresh}) : super(key: key);


  @override
  _AllEpisodesState createState() => _AllEpisodesState();
}

class _AllEpisodesState extends State<AllEpisodes> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Episodes"),
        centerTitle: true,
      ),
      body: SnapListViewPage(episodes: widget.episodes,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.refresh();
        },
        child: Icon(Icons.refresh),
        tooltip: "Refresh",
      ),
    );
  }
}
