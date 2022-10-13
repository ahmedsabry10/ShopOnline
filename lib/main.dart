import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/Network/Cubit/HomeCubit/shop_cubit.dart';
import 'package:shop/Network/Shared/cache_helper.dart';
import 'package:shop/Network/Shared/constant.dart';
import 'package:shop/Network/Shared/dio_helper.dart';
import 'package:shop/Screens/Auth_Screens/login_screen.dart';
import 'package:shop/Screens/Auth_Screens/onBoard.dart';


import 'Screens/Home_Screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding =CacheHelper.getData(key: 'onBoarding');
  token =CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding!=null){
    if(token!=null) {
      widget=const HomeLayout();
    } else {
      widget=LoginScreen();
    }
  }else {
    widget=const OnBoardingScreen();
  }
  runApp( MyApp(
      startWidget:widget
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    this.startWidget,
  });


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopCubit()..getFavorites()..getUserData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            drawerTheme: DrawerThemeData(
              backgroundColor: HexColor('#F4F6F7'),
            ),
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor:Colors.white,
            appBarTheme:const AppBarTheme(
                titleSpacing: 20.0,
                backgroundColor: Colors.white,
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                )
            ),
            bottomNavigationBarTheme:const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
            ),

            textTheme:const TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              bodyText2: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            )
        ),
        home: startWidget,
      ),
    );
  }
}

