import 'dart:convert';

import 'package:equatable/equatable.dart';

PostsListModel postsListModelFromJson(String str) => PostsListModel.fromJson(json.decode(str));

String postsListModelToJson(PostsListModel data) => json.encode(data.toJson());

class PostsListModel extends Equatable {
  @override
  List<Object> get props => [data, total, page, limit];

  final List<PostsListData> data;
  final int total;
  final int page;
  final int limit;

  const PostsListModel({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
  });

  factory PostsListModel.fromJson(Map<String, dynamic> json) => PostsListModel(
        data: json["data"] == null ? [] : List<PostsListData>.from(json["data"].map((x) => PostsListData.fromJson(x))),
        total: json["total"] ?? 0,
        page: json["page"] ?? 0,
        limit: json["limit"] ?? 20,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "limit": limit,
      };
}

class PostsListData extends Equatable {
  @override
  List<Object> get props => [
        id,
        image,
        likes,
        tags,
        text,
        publishDate,
        owner,
      ];

  final String id;
  final String image;
  final int likes;
  final List<String> tags;
  final String text;
  final DateTime publishDate;
  final Owner owner;

  const PostsListData({
    required this.id,
    required this.image,
    required this.likes,
    required this.tags,
    required this.text,
    required this.publishDate,
    required this.owner,
  });

  factory PostsListData.fromJson(Map<String, dynamic> json) => PostsListData(
        id: json["id"] ?? "",
        image: json["image"] ?? "",
        likes: json["likes"] ?? 0,
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"].map((x) => x)),
        text: json["text"],
        publishDate: json["publishDate"] == null ? DateTime.now() : DateTime.parse(json["publishDate"]),
        owner: Owner.fromJson(json["owner"] ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "likes": likes,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "text": text,
        "publishDate": publishDate.toIso8601String(),
        "owner": owner.toJson(),
      };
}

class Owner extends Equatable {
  @override
  List<Object> get props => [id, title, firstName, lastName, picture];

  final String id;
  final String title;
  final String firstName;
  final String lastName;
  final String picture;

  const Owner({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        picture: json["picture"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "firstName": firstName,
        "lastName": lastName,
        "picture": picture,
      };
}
