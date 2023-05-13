import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_1/layout/shop_layout/shop_layout.dart';
import 'package:shop_app_1/modules/shop_login/login_cubit/cubit.dart';
import 'package:shop_app_1/modules/shop_login/login_cubit/states.dart';
import 'package:shop_app_1/modules/shop_register/shop_register.dart';
import 'package:shop_app_1/shared/components/components.dart';
import 'package:shop_app_1/shared/components/constants.dart';
import 'package:shop_app_1/shared/network/local/shared_preferences/cashe_helper.dart';

class ShopLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
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
        builder: (context, state) {
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
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login now to show our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          contrl: emailController,
                          typ: TextInputType.emailAddress,
                          validte: (value) {
                            if (value.isEmpty) {
                              return 'This Form Must Not Be Empty';
                            } else {
                              return null;
                            }
                          },
                          labell: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextForm(
                          onSubmitd: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          contrl: passwordController,
                          typ: TextInputType.visiblePassword,
                          isPasswrd: ShopLoginCubit.get(context).isPassword,
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
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defalultButton(
                            text: 'login',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dont\'t have an account?',
                            ),
                            defaultTextButton(
                              text: 'register now',
                              function: () {
                                navigateTo(context, ShopRegister());
                              },
                            )
                          ],
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
