class Blog {
  String? id;
  String? title;
  String? content;
  String? thumbnail;
  String? author;

  Blog(
      {required this.id,
      required this.title,
      required this.content,
      required this.thumbnail,
      required this.author});

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    thumbnail = json['thumbnail'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['thumbnail'] = this.thumbnail;
    data['author'] = this.author;
    return data;
  }
}
