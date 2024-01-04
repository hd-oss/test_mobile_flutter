import 'dart:developer';
import 'package:get/get.dart';

class HttpProvider extends GetConnect {
  @override
  void onInit() {
    const String apiUrl = 'https://jsonplaceholder.typicode.com/';

    httpClient.baseUrl = apiUrl;
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 30);

    log('${httpClient.baseUrl}', name: 'Logging : END POINT');

    httpClient.addRequestModifier<dynamic>((request) {
      log(request.url.path, name: 'Logging : Add Request Modifier');

      if (request.url.toString() == '$apiUrl/login') return request;

      return request;
    });

    httpClient.addResponseModifier((request, response) async {
      if (request.url.toString() == '$apiUrl/login') return response;
      return response;
    });

    httpClient.addAuthenticator<dynamic>((request) async {
      log(request.url.path, name: 'Logging : Add Authenticator');
      return request;
    });

    // httpClient.maxAuthRetries = 3;
  }

  dynamic handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 400:
      case 401:
      case 403:
      case 404:
      case 413:
      case 500:
      default:
    }
  }
}
