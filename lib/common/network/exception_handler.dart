import 'package:dio/dio.dart';

class ExceptionHandler {
  static ExceptionHandler? _singleton;

  factory ExceptionHandler() {
    _singleton = _singleton ?? ExceptionHandler._internal();
    return _singleton!;
  }

  ExceptionHandler._internal();

  handleDioError({required DioException error}) {
    switch (error.type) {
      case DioExceptionType.cancel:
        // _showErrorSnackBar(
        //   messageEn: "error_cancel_request",
        //   messageAr: "error_cancel_request",
        // );
        break;
      case DioExceptionType.connectionTimeout:
        // _showErrorSnackBar(
        //   messageEn: "error_connect_timeOut",
        //   messageAr: "error_connect_timeOut",
        // );
        break;
      case DioExceptionType.receiveTimeout:
        // _showErrorSnackBar(
        //   messageEn: "error_response_timeOut",
        //   messageAr: "error_response_timeOut",
        // );
        break;
      case DioExceptionType.sendTimeout:
        // _showErrorSnackBar(
        //   messageEn: 'error_request_timeOut',
        //   messageAr: 'error_request_timeOut',
        // );
        break;
      case DioExceptionType.badResponse:
        // _handleStatusCode(
        //   dioErrorEnum: dioErrorEnum,
        //   error: error,
        //   specificHandle: specificHandle,
        //   enableAuthHandling: enableAuthHandling,
        //   disableDefaultSnackBarError: disableDefaultSnackBarError,
        // );
        break;
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') ?? false) {
          // _showErrorSnackBar(
          //   messageEn: "error_socket",
          //   messageAr: "error_socket",
          // );
        } else {
          // _showErrorSnackBar(
          //   messageEn: "unknown_error",
          //   messageAr: "unknown_error",
          // );
        }
        break;
      default:
        // _showErrorSnackBar(
        //   messageEn: "unknown_error",
        //   messageAr: "unknown_error",
        // );
        break;
    }
  }
}
