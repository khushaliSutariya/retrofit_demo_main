import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homescreen_cubit.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Retrofit")),
      body: BlocProvider(
        create: (context) => HomeScreenCubit(context),
        child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
            if(state.userList.isNotEmpty){
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.userList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        state.userList[index].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(state.userList[index].completed.toString()),
                    ),
                  );
                },
              );
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}
