import 'dart:convert';
import 'package:flutter/material.dart';
import 'all_episodes.dart';
import 'got_data.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

//GOT gotData;

Future<GOT> fetchEpisodes() async {
  final response = await http.get(
      "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes");

  if (response.statusCode == 200) {
    return GOT.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

void refresh() {
  fetchEpisodes();
  print("Refreshed");
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Game of Thrones",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    fetchEpisodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new FutureBuilder<GOT>(
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }

            return snapshot.hasData
                ? _buildBody(snapshot.data)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
          future: fetchEpisodes(),
        ));
  }

  Widget _buildBody(GOT gotSnapshot) {
    return new CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          expandedHeight: 256.0,
          pinned: true,
          actions: <Widget>[
            PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case "all-episodes":
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllEpisodes(episodes: gotSnapshot.embedded.episodes, refresh: refresh,)));
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuItem>[
                      const PopupMenuItem(
                        child: const Text("All Episodes"),
                        value: "all-episodes",
                      )
                    ])
          ],
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(gotSnapshot.name),
              background: Image.network(
                gotSnapshot.image.original,
                fit: BoxFit.cover,
              )),
        ),
        new SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.play_circle_filled),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "${gotSnapshot.runtime} Minutes",
                      style: Theme.of(context).textTheme.headline,
                    )
                  ],
                ),
                Flexible(
                    child: Center(
                  child: Text(
                    gotSnapshot.summary,
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
