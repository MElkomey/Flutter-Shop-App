import 'package:shop_app_1/modules/shop_login/shop_login.dart';
import 'package:shop_app_1/shared/components/components.dart';
import 'package:shop_app_1/shared/network/local/shared_preferences/cashe_helper.dart';

void signOut(context){
  CasheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(context, ShopLogin());
  });
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token='';