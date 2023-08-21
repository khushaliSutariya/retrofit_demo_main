import 'dart:async';
import '../handler/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/users.dart';

part 'homescreen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  BuildContext context;
  HomeScreenCubit(this.context) : super(HomeScreenState(userList: const [])) {
    getUserData();
  }

  // Future<List<User>?> getUser(context) async {
  //   checkConnectivity(context);
  //   try {
  //     await client.getUsers().then((it) {
  //       state.userList = it;
  //     });
  //     emit(state.copyWith(userList: state.userList));
  //     return state.userList;
  //   } on DioException catch (error) {
  //     onError(error);
  //   }
  //   return null;
  // }

Future<List<User>> getUserData() async{
    return await getUser( context,() => client.getUsers().then((value){
      state.userList = value;
      emit(state.copyWith(userList: state.userList));
      return state.userList;
    }),);
}
}
