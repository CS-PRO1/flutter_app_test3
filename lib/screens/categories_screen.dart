import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/cubit.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/states.dart';
import 'package:flutter_application_3/screens/cat_details_screen.dart';
import 'package:flutter_application_3/screens/search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit().get(context);
    cubit.getCategory();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text('Categories'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ));
                },
                icon: Icon(Icons.search_rounded))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BuildCondition(
            condition: cubit.catModel != null,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    catItemBuilder(
                        context, index, cubit.catModel!.data?.data[index]),
                itemCount: cubit.catModel!.data!.data.length,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 10)),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }

  catItemBuilder(context, index, model) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryDetailsScreen(model),
          ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              model.image,
              height: 130,
              width: 130,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress != null
                    ? Lottie.asset(
                        'images/lf30_editor_ma8dnkep.json',
                        height: 130,
                        width: 130,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'images/fallback/image_fallback.jpg',
                          height: 130,
                          width: 130,
                        ),
                      )
                    : child;
              },
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'images/fallback/image_fallback.jpg',
                width: 130,
                height: 130,
              ),
            ),
            Flexible(
              child: Text(
                model.name,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
