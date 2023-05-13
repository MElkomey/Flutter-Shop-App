import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_1/models/shop_model/favourites_model.dart';
import 'package:shop_app_1/modules/shop_login/shop_login.dart';
import 'package:shop_app_1/shared/network/local/shared_preferences/cashe_helper.dart';
import 'package:shop_app_1/shared/styles/colors.dart';

void navigateTo(context,Widget){
  Navigator.push(context, MaterialPageRoute(builder:(context)=>Widget));
}


void navigateAndFinish(context,Widget){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder:(context)=>Widget),
      (route){
        return false;
      }
  );
}


///TextFormField///
Widget defaultTextForm(


    {
      ontap,
      onSubmitd,
      oncnged,
      bool isPasswrd = false,
      IconData? suffix,
      required TextEditingController contrl,
      required TextInputType typ,
      required validte,
      required String labell,
      required IconData prefix,
      suffixPressed,
    }) =>
    TextFormField(
      onTap: ontap,
      onFieldSubmitted: onSubmitd,
      onChanged: oncnged,
      controller: contrl,
      keyboardType: typ,
      obscureText: isPasswrd ? true : false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labell,
        prefixIcon: Icon(prefix),
        suffixIcon: (suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null),
      ),
      validator: validte,
    );



///button///
Widget defalultButton({
  double raidos = 0.0,
  double height = 40.0,
  double width = double.infinity,
  Color background = Colors.blue,
  required function,
  required String text,
  bool toUpperCase = true,
}) =>
    Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(raidos),
      ),
      height: height,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          toUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );


Widget defaultTextButton({
  required  function,
  required String text,
})=>TextButton(onPressed:function, child: Text(text.toUpperCase()));

void showToast({
  required String text,
  required ToastState state,
}) =>   Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastState{SUCCESS,ERROR,WARRNING}

Color? chooseToastColor(ToastState state){
  Color? color;
  switch(state){
    case (ToastState.SUCCESS):
      color=Colors.green;
      break;
    case (ToastState.ERROR):
      color=Colors.red;
      break;
    case (ToastState.WARRNING):
      color=Colors.amberAccent;
      break;
  }
  return color;
}

Widget buildFavItem( model,BuildContext context, {bool isOldPrice = true})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                // fit: BoxFit.cover,
                height: 120.0,
                width: 120.0,
              ),
              if (model.discount! != 0&& isOldPrice)
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ]),
        SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                  children: [
                    Text(
                      '\$ ${model.price!.toString()} ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount! != 0 && isOldPrice)
                      Text(
                        '\$ ${model.oldPrice!.toString()}',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                      //ShopCubit.get(context).favourites[model.id]!
                      ShopCubit.get(context).favourites[model.id]!?
                      defaultColor:Colors.grey,
                      child: IconButton(
                        //padding: EdgeInsets.zero,
                        onPressed: (){
                          ShopCubit.get(context).changeFavourites(model.id!);
                          // print('favourited ${model.id}');
                        },
                        icon:
                        Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                        iconSize: 14.0,
                      ),
                    )
                  ]),
            ],
          ),
        ),
      ],
    ),
  ),
);





