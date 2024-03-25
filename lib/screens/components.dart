import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/product_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';

import '../Services/Bloc Service/cubit.dart';

toast(String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

productCard(context, model, index) {
  // bool in_favorites = model.data.products[index].in_favorites ?? true;
  var cubit = AppCubit().get(context);
  // var icon =
  //     in_favorites ? Icons.favorite_rounded : Icons.favorite_border_rounded;

  return Card(
    clipBehavior: Clip.antiAlias,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductScreen(model.data.products[index]),
        ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            child:
                Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image.network(
                model.data!.products[index].image!,
                height: 130,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress != null
                      ? Lottie.asset(
                          'images/lf30_editor_ma8dnkep.json',
                          height: 130,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'images/fallback/image_fallback.jpg',
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : child;
                },
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'images/fallback/image_fallback.jpg',
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              model.data.products[index].discount != 0
                  ? Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          model.data.products[index].discount.toString() +
                              '\% OFF!',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 10),
                        ),
                      ),
                    )
                  : SizedBox()
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.data!.products[index].name!,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              //style: TextStyle(fontSize: 10),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (model.data!.products[index].discount != 0)
                    Text(
                      model.data!.products[index].old_price.toString() + '\$',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.redAccent),
                    ),
                  Text(
                    model.data!.products[index].price.toString() + '\$',
                    style: TextStyle(color: Colors.green),
                  ),
                  LikeButton(
                    isLiked: model.data.products[index].in_favorites,
                    onTap: (isLiked) async {
                      await cubit.changeFavorite(model.data.products[index].id);
                      model.data.products[index].in_favorites = !isLiked;
                      return !isLiked;
                    },
                  ),
                ],
              ))
        ],
      ),
    ),
  );
}
