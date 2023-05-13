import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/models/shop_model/search_model.dart';
import 'package:shop_app_1/modules/search_screen/cubit/states.dart';
import 'package:shop_app_1/shared/components/constants.dart';
import 'package:shop_app_1/shared/network/remote/dio_helper/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search({required String text}) {
    emit(SearchLoadingState());

    DioHelper.postData(
        url: 'products/search',
        token: token,
        data: {
      'text': text,
    }).then((value) {
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());

    });
  }
}
