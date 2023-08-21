import 'package:connectivity_plus/connectivity_plus.dart';
import "package:dio/dio.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:retrofit/http.dart';
import 'package:retrofit_demo_main/screens/model/employee.dart';
import 'package:retrofit_demo_main/screens/model/product.dart';
import '../model/users.dart';
part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('https://jsonplaceholder.typicode.com/todos/')
  Future<List<User>> getUsers();

  @GET('https://api.escuelajs.co/api/v1/categories')
  Future<List<ProductList>> getProduct();

  @GET('https://api.escuelajs.co/api/v1/users')
  Future<List<EmployeeList>> getEmployee();
}

final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));

Future<List<T>> getUser<T>(context, Future<List<T>> Function() apiCall) async {
  checkConnectivity(context);
  try {
    final value = await apiCall();
    return value;
  } on DioException catch (error) {
    onError(error);
  }
  return [];
}

void checkConnectivity(context) async {
  final Connectivity connectivity = Connectivity();
  var connectionResult = await connectivity.checkConnectivity();
  if (connectionResult == ConnectivityResult.none) {
    showDialogBox(context);
  }
}

showDialogBox(BuildContext context) => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"))
          ],
        ));

void onError(error) {
  print("e.error ${error.error}");
  if (error.error == io.SocketException || error.error == io.HttpException) {
    print("e.error network connection");
  }
}
