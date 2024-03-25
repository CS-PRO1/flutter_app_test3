import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/cubit.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/states.dart';
import 'package:flutter_application_3/screens/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit().get(context);
    cubit.getFavorites();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: BuildCondition(
          condition: cubit.favoritesModel?.data != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: cubit.favoritesModel!.data!.products.length > 0
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: GridView.count(
                        childAspectRatio: .65,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        children: List.generate(
                            cubit.favoritesModel!.data!.products.length,
                            (index) => productCard(
                                context, cubit.favoritesModel, index))))
                : Center(
                    child: Text(
                    'Your Favorites list is currently empty',
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  )),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
