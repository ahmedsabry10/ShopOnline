import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Network/Models/categories_model.dart';
import 'package:shop/Network/Models/change_favourites_model.dart';
import 'package:shop/Network/Models/favourite_model.dart';
import 'package:shop/Network/Models/login_model.dart';
import '../../../Screens/Home_Screens/favourits_screen.dart';
import '../../../Screens/Home_Screens/product_screen.dart';
import '../../../Screens/Home_Screens/setting_screen.dart';
import '../../Models/home_model.dart';
import '../../Shared/constant.dart';
import '../../Shared/dio_helper.dart';
import '../../Shared/end_points.dart';
import 'shop_states.dart';

class ShopCubit extends Cubit <ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List <Widget> bottomScreens=[
    const ProductScreen(),

    const FavoritesScreen(),
    SettingsScreen(),
  ];


  void changeBottom(int index){
    currentIndex=index;
    emit(ChangeBottomNavState());
  }


  Map <int ,bool> favorites={};


  HomeModel homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error));
    });
  }

  // Categories  بتااع

  CategoriesModel categoriesModel;
  void getCategoriesData()
  {

    DioHelper.getData(
      url: GET_CATEGORIES ,
    ).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

//تغيير ال fav
  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId];

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel.status)
      {
        favorites[productId] = !favorites[productId];
      }
      else{
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];

      emit(ShopErrorChangeFavoritesState(error.toString()));
    });
  }


  //اسكرينه ال fav
  FavoritesModel favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,

    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


  // get profile

  LoginModel userModel;
  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE ,
      token: token,

    ).then((value) {
      userModel=LoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error){
      emit(ShopErrorUserDataState(error.toString()));
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {

      emit(ShopErrorUpdateUserState(error.toString()));
    });
  }

}

