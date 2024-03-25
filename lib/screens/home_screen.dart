import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/cubit.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/states.dart';
import 'package:flutter_application_3/screens/components.dart';
import 'package:flutter_application_3/screens/search_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit().get(context);
    cubit.getHome();
    return BlocConsumer<AuthCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              title: Text('Home Page'),
              centerTitle: true,
              //backgroundColor: Colors.white,
              foregroundColor: Colors.white,
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
                condition: cubit.homeModel != null,
                builder: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      CarouselSlider(
                          items: cubit.homeModel!.data!.banners
                              .map((element) => Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.network(
                                      element.image!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        return loadingProgress != null
                                            ? Lottie.asset(
                                                'images/lf30_editor_ma8dnkep.json',
                                                height: 130,
                                                width: double.infinity,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                  'images/fallback/image_fallback.jpg',
                                                  height: 130,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : child;
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        'images/fallback/image_fallback.jpg',
                                        height: 130,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                          )),
                      SizedBox(height: 30),
                      Text(
                        'Latest Products',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 10),
                      GridView.count(
                          childAspectRatio: .65,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          children: List.generate(
                              cubit.homeModel!.data!.products.length,
                              (index) => productCard(
                                  context, cubit.homeModel, index))),
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        },
      ),
    );
  }
}
