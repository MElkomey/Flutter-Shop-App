import 'package:shop_app_1/models/shop_model/change_favourites_model.dart';
import 'package:shop_app_1/models/shop_model/shop_login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}
class ShopBottomNavBarState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeFavouritesState extends ShopStates{}
class ShopSuccessChangeFavouritesState extends ShopStates
{
  final ChangeFavouritesModel model;
  ShopSuccessChangeFavouritesState(this.model);
}
class ShopErrorChangeFavouritesState extends ShopStates{}

class ShopLoadingGetFavouritesState extends ShopStates{}
class ShopSuccessGetFavouritesState extends ShopStates{}
class ShopErrorGetFavouritesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}
class ShopErrorUpdateUserState extends ShopStates{}


