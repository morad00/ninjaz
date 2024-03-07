import 'package:realm/realm.dart';

part 'realm_post.g.dart';

@RealmModel()
class _PostItem {
  @PrimaryKey()
  late String id;
  late String text;
  late String imageUrl;
  late DateTime publishDate;
  late int likesCount;
  late List<String> tags;
  late String ownerId;
  late String ownerTitle;
  late String ownerFirstName;
  late String ownerLastName;
  late String ownerPicture;
}
