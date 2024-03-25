import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/cubit.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/states.dart';
import 'package:flutter_application_3/screens/product_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit().get(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: Text('Search'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  TextFormField(
                    onFieldSubmitted: (value) {
                      cubit.searchData(value);
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_rounded),
                        hintText: 'Search...',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 4))),
                  ),
                  BuildCondition(
                    condition: state is SearchSuccessState,
                    builder: (context) => Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                buildSearch(index, cubit.searchModel, context),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 5),
                            itemCount:
                                cubit.searchModel!.data!.products.length)),
                    fallback: (context) {
                      if (state is SearchLoadingState)
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 6.0),
                          child: LinearProgressIndicator(),
                        );
                      return SizedBox();
                    },
                  )
                ],
              ),
            )));
  }

  buildSearch(index, model, context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductScreen(model.data.products[index]),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Image.network(
              model.data?.products[index].image,
              height: 150,
              width: 175,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'images/fallback/image_fallback.jpg',
                height: 130,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(model.data?.products[index].name,
                  style: Theme.of(context).textTheme.subtitle1
                  //style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
