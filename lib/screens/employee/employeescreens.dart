import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofit_demo_main/screens/employee/employee_cubit.dart';

class EmployeeScreens extends StatelessWidget {
  const EmployeeScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Employee retrofit api")),
      body: BlocProvider(
        create: (context) => EmployeeCubit(),
        child: BlocBuilder<EmployeeCubit, EmployeeState>(
          builder: (context, state) {
            return const Column(
              children: [
              ],
            );
          },
        ),
      ),
    );
  }
}
