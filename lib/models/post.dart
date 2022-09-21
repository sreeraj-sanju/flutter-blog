import 'user.dart';

class Post {
  int? id;
  String? body;
  String? image;
  int? likesCount;
  int? commentCount;
  User? user;
  bool? selfLiked;

  Post({this.id, this.body, this.image, this.likesCount, this.commentCount, this.user, this.selfLiked});

  //function for convert json data to post model
  factory Post.fromJson(Map<String, dynamic> json) {

    return Post(
      id: json['id'],
      body: json['body'],
      likesCount: json['likesCount'],
      image: json['image'],
      commentCount: json['commentCount'],
      selfLiked: json['likes'].length > 0,
      user: User(
        id: json['user']['id'],
        name: json['user']['name'],
        image: json['user']['image'],
      )
    );
  }
}
