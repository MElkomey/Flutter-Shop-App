import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_1/modules/search_screen/cubit/cubit.dart';
import 'package:shop_app_1/modules/search_screen/cubit/states.dart';
import 'package:shop_app_1/shared/components/components.dart';
import 'package:shop_app_1/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    defaultTextForm(
                      contrl: searchController,
                      typ: TextInputType.text,
                      validte: (value){
                        if(value.isEmpty){
                          return 'Enter text to search';
                        }else{
                         return null;
                        }
                      },
                      onSubmitd: (text){
                        SearchCubit.get(context).search(text: text);
                      },
                      labell: 'Search',
                      prefix: Icons.search,
                    ),
                    SizedBox(height: 10,),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    if(state is SearchSuccessState &&SearchCubit.get(context).model !=null )
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index)=>buildFavItem(SearchCubit.get(context).model?.data?.data?[index], context ,isOldPrice: false),
                          separatorBuilder: (context,index)=>SizedBox(height: 10,),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
