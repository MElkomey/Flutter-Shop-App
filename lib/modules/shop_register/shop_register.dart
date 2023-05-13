
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/shop_layout.dart';
import 'package:shop_app_1/modules/shop_login/login_cubit/cubit.dart';
import 'package:shop_app_1/modules/shop_register/register_cubit/cubit.dart';
import 'package:shop_app_1/modules/shop_register/register_cubit/states.dart';
import 'package:shop_app_1/shared/components/components.dart';
import 'package:shop_app_1/shared/components/constants.dart';
import 'package:shop_app_1/shared/network/local/shared_preferences/cashe_helper.dart';

class ShopRegister extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CasheHelper.saveData(
                  key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token= state.loginModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              //toast
              showToast(
                text: state.loginModel.message!,
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to show our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          contrl: nameController,
                          typ: TextInputType.name,
                          validte: (value) {
                            if (value.isEmpty) {
                              return 'Name Must Not Be Empty';
                            } else {
                              return null;
                            }
                          },
                          labell: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(height: 10,),
                        defaultTextForm(
                          contrl: emailController,
                          typ: TextInputType.emailAddress,
                          validte: (value) {
                            if (value.isEmpty) {
                              return 'Email Must Not Be Empty';
                            } else {
                              return null;
                            }
                          },
                          labell: 'Email',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          onSubmitd: (value) {},
                          contrl: passwordController,
                          typ: TextInputType.visiblePassword,
                          isPasswrd: ShopRegisterCubit.get(context).isPassword,
                          validte: (value) {
                            if (value.isEmpty) {
                              return 'Password Is Too SHort';
                            } else {
                              return null;
                            }
                          },
                          labell: 'Password',
                          prefix: Icons.lock_outline_rounded,
                          suffix: Icons.visibility,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextForm(
                          contrl: phoneController,
                          typ: TextInputType.phone,
                          validte: (value) {
                            if (value.isEmpty) {
                              return 'Phone Must Not Be Empty';
                            } else {
                              return null;
                            }
                          },
                          labell: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: true,
                          builder: (context) => defalultButton(
                            text: 'register',
                            toUpperCase: state is !ShopRegisterLoadingState,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  name: nameController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
