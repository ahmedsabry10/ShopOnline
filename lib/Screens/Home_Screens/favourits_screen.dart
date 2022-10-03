import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Network/Component/reusable_component.dart';
import 'package:shop/Network/Cubit/HomeCubit/shop_cubit.dart';
import 'package:shop/Network/Cubit/HomeCubit/shop_states.dart';
import 'package:shop/Network/Models/favourite_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit ,ShopStates>(
      listener: (context ,state){

      },
      builder: (context ,state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesState,
            builder: (context) =>
                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildFavItem(ShopCubit
                          .get(context)
                          .favoritesModel
                          .data
                          .data[index], context),
                  separatorBuilder: (context, index) =>const SizedBox(height: 1.0,),
                  itemCount: ShopCubit
                      .get(context)
                      .favoritesModel
                      .data
                      .data
                      .length,
                ),
            fallback: (context) =>const Center(child: CircularProgressIndicator()),
          ),
        );
      }
        );


  }

  Widget buildFavItem(FavoritesData model ,context)=>Padding(
    padding: const EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 1.0
    ),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 7.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,

      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 3.0
        ),
        child: Container(
          height: 90,
          child: Row(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product.image),
                    height: 90,
                    width: 90,

                  ),
                  if (model.product.discount != 0)
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
                width: 20.0,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product.name ,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),

                    ),

                    Spacer(),

                    Row(
                      children: [
                        Text(
                          model.product.price.toString(),
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.deepOrange,
                          ),
                        ),

                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.product.discount !=0)
                          Text(
                            model.product.oldPrice.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),

                          ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: //ShopCubit.get(context).favorites[model.id]
                            ShopCubit.get(context).favorites[model.product.id]
                                ?Colors.deepOrange:Colors.grey,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.favorite_border,
                                size: 14.0,
                                color: Colors.white,
                              ),
                              onPressed: () {

                                ShopCubit.get(context).changeFavorites(model.product.id);

                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
