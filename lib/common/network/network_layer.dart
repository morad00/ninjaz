import 'package:dio/dio.dart';
import 'package:ninjaz/common/constants/api_codes.dart';
import 'package:ninjaz/common/enums/dio_type_enum.dart';
import 'package:ninjaz/common/network/exception_handler.dart';

class NetworkLayer {
  static NetworkLayer? _singleton;

  factory NetworkLayer() {
    _singleton = _singleton ?? NetworkLayer._internal();
    return _singleton!;
  }

  NetworkLayer._internal();

  Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiCodes.baseUrl,
      contentType: "application/json",
      headers: {"app-id": "65e8ec6902fcdb8d78dda50a"},
    ),
  );

  apiCall({
    required DioApiTypeEnum dioApiTypeEnum,
    required String apiPath,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      late final Response response;
      switch (dioApiTypeEnum) {
        case DioApiTypeEnum.get:
          {
            response = await dio.get(
              apiPath,
              queryParameters: queryParameters,
            );
            break;
          }
        case DioApiTypeEnum.post:
          {
            response = await dio.post(
              apiPath,
              data: data,
              queryParameters: queryParameters,
            );
            break;
          }
        case DioApiTypeEnum.put:
          {
            response = await dio.put(
              apiPath,
              data: data,
              queryParameters: queryParameters,
            );
            break;
          }
        case DioApiTypeEnum.patch:
          {
            response = await dio.patch(
              apiPath,
              data: data,
              queryParameters: queryParameters,
            );

            break;
          }
        case DioApiTypeEnum.delete:
          response = await dio.delete(
            apiPath,
            data: data,
            queryParameters: queryParameters,
          );
          break;
      }
      return response;
    } on DioException catch (error) {
      ExceptionHandler().handleDioError(error: error);
      rethrow;
    }
  }
}
