class GOT {
  String name;
  int runtime;
  PosterImage image;
  String summary;
  Embedded embedded;

  GOT({this.name, this.runtime, this.image, this.summary, this.embedded});

  GOT.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    runtime = json['runtime'];
    image = json['image'] != null ? new PosterImage.fromJson(json['image']) : null;
    summary = json['summary'];
    embedded = json['_embedded'] != null
        ? new Embedded.fromJson(json['_embedded'])
        : null;
  }
}

class PosterImage {
  String medium;
  String original;

  PosterImage({this.medium, this.original});

  PosterImage.fromJson(Map<String, dynamic> json) {
    medium = json['medium'];
    original = json['original'];
  }
}

class Embedded {
  List<Episodes> episodes;

  Embedded({this.episodes});

  Embedded.fromJson(Map<String, dynamic> json) {
    if (json['episodes'] != null) {
      episodes = new List<Episodes>();
      json['episodes'].forEach((v) {
        episodes.add(new Episodes.fromJson(v));
      });
    }
  }
}

class Episodes {
  int id;
  String url;
  String name;
  int season;
  int number;
  String airdate;
  String airtime;
  String airstamp;
  int runtime;
  PosterImage image;
  String summary;

  Episodes({
    this.id,
    this.url,
    this.name,
    this.season,
    this.number,
    this.airdate,
    this.airtime,
    this.airstamp,
    this.runtime,
    this.image,
    this.summary,
  });

  Episodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    season = json['season'];
    number = json['number'];
    airdate = json['airdate'];
    airtime = json['airtime'];
    airstamp = json['airstamp'];
    runtime = json['runtime'];
    image = json['image'] != null ? new PosterImage.fromJson(json['image']) : null;
    summary = json['summary'];
  }
}

