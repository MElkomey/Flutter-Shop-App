import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_1/models/shop_model/categories_model.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context,state){
        return ListView.separated(
            itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context,index)=>SizedBox(height: 10,),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length);
      },
    );
  }

  Widget buildCatItem(DataModel model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(
          image: NetworkImage(
            model.image!,
          ),
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20.0,),
        Text(
          model.name!,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}