import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/Network/Component/reusable_component.dart';
import 'package:shop/Network/Cubit/HomeCubit/shop_cubit.dart';
import 'package:shop/Network/Cubit/HomeCubit/shop_states.dart';
import 'package:shop/Network/Models/categories_model.dart';
import 'package:shop/Network/Models/home_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit ,ShopStates>(
      listener: (context ,state){

        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status){
            showToast(
                text: state.model.message,
                state: ToastStates.ERROR
            );
          }
        }
      },
      builder: (context ,state){
        return ConditionalBuilder(
          condition:ShopCubit.get(context).homeModel != null  && ShopCubit.get(context).categoriesModel !=null ,
          builder: (context)=> productBuilder(ShopCubit.get(context).homeModel ,ShopCubit.get(context).categoriesModel, context),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),

        );
      },

    );
  }

  Widget productBuilder (HomeModel model , CategoriesModel categoriesModel, context)=> SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          // ال list  المتحركه
          CarouselSlider (
            items: model.data.banners.map((e) => Container(

              decoration: BoxDecoration(

                border: Border.all(
                  color: Colors.white,
                  width: 12,
                ),
              ),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 7.0,
                margin: const EdgeInsets.symmetric(
                  horizontal: 2.0,

                ),
                child: Image(
                  image: NetworkImage('${e.image}'),
                  width:double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            )).toList(),
            options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),



          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                    'Categories',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic
                ),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                // ال categories
                SizedBox(
                  height: 100.0,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoriesItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context ,index)=>const SizedBox(
                        width: 20.0,
                      ),
                      itemCount: categoriesModel.data.data.length,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),




                //ال New products

                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[700],
                      fontStyle: FontStyle.italic

                  ),
                ),
              ],
            ),
          ),


          const SizedBox(
            height: 20.0,
          ),



          Container(
            color: Colors.white60,
            child: GridView.count(

              crossAxisCount: 2,
              shrinkWrap: true ,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.95,
              children: List.generate(model.data.products.length, (index) => buildGridProduct(model.data.products[index], context)),
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildGridProduct(ProductModel model , context)=>Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 10.0
    ),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 7.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,

      ),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                height: 200.0,
                width: double.infinity,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],

          ),

          const SizedBox(
            height: 10.0,
          ),

          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name ,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),

                ),

                const SizedBox(
                  height: 5.0,
                ),

                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.deepOrange,
                      ),
                    ),

                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount !=0)
                      Text(
                          '${model.oldPrice.round()}',
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),

                      ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favorites[model.id]?Colors.deepOrange:Colors.grey,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                        onPressed: () {

                          ShopCubit.get(context).changeFavorites(model.id);

                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildCategoriesItem(DataModel model)=>Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 7.0,
    margin: const EdgeInsets.symmetric(
      horizontal: 2.0,
    ),
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          width: 100,
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
                color: Colors.white
            ),
          ),
        )
      ],
    ),
  );

}
