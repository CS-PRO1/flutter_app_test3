import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/cubit.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/states.dart';
import 'package:flutter_application_3/screens/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailsScreen extends StatelessWidget {
  CategoryDetailsScreen(this.model, {super.key});
  var model;

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit().get(context);
    cubit.getCategoryDetails(model);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: true,
              title: Text(model.name),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BuildCondition(
                condition: cubit.catDetailsModel?.data != null,
                builder: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: GridView.count(
                      childAspectRatio: .65,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      children: List.generate(
                          cubit.catDetailsModel!.data!.products.length,
                          (index) => productCard(
                              context, cubit.catDetailsModel, index))),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ));
      },
    );
  }
}
