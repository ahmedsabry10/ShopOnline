
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Network/Cubit/login_states.dart';
import 'package:shop/Network/Models/login_model.dart';
import 'package:shop/Network/Shared/dio_helper.dart';
import 'package:shop/Network/Shared/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit():super(ShopLoginInitialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  LoginModel loginModel;

  void userLogin({
  @required String email,
  @required String password,

  }){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        }).then((value) {
          print(value.data);

          loginModel=LoginModel.fromJson(value.data);

          emit(ShopLoginSuccessState(loginModel));

    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix =Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    suffix=isPassword ?Icons.visibility_off_outlined :Icons.visibility_outlined ;
    isPassword =! isPassword;
    emit(ShopChangePasswordVisibilityState());
  }
}