import 'package:dio/dio.dart';

class API {
  final dio = Dio();
  final String baseUrl = "https://wordix-backend.onrender.com";

  getUsersService() async {
    try {
      String url = "https://reqres.in/api/users";

      final response = await dio.get(url);

      return response.data;
    } catch (e) {
      return e;
    }
  }

  loginUserService({required String username, required String password}) async {
    try {
      String url = "$baseUrl/auth/login";

      final data = {
        "email": username,
        "password": password,
      };

      final response = await dio.post(url, data: data);

      return response.data;
    } catch (e) {
      return e;
    }
  }

  registerUserService({
    required String username,
    required String password,
  }) async {
    try {
      String url = "$baseUrl/auth/register";

      final data = {
        "email": username,
        "password": password,
        "passwordConfirm": password,
      };

      final response = await dio.post(url, data: data);

      return response.data;
    } catch (e) {
      return e;
    }
  }
}
