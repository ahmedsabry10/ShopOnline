import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Network/Component/reusable_component.dart';
import 'package:shop/Network/Cubit/Register_Cubit/register_cubit.dart';
import 'package:shop/Network/Cubit/Register_Cubit/register_state.dart';
import 'package:shop/Network/Shared/constant.dart';
import 'package:shop/Screens/Home_Screens/home_screen.dart';

import '../Network/Shared/cache_helper.dart';
import 'login_screen.dart';


class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key key}) : super(key: key);
   var nameController =TextEditingController();
   var emailController =TextEditingController();
   var phoneController =TextEditingController();
   var imageController =TextEditingController();
   var passwordController =TextEditingController();

   var formKey =GlobalKey<FormState> ();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit ,ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState){
            if(state.registerModel.status){
              showToast(
                  text: state.registerModel.message,
                  state: ToastStates.SUCCESS
              );

              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.data.token,
              ).then((value) {
                token = state.registerModel.data.token;
                navigateAndFinish(context, HomeLayout());
              });
            }else{
              showToast(
                  text: state.registerModel.message,
                  state: ToastStates.ERROR
              );
            }

          }

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                          children:  [

                            //image
                            Container(
                              height: 200.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/logo5.png"
                                  ),

                                ),

                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),



                            //name
                            defaultFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                validate:  (String value) {
                                  if (value.isEmpty) {
                                    return 'please enter your email address';
                                  }
                                },
                                label: 'Name',
                                prefix: Icons.drive_file_rename_outline),

                            const SizedBox(
                              height: 20.0,
                            ),




                            //phone
                            defaultFormField(
                                controller: phoneController,
                                type: TextInputType.number,
                                validate:(String value) {
                                  if (value.isEmpty) {
                                    return 'please enter your phone';
                                  }
                                },
                                label: 'phone',
                                prefix: Icons.phone_android_outlined
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),


                            //email
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter your email address';
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),



                            //password
                            defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'please enter your password';
                                }
                              },
                              label: 'Password',
                              prefix: Icons.lock_outline,
                              suffix: ShopRegisterCubit.get(context).suffix,
                              onSubmit: (value){
                                if (formKey.currentState.validate()){
                                  ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      image: imageController.text
                                  );
                                }
                              },
                              suffixPressed: (){
                                ShopRegisterCubit.get(context).changePasswordVisibility();
                              },
                              isPassword: ShopRegisterCubit.get(context).isPassword,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),



                            //image



                            //button
                            ConditionalBuilder(
                              condition:state is ! ShopRegisterLoadingState,
                              builder:(context)=>defaultButton(
                                function: (){
                                  if (formKey.currentState.validate()){
                                    ShopRegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        image: imageController.text
                                    );
                                  }
                                },
                                text: 'Confirm',
                                isUpperCase: true,
                              ),
                              fallback: (context)=>const Center(child: CircularProgressIndicator()),
                            ),

                            const SizedBox(
                              height: 10.0,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  ' have an account?',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:14.0,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                defaultTextButton(
                                  function: () {
                                    navigateAndFinish(
                                      context,
                                      LoginScreen(),
                                    );
                                  },
                                  text: 'Sign In',
                                ),
                              ],
                            ),






                          ]
                      ),
                    )
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

