import 'package:shop_app_1/models/shop_model/shop_login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}
class ShopRegisterErrorState extends ShopRegisterStates{}

class ShopRegisterChangePasswordVisibility extends ShopRegisterStates{}
