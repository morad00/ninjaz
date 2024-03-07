import 'package:ninjaz/common/constants/api_codes.dart';
import 'package:ninjaz/common/enums/dio_type_enum.dart';
import 'package:ninjaz/common/network/network_layer.dart';
import 'package:ninjaz/features/dashboard/domain/i_posts_api.dart';

class PostsApi extends IPostsApi {
  @override
  Future<dynamic> getPostsList({required int pageIndex}) async {
    try {
      final response = await NetworkLayer().apiCall(
        dioApiTypeEnum: DioApiTypeEnum.get,
        data: null,
        apiPath: ApiCodes.postsListUrl,
        queryParameters: {
          'page': pageIndex,
          'limit': 10,
        },
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
