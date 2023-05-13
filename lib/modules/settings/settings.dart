import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_1/modules/shop_login/shop_login.dart';
import 'package:shop_app_1/shared/components/components.dart';
import 'package:shop_app_1/shared/components/constants.dart';

class SettingScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
var nameController=TextEditingController();
var emailController=TextEditingController();
var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        //مش شغالة لان التحول بين ال states سريع اوي
        // if(state is ShopSuccessUserDataState){
        //   nameController.text=state.loginModel.data!.name!;
        //   emailController.text=state.loginModel.data!.email!;
        //   phoneController.text=state.loginModel.data!.phone!;
        // }
      },
      builder: (context,state){
        var model=ShopCubit.get(context).userModel;
        if(model != null){
        nameController.text=model.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;}

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel !=null,
          builder: (context)=>SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children:
                  [
                    if(state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(height: 15,),
                    defaultTextForm(
                        contrl: nameController,
                        typ: TextInputType.text,
                        validte: (value)
                        {
                          if(value.isEmpty){
                            return 'Name must not be empty';
                          }else{
                            return null;
                          }
                        },
                        labell: 'Name',
                        prefix: Icons.person
                    ),
                    SizedBox(height: 10.0,),
                    defaultTextForm(
                        contrl: emailController,
                        typ: TextInputType.emailAddress,
                        validte: (value)
                        {
                          if(value.isEmpty){
                            return 'Email must not be empty';
                          }else{
                            return null;
                          }
                        },
                        labell: 'Name',
                        prefix: Icons.email
                    ),
                    SizedBox(height: 10.0,),
                    defaultTextForm(
                        contrl: phoneController,
                        typ: TextInputType.number,
                        validte: (value)
                        {
                          if(value.isEmpty){
                            return 'Phone must not be empty';
                          }else{
                            return null;
                          }
                        },
                        labell: 'Phone',
                        prefix: Icons.phone
                    ),
                    SizedBox(height: 20,),
                    defalultButton(
                        function: (){
                          signOut(context,);
                        },
                        text: 'logout'),
                    SizedBox(height: 20,),
                    defalultButton(
                        function: (){
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        },
                        text: 'Update')
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}