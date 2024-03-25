import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/cubit.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/states.dart';
import 'package:flutter_application_3/screens/profile_edit_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit().get(context);
    cubit.getProfile();

    itemBuilder(model) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                model['icon'],
                color: Colors.blueGrey,
              ),
            ),
            Text(model['text'],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                )),
          ],
        ),
      );
    }

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            title: Text('Profile'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileEditScreen()));
                  },
                  icon: Icon(Icons.edit))
            ],
          ),
          body: BuildCondition(
              fallback: (context) => Center(child: CircularProgressIndicator()),
              condition: cubit.userModel?.data != null,
              builder: (context) {
                var userData = cubit.userModel?.data;

                List userInfo = [
                  {
                    'text': userData?.email,
                    'icon': Icons.email,
                  },
                  {
                    'text': userData?.phone,
                    'icon': Icons.phone,
                  },
                  {
                    'text': 'Points: ' + userData!.points!.toString(),
                    'icon': Icons.insert_chart_outlined_rounded,
                  },
                  {
                    'text': 'Credit: ' + userData.credit!.toString(),
                    'icon': Icons.credit_card,
                  },
                ];
                return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                              radius: 80,
                                              backgroundImage:
                                                  NetworkImage(userData.image!),
                                              onBackgroundImageError: (exception,
                                                      stackTrace) =>
                                                  Image.asset(
                                                      'images/fallback/user_default.jpg')),
                                          SizedBox(height: 10),
                                          Text(
                                            userData.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          ),
                                          SizedBox(height: 20),
                                          ListView.separated(
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) =>
                                                  itemBuilder(userInfo[index]),
                                              separatorBuilder:
                                                  (context, index) => Container(
                                                        height: 1,
                                                        color: Colors.grey,
                                                      ),
                                              itemCount: userInfo.length),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ])),
                              )
                            ])));
              }),
        );
      },
    );
  }
}
