import 'dart:async';
import 'dart:io' as io;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../handler/api_client.dart';
import '../model/users.dart';

class DataScreens extends StatefulWidget {
  const DataScreens({Key? key}) : super(key: key);

  @override
  State<DataScreens> createState() => _DataScreensState();
}

class _DataScreensState extends State<DataScreens> {
  final Connectivity _connectivity = Connectivity();
  List<User> userList = [];

  @override
  void initState() {
    super.initState();
    errorHandle();
  }

  Future<List<User>?> errorHandle() async {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    var connectionResult = await _connectivity.checkConnectivity();
    if (connectionResult == ConnectivityResult.none) {
      showDialogBox();
    }else{
      try {
        await client.getUsers().then((it) {
          userList = it;
        });
        return userList;
      } on DioException catch (error) {
        print("e.error ${error.error}");
        if (error.error == io.SocketException || error.error == io.HttpException) {
          print("e.error netowork connection");
        }
      }
    }
    setState(() {});
    return null;
  }




  showDialogBox() => showCupertinoDialog<String>(
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Flutter - Retrofit Implementation"),
      ),
      body: FutureBuilder<List<User>?>(
        future: errorHandle(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<User>? posts = snapshot.data;
            return ListView.builder(
              itemCount: posts?.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      posts != null ? posts[index].title : "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(posts != null ? posts[index].completed.toString() : ""),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
