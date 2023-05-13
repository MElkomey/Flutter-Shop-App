import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_1/models/shop_model/categories_model.dart';
import 'package:shop_app_1/models/shop_model/change_favourites_model.dart';
import 'package:shop_app_1/models/shop_model/favourites_model.dart';
import 'package:shop_app_1/models/shop_model/home_model.dart';
import 'package:shop_app_1/models/shop_model/shop_login_model.dart';
import 'package:shop_app_1/modules/categories/categories.dart';
import 'package:shop_app_1/modules/favourites/favourites.dart';
import 'package:shop_app_1/modules/products/shop_products.dart';
import 'package:shop_app_1/modules/settings/settings.dart';
import 'package:shop_app_1/shared/components/constants.dart';
import 'package:shop_app_1/shared/network/remote/dio_helper/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingScreen(),
  ];
  void bottomNavBarChange(int index)
  {
    currentIndex = index;
    emit(ShopBottomNavBarState());
  }

  HomeModel? homeModel;
  Map<int,bool> favourites={};
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: 'home',
      token:token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel?.data?.banners.toString());
      print(homeModel?.status);
      //الحتة بتاعت ال favourites
      homeModel!.data!.products.forEach((element) {
        favourites.addAll(
          {
            element.id!:element.inFavorites!,
          });
      });
      print(favourites.toString());
      emit(ShopSuccessHomeDataState());
     // printFullText(homeModel.toString());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
      print(error);
    });
  }


  CategoriesModel? categoriesModel;
  void getCategories()
  {
    DioHelper.getData(
      url: 'categories',
      token:token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
      // printFullText(homeModel.toString());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
      print(error);
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int productId)
  {
    favourites[productId] = ! favourites[productId]!;
    emit(ShopChangeFavouritesState());

    DioHelper.postData(
        url: 'favorites',
        data: {'product_id':productId},
      token: token,
    ).then((value) {
      changeFavouritesModel=ChangeFavouritesModel.fromJson(value.data);
      print(value.data);
      if( ! changeFavouritesModel!.status!){
        favourites[productId] = ! favourites[productId]!;
      }else{
        getFavourites();
      }
      emit(ShopSuccessChangeFavouritesState(changeFavouritesModel!));
    }).catchError((error){
      //بقلبو تاني لاصلو لو حصل ايرور
      favourites[productId] = ! favourites[productId]!;
      emit(ShopErrorChangeFavouritesState());
    });
  }


  FavouritesModel? favouritesModel;
  void getFavourites()
  {
    emit(ShopLoadingGetFavouritesState());
    DioHelper.getData(
      url: 'favorites',
      token:token,
    ).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
     // printFullText(value.data.toString());
      emit(ShopSuccessGetFavouritesState());
      // printFullText(homeModel.toString());
    }).catchError((error) {
      emit(ShopErrorGetFavouritesState());
      print(error);
    });
  }

  ShopLoginModel? userModel;
  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: 'profile',
      token:token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      // printFullText(value.data.toString());
      emit(ShopSuccessUserDataState(userModel!));
      // printFullText(homeModel.toString());
    }).catchError((error) {
      emit(ShopErrorUserDataState());
      print(error);
    });
  }

  void updateUserData({
  required String name,
    required String email,
    required String phone,
  })
  {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: 'update-profile',
      token:token,
      data: {
        'name':name,
        'email':email,
        'phone':'phone',
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      // printFullText(value.data.toString());
      emit(ShopSuccessUpdateUserState(userModel!));
      // printFullText(homeModel.toString());
    }).catchError((error) {
      emit(ShopErrorUpdateUserState());
      print(error);
    });
  }
}
