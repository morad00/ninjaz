import 'package:ninjaz/common/data/realm/realm_post.dart';
import 'package:realm/realm.dart';

class RealmDatabase {
  static RealmDatabase? _singleton;

  RealmDatabase._internal();

  factory RealmDatabase() {
    _singleton = _singleton ?? RealmDatabase._internal();
    return _singleton!;
  }

  static Future<Realm> openDatabase() async {
    var config = Configuration.local([PostItem.schema]);
    return await Realm.open(config);
  }

  static Future<void> savePosts(List<PostItem> posts) async {
    final realm = await openDatabase();
    realm.write(() {
      realm.addAll(posts,update: true);
    });
    realm.close();
  }

  static Future<List<PostItem>> getPosts() async {
    try {
      final realm = await openDatabase();
      final results = realm.all<PostItem>();
      final posts = results.map((post) => post).toList();
      return posts;
    } catch (error) {
      print('Error retrieving posts: $error');
      // Handle error appropriately
      return []; // Return empty list or handle error case
    }
  }
}
