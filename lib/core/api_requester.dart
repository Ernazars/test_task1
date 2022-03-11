import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test_task1/injection/init_get.dart';

@LazySingleton()
class ApiRequester {
  late Dio dio;
  ApiRequester() {
    init();
  }

  init() {
    dio = Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      bool hasConnection =
          await getIt<InternetConnectionChecker>().hasConnection;
      if (!hasConnection) {
        handler.reject(
          DioError(
            requestOptions: options,
            error: "Проверьте интернет соединение!",
          ),
        );
      }
      handler.next(options);
    }, onResponse: (response, handler) {
      if (response.statusCode == 200) {
        if (response.data["status"] == "OK") {
          response.data = response.data["results"];
        }
      }
      handler.next(response);
    }, onError: (error, handler) {
      handler.reject(
        DioError(
          requestOptions: error.requestOptions,
          error: "Ошибка при получении данных!",
        ),
      );
    }));
  }
}
