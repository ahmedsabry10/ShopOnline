import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Network/Shared/dio_helper.dart';
import 'package:shop/Network/Shared/end_points.dart';
import '../../Models/register_model.dart';
import 'register_state.dart';

class ShopRegisterCubit extends Cubit <ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  IconData suffix =Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    suffix=isPassword ?Icons.visibility_off_outlined :Icons.visibility_outlined ;
    isPassword =! isPassword;
    emit(ShopChangePasswordVisibilityState());
  }

  RegisterModel registerModel;


  void userRegister({
    @required String name,
    @required String phone,
    @required String email,
    @required String password,
    @required String image,

  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(

        url: REGISTER,

        data: {
          'name':name,
          'phone':phone,
          'email':email,
          'password':password,
          'image':image,
        }).then((value) {
          print(value.data);
          registerModel=RegisterModel.fromJson(value.data);
          emit(ShopRegisterSuccessState(registerModel));

    }).catchError((error){
      emit(ShopRegisterErrorState(error));
    });

  }


}