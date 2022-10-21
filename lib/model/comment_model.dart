class CommentModel {
  int? id;
  int? postId;
  String? email;
  String? name;
  String? body;

  CommentModel.fromJson(Map<String, dynamic> data)
      : postId = data['postId'],
        id = data['id'],
        email = data['email'],
        name = data['name'],
        body = data['body'];
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapData = Map.from({
      'id': id,
      'postId': postId,
      'name': name,
      'body': body,
      'email': email
    });
    return mapData;
  }
}
