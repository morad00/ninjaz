import 'package:ninjaz/common/constants/api_codes.dart';
import 'package:ninjaz/common/enums/dio_type_enum.dart';
import 'package:ninjaz/common/network/network_layer.dart';

class PostsApi {
  Future<dynamic> getPostsList({required int pageIndex}) async {
    try {
      final response = await NetworkLayer().apiCall(
        dioApiTypeEnum: DioApiTypeEnum.get,
        data: null,
        apiPath: ApiCodes.postsListUrl,
        queryParameters: {
          'page': pageIndex,
          'limit': 1,
        },
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
