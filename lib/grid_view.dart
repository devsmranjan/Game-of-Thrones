import 'package:flutter/material.dart';

class GridViewPage extends StatefulWidget {
  final List episodes;

  const GridViewPage({Key key, this.episodes}) : super(key: key);
  
  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Grid View"),
    );
  }
}
