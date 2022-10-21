class PostModel {
  int? id;
  int? userId;
  String? title;
  String? body;

  PostModel.fromJson(Map<String, dynamic> data)
      : userId = data['userId'],
        id = data['id'],
        title = data['title'],
        body = data['body'];
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapData =
        Map.from({'id': id, 'userId': userId, 'title': title, 'body': body});
    return mapData;
  }
}
