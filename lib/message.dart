class Message {
  Message({
    this.id = 0,
    this.content = '',
    this.images,
    this.sender = 0,
    this.isSeen = true,
  });

  int id;
  String content;
  int sender;
  bool isSeen;
  List<ImageUrl>? images;

  Message copyWith({
    int? id,
    String? content,
    bool? isSeen,
  }) =>
      Message(
          id: id ?? this.id,
          content: content ?? this.content,
          images: images,
          sender: sender,
          isSeen: isSeen?? this.isSeen);

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        content: json["content"],
        images: json["images"] == null
            ? []
            : List<ImageUrl>.from(
                json["images"]!.map((x) => ImageUrl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class ImageUrl {
  ImageUrl({
    this.thumbnail,
    this.productUrl,
    this.productName,
  });

  String? thumbnail;
  String? productUrl;
  String? productName;

  factory ImageUrl.fromJson(Map<String, dynamic> json) => ImageUrl(
        thumbnail: json["thumbnail"],
        productUrl: json["product_url"],
        productName: json["product_name"],
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail,
        "product_url": productUrl,
        "product_name": productName,
      };
}
