import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Network/Component/reusable_component.dart';
import 'package:shop/Network/Cubit/HomeCubit/shop_cubit.dart';
import 'package:shop/Network/Cubit/HomeCubit/shop_states.dart';
import 'package:shop/Network/Models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context ) {
    return BlocConsumer<ShopCubit ,ShopStates>(
      listener: (context ,state){},
      builder: (context ,state){

        return  ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context ,index)=> buildCatItem(ShopCubit.get(context).categoriesModel.data.data[index]),
            //buildTextItem(ShopCubit.get(context).categoriesModel.data.data[index]) ,    //for text only
            separatorBuilder: (context ,index)=>defaultLine2(),
            itemCount: ShopCubit.get(context).categoriesModel.data.data.length
        );
      },
    );
  }


  Widget buildTextItem(DataModel model)=>Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 7.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
      ),
      child: Text(model.name));




  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Image(
          width: 88,
          height: 88,
          fit: BoxFit.cover,
          image: NetworkImage(model.image),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          model.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(
            Icons.arrow_forward_ios
        )
      ],
    ),
  );
}
