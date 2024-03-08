import 'package:ninjaz/common/data/realm/realm_post.dart';
import 'package:realm/realm.dart';

class RealmDatabase {
  static RealmDatabase? _instance;

  RealmDatabase._internal();

  factory RealmDatabase() {
    return _instance ??= RealmDatabase._internal();
  }

  Future<Realm> openDatabase() async {
    var config = Configuration.local([PostItem.schema]);
    return await Realm.open(config);
  }

  Future<void> savePosts(List<PostItem> posts) async {
    final realm = await openDatabase();
    realm.write(() {
      realm.addAll(posts, update: true);
    });
    realm.close();
  }

  Future<List<PostItem>> getPosts() async {
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
