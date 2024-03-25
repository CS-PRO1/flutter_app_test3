import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cache/cache.dart';
import 'package:flutter_application_3/Services/Dio%20Service/dio.dart';
import 'package:flutter_application_3/models/cart_model.dart';
import 'package:flutter_application_3/models/cat_details_model.dart';
import 'package:flutter_application_3/models/category_model.dart';
import 'package:flutter_application_3/models/favorites_model.dart';
import 'package:flutter_application_3/models/home_model.dart';
import 'package:flutter_application_3/models/login_model.dart';
import 'package:flutter_application_3/models/product_model.dart';
import 'package:flutter_application_3/models/search_model.dart';
import 'package:flutter_application_3/screens/categories_screen.dart';
import 'package:flutter_application_3/screens/components.dart';
import 'package:flutter_application_3/screens/favorites_screen.dart';
import 'package:flutter_application_3/screens/home_screen.dart';
import 'package:flutter_application_3/screens/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_3/Services/Bloc%20Service/states.dart';

class AuthCubit extends Cubit<AppStates> {
  AuthCubit() : super(AppInitState());
  AuthCubit get(context) => BlocProvider.of(context);
  bool isShow = false;
  var icon = Icon(CupertinoIcons.eye_slash_fill);
  dynamic icon_colors = Colors.grey;

  controlPassword() {
    if (isShow) {
      isShow = false;
      icon = Icon(CupertinoIcons.eye_slash_fill);
    } else {
      isShow = true;
      icon = Icon(CupertinoIcons.eye_fill);
    }
    emit(PasswordShowState());
  }

  UserModel? userModel;

  login(String email, String password) {
    emit(AppLoginLoadingState());
    DioHelper.postData('login', {'email': email, 'password': password})
        .then((value) {
      if (value?.data['status'] == true) {
        userModel = UserModel.fromJson(value?.data);
        CacheHelper.setString('token', userModel!.data!.token!);
        CacheHelper.setString('password', password);
        toast(value?.data['message']);
        emit(AppLoginSuccessState());
      } else {
        toast(value?.data['message']);
        emit(AppLoginErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(AppLoginErrorState());
    });
  }

  //RegisterModel? registerModel;

  register(String name, String phone, String email, String password) {
    emit(AppRegisterLoadingState());
    print(name);
    print(phone);
    print(email);
    print(password);
    DioHelper.postData('register', {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    }).then((value) {
      if (value?.data['status'] == true) {
        userModel = UserModel.fromJson(value?.data);
        CacheHelper.setString('token', userModel!.data!.token!);
        CacheHelper.setString('password', password);
        toast(value?.data['message']);
        emit(AppRegisterSuccessState());
      } else {
        toast(value?.data['message']);
        emit(AppRegisterErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(AppRegisterErrorState());
    });
  }

  logOut() {
    emit(AppLogoutLoadingState());
    DioHelper.postData('logout', {}, token: CacheHelper.get('token'))
        .then((value) {
      CacheHelper.sharedPreferences?.remove('token');
      if (value?.data['status']) {
        toast('Logged out successfully');
        emit(AppLogoutSuccessState());
      } else {
        toast(value?.data['message']);
        emit(AppLogoutErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(AppLogoutErrorState());
    });
  }
}

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());
  AppCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  getHome() {
    emit(AppHomeLoadingState());
    DioHelper.getData('home', token: CacheHelper.get('token')).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
      value?.data['status']
          ? emit(AppHomeSuccessState())
          : emit(AppHomeErrorState());
    }).catchError((error) {
      print(error.toString());
      emit(AppHomeErrorState());
    });
  }

  UserModel? userModel;

  getProfile() {
    emit(AppProfileLoadingState());
    DioHelper.getData('profile', token: CacheHelper.get('token')).then((value) {
      userModel = UserModel.fromJson(value?.data);
      value?.data['status']
          ? emit(AppProfileSuccessState())
          : emit(AppProfileErrorState());
    }).catchError((error) {
      print(error.toString());
      emit(AppProfileErrorState());
    });
  }

  updateProfile(String name, String email, String phone, String password) {
    emit(AppProfileUpdateLoadingState());
    if (password == '') password = CacheHelper.get('password');
    DioHelper.putData(
            'update-profile',
            {
              'name': name,
              'email': email,
              'phone': phone,
              'password': password
            },
            token: CacheHelper.get('token'))
        .then((value) {
      userModel = UserModel.fromJson(value?.data);
      toast(value?.data['message']);
      value?.data['status']
          ? emit(AppProfileUpdateSuccessState())
          : emit(AppProfileUpdateErrorState());
    }).catchError((error) {
      print(error.toString());
      emit(AppProfileUpdateErrorState());
    });
  }

  int index = 0;
  List screens = [
    HomePageScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  changeNavBar(currentIndex) {
    index = currentIndex;
    emit(ChangeBottomNavBarState());
  }

  CategoryModel? catModel;
  getCategory() {
    catDetailsModel?.data = null;
    emit(CategoryLoadingState());
    DioHelper.getData('categories', token: CacheHelper.get('token'))
        .then((value) {
      catModel = CategoryModel.fromJson(value?.data);
      value?.data['status']
          ? emit(CategorySuccessState())
          : emit(CategoryErrorState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoryErrorState());
    });
  }

  CategoryDetailsModel? catDetailsModel;
  getCategoryDetails(model) {
    catDetailsModel?.data = null;
    emit(CategoryDetailsLoadingState());
    DioHelper.getData('categories/${model.id}', token: CacheHelper.get('token'))
        .then((value) {
      catDetailsModel = CategoryDetailsModel.fromJson(value?.data);
      value?.data['status']
          ? emit(CategoryDetailsSuccessState())
          : emit(CategoryDetailsErrorState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoryDetailsErrorState());
    });
  }

  SearchModel? searchModel;

  searchData(String item) {
    searchModel?.data = null;
    emit(SearchLoadingState());
    DioHelper.postData('products/search', {'text': item},
            token: CacheHelper.get('token'))
        .then((value) {
      searchModel = SearchModel.fromJson(value?.data);
      value?.data['status']
          ? emit(SearchSuccessState())
          : emit(SearchErrorState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }

  ProductModel? productModel;
  getProduct(model) {
    productModel?.data = null;
    emit(ProductLoadingState());
    DioHelper.getData('products/${model.id}', token: CacheHelper.get('token'))
        .then((value) {
      productModel = ProductModel.fromJson(value?.data);
      value?.data['status']
          ? emit(ProductSuccessState())
          : emit(ProductErrorState());
    }).catchError((error) {
      print(error.toString());
      emit(ProductErrorState());
    });
  }

  FavoritesModel? favoritesModel;
  getFavorites() {
    favoritesModel?.data = null;
    emit(FavoritesLoadingState());
    DioHelper.getData('favorites', token: CacheHelper.get('token'))
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value?.data);
      value?.data['status']
          ? emit(FavoritesSuccessState())
          : emit(FavoritesErrorState());
    }).catchError((error) {
      print(error.toString());
      emit(FavoritesErrorState());
    });
  }

  changeFavorite(id) {
    emit(FavoritesChangeLoadingState());
    DioHelper.postData('favorites', {'product_id': id},
            token: CacheHelper.get('token'))
        .then((value) {
      value?.data['status']
          ? emit(FavoritesChangeSuccessState())
          : emit(FavoritesChangeErrorState());
    }).catchError((error) {
      print(error.toString());
      emit(FavoritesErrorState());
    });
  }

  CartModel? cartModel;
  getCart() {
    emit(CartLoadingState());
    DioHelper.getData('carts', token: CacheHelper.get('token')).then((value) {
      cartModel = CartModel.fromJson(value?.data);
      value?.data['status']
          ? emit(FavoritesChangeSuccessState())
          : emit(FavoritesChangeErrorState());
    }).catchError((error) {});
  }

  // changeFavIcon(icon) {
  //   if (icon == Icons.favorite_outline_rounded) icon = Icons.favorite_rounded;
  //   if (icon == Icons.favorite_rounded) icon = Icons.favorite_outline_rounded;
  //   emit(FavoritesChangIconState());
  // }

  // bool isDark = CacheHelper.get('isDark') ?? false;
  // // ?? means if this was null then set the variable to whatever is after it.

  // changeTheme() {
  //   isDark = !isDark;
  //   CacheHelper.setBool('isDark', isDark);
  //   emit(ChangeThemeState());
  // }
}
