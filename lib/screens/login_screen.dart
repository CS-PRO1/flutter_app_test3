// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_3/Services/Bloc%20Service/cubit.dart';
import 'package:flutter_application_3/screens/register_screen.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/states.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AppStates>(
      listener: (context, state) {
        if (state is AppLoginSuccessState) {
          if (AuthCubit().get(context).userModel!.status!) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MainScreen()),
                (route) => false);
          }
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit().get(context);
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Stack(alignment: AlignmentDirectional.center, children: [
                        Icon(
                          CupertinoIcons.square,
                          color: Colors.grey,
                          size: 150,
                        ),
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 100,
                        )
                      ]),
                      // CarouselSlider(
                      //     items: images
                      //         .map((e) => Image.asset(
                      //               e,
                      //               isAntiAlias: true,
                      //             ))
                      //         .toList(),
                      //     options: CarouselOptions(
                      //         autoPlayCurve: Curves.bounceInOut,
                      //         enableInfiniteScroll: false,
                      //         pauseAutoPlayOnTouch: true,
                      //         viewportFraction: 1,
                      //         autoPlay: true,
                      //         autoPlayInterval: Duration(seconds: 5),
                      //         aspectRatio: 4 / 3)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            // hintText: 'Email',
                            label: Text('Email'),
                            prefixIcon: Icon(Icons.email),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 3.0),
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                                borderRadius: BorderRadius.circular(30)),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 3.0),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        onFieldSubmitted: (value) {},
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscureText: !cubit.isShow,
                        decoration: InputDecoration(
                          focusColor: Theme.of(context).primaryColor,
                          hintText: 'Password',
                          prefixIcon: Icon(
                            CupertinoIcons.lock_fill,
                          ),
                          label: Text('Password'),
                          suffixIcon: IconButton(
                              icon: cubit.icon,
                              onPressed: () {
                                cubit.controlPassword();
                              }),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3.0),
                              borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.circular(30)),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 3.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      TextButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              cubit.login(emailcontroller.text,
                                  passwordcontroller.text);
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(30)),
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              child: state is! AppLoginLoadingState
                                  ? Text(
                                      'Login',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()),
                              );
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
