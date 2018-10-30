import 'package:flutter/material.dart';

class EpisodeActivity extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String summary;
  final int number;
  final int season;

  const EpisodeActivity(
      {Key key,
      this.name,
      this.imageUrl,
      this.summary,
      this.number,
      this.season})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return new CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          expandedHeight: 256.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(name),
              background: Hero(
                tag: name,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              )),
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        new SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Episode $number | Season $season",
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(color: Theme.of(context).accentColor),
                ),
                Flexible(
                    child: Center(
                  child: Text(
                    summary,
                    style: Theme.of(context).textTheme.subhead,
                    textAlign: TextAlign.justify,
                  ),
                ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
