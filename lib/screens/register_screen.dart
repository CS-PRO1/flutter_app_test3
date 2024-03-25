// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_3/Services/Bloc%20Service/cubit.dart';
import 'package:flutter_application_3/screens/login_screen.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/states.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confPasswordController = TextEditingController();
  var phoneController = TextEditingController();
  String password = '';
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AppStates>(listener: (context, state) {
      if (state is AppRegisterSuccessState) {
        if (AuthCubit().get(context).userModel!.status!) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false);
        }
      }
    }, builder: (context, state) {
      var cubit = AuthCubit().get(context);
      return Scaffold(
          appBar: AppBar(
            title: Text('My APP'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Register',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Choose a Username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text('Username'),
                          prefixIcon: Icon(CupertinoIcons.person_fill),
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
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text('Phone Number'),
                          prefixIcon: Icon(Icons.phone_rounded),
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
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
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
                      onChanged: (value) {
                        password = value;
                      },
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      obscureText: !cubit.isShow,
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.lock_fill),
                          label: Text('Password'),
                          suffixIcon: IconButton(
                            icon: cubit.icon,
                            onPressed: () {
                              cubit.controlPassword();
                            },
                          ),
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
                      controller: confPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != password) {
                          return 'Password is incorrect';
                        }
                        return null;
                      },
                      obscureText: !cubit.isShow,
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.lock_rotation),
                          label: Text('Confirm Password'),
                          suffixIcon: IconButton(
                            icon: cubit.icon,
                            onPressed: () {
                              cubit.controlPassword();
                            },
                          ),
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
                      height: 17,
                    ),
                    TextButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            cubit.register(
                                usernameController.text,
                                phoneController.text,
                                emailController.text,
                                passwordController.text);
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30)),
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            child: state is! AppRegisterLoadingState
                                ? Text(
                                    'Register',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have an account?',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false);
                          },
                          child: Text(
                            'Login',
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
    });
  }
}
