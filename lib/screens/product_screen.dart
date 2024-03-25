import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/cubit.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ProductScreen extends StatelessWidget {
  var model;
  ProductScreen(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit().get(context);
    cubit.getProduct(model);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.black,
          ),
          body: Padding(
            padding: const EdgeInsets.all(6.0),
            child: BuildCondition(
              condition: cubit.productModel?.data != null,
              builder: (context) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CarouselSlider(
                        items: cubit.productModel?.data?.images
                            ?.map((e) => Container(
                                  width: double.infinity,
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(
                                    e,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      return loadingProgress != null
                                          ? Lottie.asset(
                                              'images/lf30_editor_ma8dnkep.json',
                                              height: 250,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                'images/fallback/image_fallback.jpg',
                                                height: 250,
                                              ),
                                            )
                                          : child;
                                    },
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.asset(
                                            'images/fallback/image_fallback.jpg',
                                            height: 250),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            height: 250, enlargeCenterPage: true)),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        cubit.productModel!.data!.name!,
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      cubit.productModel!.data!.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      child: TextButton(
                        onPressed: () {
                          cubit.changeFavorite(cubit.productModel!.data!.id!);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                            Text(
                              'Add to Favorites',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.pink[800]),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(color: Colors.white))),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.shopping_cart_rounded,
                              color: Colors.white,
                            ),
                            Text(
                              'Add to Cart',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green[700]),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(color: Colors.white))),
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
