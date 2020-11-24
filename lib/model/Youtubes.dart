
class Youtubes {
  List<Youtube> youtubes;
  bool error;
  String errorMsg;

  Youtubes({
    this.youtubes,
    this.error,
    this.errorMsg,

  });

  factory Youtubes.fromJson(Map<String, dynamic> json) => new Youtubes(
    youtubes: new List<Youtube>.from(json["youtubes"].map((x) => Youtube.fromJson(x))),
    error: json["error"],
    errorMsg: json["error_msg"],
  );
}

class Youtube {
  String id;
  String title;
  String subtitle;
  String avatarImage;
  String youtubeImage;

  Youtube({
    this.id,
    this.title,
    this.subtitle,
    this.avatarImage,
    this.youtubeImage,
  });

  factory Youtube.fromJson(Map<String, dynamic> json) => Youtube(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    avatarImage: json["avatar_image"],
    youtubeImage: json["youtube_image"],
  );
}
