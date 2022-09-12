
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Network/Component/reusable_component.dart';
import 'package:shop/Screens/Home_Screens/search_screen.dart';
import '../../Network/Cubit/HomeCubit/shop_cubit.dart';
import '../../Network/Cubit/HomeCubit/shop_states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),
      child: BlocConsumer <ShopCubit ,ShopStates> (
          listener: (context, state) {},
          builder: (context,state){
            var cubit =ShopCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    icon:Icon(Icons.search),
                    onPressed: (){
                      navigateTo(context, SearchScreen());
                    },
                  )
                ],
              ),
              body:cubit.bottomScreens[cubit.currentIndex],

              bottomNavigationBar:BottomNavigationBar(
                onTap: (index){
                  cubit.changeBottom(index);
                },
                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ) ,

            );
      }


      ),
    );
  }
}
