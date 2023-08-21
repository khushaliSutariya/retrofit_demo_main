// ignore_for_file: must_be_immutable

part of 'homescreen_cubit.dart';



class HomeScreenState extends Equatable {
   List<User> userList;
    HomeScreenState({required this.userList});
  @override
  // TODO: implement props
  List<Object?> get props => [];

   HomeScreenState copyWith({
    List<User>? userList,
  }) {
    return HomeScreenState(
      userList: userList ?? this.userList,
    );
  }
}
