import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_1/models/shop_model/favourites_model.dart';
import 'package:shop_app_1/shared/components/components.dart';
import 'package:shop_app_1/shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context,state){
        return ConditionalBuilder(
        condition:state is !ShopLoadingGetFavouritesState && ShopCubit.get(context).favouritesModel!=null,
          builder:(context)=>ListView.separated(
              itemBuilder: (context,index)=>buildFavItem(ShopCubit.get(context).favouritesModel!.data!.data![index].product!,context),
              separatorBuilder: (context,index)=>SizedBox(height: 10,),
              itemCount: ShopCubit.get(context).favouritesModel!.data!.data!.length) ,
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
}