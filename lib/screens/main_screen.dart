import 'package:flutter/material.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/cubit.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/states.dart';
import 'package:flutter_application_3/screens/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit().get(context);
    return BlocConsumer<AuthCubit, AppStates>(
      listener: (context, state) {
        if (state is AppLogoutLoadingState) {
          showDialog(
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    contentPadding: EdgeInsets.all(4.0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircularProgressIndicator(),
                        Text('Logging Out...'),
                      ],
                    ),
                  ),
              context: context);
        }
        if (state is AppLogoutSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false);
        }
      },
      builder: (context, state) {
        return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) => Scaffold(
                  body: cubit.screens[cubit.index],
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: cubit.index,
                    onTap: (value) {
                      cubit.changeNavBar(value);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_rounded),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.grid_view_rounded),
                          label: 'Categories'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.favorite_rounded),
                          label: 'Favorites'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person_rounded), label: 'Profile')
                    ],
                    showUnselectedLabels: true,
                    unselectedItemColor: Colors.grey,
                    selectedItemColor: Theme.of(context).primaryColor,
                    type: BottomNavigationBarType.fixed,
                    iconSize: 22,
                    landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.logout),
                    onPressed: () {
                      AuthCubit().get(context).logOut();
                    },
                  ),
                ));
      },
    );
  }
}
