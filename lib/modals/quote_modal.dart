class Quote {
  int id;
  String text;
  String author;
  String category;
  String image;
  bool isLiked;

  Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
    this.image =
        "https://cdn.pixabay.com/photo/2018/02/08/02/06/background-3138516_640.jpg",
    this.isLiked = false,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["id"],
        text: json["text"],
        author: json["author"],
        category: json["category"],
        image: json["image"] ??
            "https://cdn.pixabay.com/photo/2018/02/08/02/06/background-3138516_640.jpg",
        isLiked: json["isLiked"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "author": author,
        "category": category,
        "image": image,
        "isLiked": isLiked,
      };
}
