import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_1/models/shop_model/categories_model.dart';
import 'package:shop_app_1/models/shop_model/home_model.dart';
import 'package:shop_app_1/shared/components/components.dart';
import 'package:shop_app_1/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if (state is ShopSuccessChangeFavouritesState){
          if(! state.model.status!){
            showToast(text: state.model.message!, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null&&ShopCubit.get(context).categoriesModel !=null,
          builder: (context) =>
              ProductBuilder(ShopCubit.get(context).homeModel!, ShopCubit.get(context).categoriesModel!,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget ProductBuilder(HomeModel model, CategoriesModel categoriesModel,context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                //view port fraction مش بيخلي اي صورة تدخل في التانية لو ب 1
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(
                  seconds: 3,
                ),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),),
           Container(
                   height: 100.0,
                   child: ListView.separated(
                     physics: BouncingScrollPhysics(),
                     scrollDirection: Axis.horizontal,
                       itemBuilder: (context, index) =>buildCategoryItem(categoriesModel.data!.data[index]) ,
                       separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
                       itemCount: categoriesModel.data!.data.length),
           ),
                  Text('New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),),
                ],
              ),
            ),

            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.7,
                children: List.generate(
                  model.data!.products.length,
                  (index) => buildGridProduct(model.data!.products[index],context),
                ),
              ),
            )
          ],
        ),
      );


  Widget buildCategoryItem(DataModel model)=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(image: NetworkImage(model.image!),
        width: 100,
        height: 100,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(0.7),
        child: Text(
          model.name!,
          style: TextStyle(color: Colors.white,fontSize: 16.0),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      )


    ],
  );


  Widget buildGridProduct(ProductModel model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
            alignment: AlignmentDirectional.bottomStart,
                children: [
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                // fit: BoxFit.cover,
                height: 200.0,
              ),
                  if (model.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
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
                  SizedBox(height: 15,),
                  Row(
                      children: [
                    Text(
                      '\$ ${model.price!.round()} ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '\$ ${model.oldPrice!.round()} ',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favourites[model.id]!? defaultColor:Colors.grey,
                      child: IconButton(
                        //padding: EdgeInsets.zero,
                          onPressed: (){
                            ShopCubit.get(context).changeFavourites(model.id!);
                          print('favourited ${model.id}');
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
      );
}
