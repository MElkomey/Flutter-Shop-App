import 'package:flutter/material.dart';
import 'package:shop_app_1/layout/shop_layout/shop_layout.dart';
import 'package:shop_app_1/modules/on_boarding/on_boarding.dart';
import 'package:shop_app_1/modules/shop_login/shop_login.dart';
import 'package:shop_app_1/shared/components/constants.dart';
import 'package:shop_app_1/shared/styles/themes.dart';
import 'shared/network/local/shared_preferences/cashe_helper.dart';
import 'shared/network/remote/dio_helper/dio_helper.dart';

void main() async {
  Widget widget;
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CasheHelper.init();
  DioHelper.init();
  bool? onBoarding = CasheHelper.getData(key: 'onBoarding');
  token = CasheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLogin();
  } else {
    widget = shop_onBoarding();
  }

  // onBoarding==null? CasheHelper.saveData(key: 'onBoarding', value: false): onBoarding=CasheHelper.getData(key:'onBoarding');
  print(onBoarding);
  print(token);

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      darkTheme: darkTheme,
      home: startWidget,
    );
  }
}
