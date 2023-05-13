
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/models/shop_model/shop_login_model.dart';
import 'package:shop_app_1/modules/shop_login/login_cubit/states.dart';
import 'package:shop_app_1/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:shop_app_1/shared/network/remote/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{



  ShopLoginCubit(): super(ShopLoginInitialState());
  static ShopLoginCubit get(context)=> BlocProvider.of(context);
  ShopLoginModel? loginModel;

void userLogin({
  required String email,
  required String password,
}){
  emit(ShopLoginLoadingState());
   DioHelper.postData(
      url: 'login',
      data: {
        'email':email,
        'password':password,
      }).then((value) {
       // print(value);
        loginModel=ShopLoginModel.fromJson(value.data);
        // print(loginModel!.status);
        // print(loginModel!.message);
        // print(loginModel?.data?.token);
        emit(ShopLoginSuccessState(loginModel!));
      }).catchError((error){
        emit(ShopLoginErrorState());
       // print(error.toString());
  })
  ;

}

bool isPassword=true;
IconData suffix=Icons.visibility_outlined;

void changePasswordVisibility(){
  isPassword=!isPassword;
  suffix= isPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
  emit(ShopLoginChangePasswordVisibility());
}

}