


import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Network/Cubit/login_cubit.dart';
import 'package:shop/Network/Cubit/login_states.dart';
import 'package:shop/Network/Shared/constant.dart';
import 'package:shop/Screens/register_screen.dart';
import 'package:shop/Network/Component/reusable_component.dart';

import '../Network/Shared/cache_helper.dart';
import 'Home_Screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key key}) : super(key: key);
   var formKey=GlobalKey<FormState>();

  var emailController =TextEditingController();
  var passwordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),

      child: BlocConsumer <ShopLoginCubit , ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState){
            if(state.loginModel.status){
              showToast(
                  text: state.loginModel.message,
                  state: ToastStates.SUCCESS
              );

              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data.token
              ).then((value){
                token= state.loginModel.data.token;
                navigateAndFinish(context, const HomeLayout());
              });

            }else{
              showToast(
                  text: state.loginModel.message,
                  state: ToastStates.ERROR
              );
            }

          }

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

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
                          suffix: ShopLoginCubit.get(context).suffix,
                          onSubmit: (value){
                            if (formKey.currentState.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                          suffixPressed: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is ! ShopLoginLoadingState,
                          builder:(context)=>defaultButton(
                            function: (){
                              if (formKey.currentState.validate()){
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context)=>const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            defaultTextButton(
                              function: () {
                                navigateAndFinish(
                                  context,
                                  RegisterScreen(),
                                );
                              },
                              text: 'register',

                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20.0,
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
