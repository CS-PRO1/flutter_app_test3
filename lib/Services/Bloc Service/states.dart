abstract class AppStates {}

class AppInitState extends AppStates {}

/*

Authentication

*/

//Login

class AppLoginLoadingState extends AppStates {}

class AppLoginErrorState extends AppStates {}

class AppLoginSuccessState extends AppStates {}

//Register

class AppRegisterLoadingState extends AppStates {}

class AppRegisterErrorState extends AppStates {}

class AppRegisterSuccessState extends AppStates {}

//Logout

class AppLogoutLoadingState extends AppStates {}

class AppLogoutErrorState extends AppStates {}

class AppLogoutSuccessState extends AppStates {}

//Show/Hide Password

class PasswordShowState extends AppStates {}

class PasswordHideState extends AppStates {}

/*

Home Page

*/

class AppHomeSuccessState extends AppStates {}

class AppHomeErrorState extends AppStates {}

class AppHomeLoadingState extends AppStates {}

class ChangeBottomNavBarState extends AppStates {}

/*

Profile Screen

*/

class AppProfileLoadingState extends AppStates {}

class AppProfileSuccessState extends AppStates {}

class AppProfileErrorState extends AppStates {}

class AppProfileUpdateLoadingState extends AppStates {}

class AppProfileUpdateSuccessState extends AppStates {}

class AppProfileUpdateErrorState extends AppStates {}

/*

Category Screen

*/

class CategoryLoadingState extends AppStates {}

class CategorySuccessState extends AppStates {}

class CategoryErrorState extends AppStates {}

/*

Category Details Screen

*/

class CategoryDetailsLoadingState extends AppStates {}

class CategoryDetailsSuccessState extends AppStates {}

class CategoryDetailsErrorState extends AppStates {}

/*

Search

*/

class SearchLoadingState extends AppStates {}

class SearchSuccessState extends AppStates {}

class SearchErrorState extends AppStates {}

/*

Product

*/

class ProductLoadingState extends AppStates {}

class ProductSuccessState extends AppStates {}

class ProductErrorState extends AppStates {}

/*

Favorites

*/

//Favorites Page
class FavoritesLoadingState extends AppStates {}

class FavoritesSuccessState extends AppStates {}

class FavoritesErrorState extends AppStates {}

//Changing Favorites Status on a product

class FavoritesChangeLoadingState extends AppStates {}

class FavoritesChangeSuccessState extends AppStates {}

class FavoritesChangeErrorState extends AppStates {}

class FavoritesChangIconState extends AppStates {}

/*

  Cart

*/

class CartLoadingState extends AppStates {}

class CartSuccessState extends AppStates {}

class CartErrorState extends AppStates {}

/*

Theme Swtich

*/

class ChangeThemeState extends AppStates {}
