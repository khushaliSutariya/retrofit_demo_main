import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofit_demo_main/screens/product/product_cubit.dart';

class ProductScreens extends StatelessWidget {
  const ProductScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product retrofit api")),
      body: BlocProvider(
        create: (context) => ProductCubit(),
        child: BlocBuilder<ProductCubit, ProductState>(
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
