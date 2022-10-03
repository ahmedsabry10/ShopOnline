import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Network/Component/reusable_component.dart';
import 'package:shop/Network/Cubit/HomeCubit/shop_cubit.dart';
import 'package:shop/Network/Cubit/HomeCubit/shop_states.dart';
import 'package:shop/Network/Shared/cache_helper.dart';
import 'package:shop/Network/Shared/constant.dart';
import 'package:shop/Screens/login_screen.dart';


class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

        nameController.text = ShopCubit.get(context).userModel.data.name;
        emailController.text = ShopCubit.get(context).userModel.data.email;
        phoneController.text = ShopCubit.get(context).userModel.data.phone;



        if (state is ShopSuccessUpdateUserState){
          if(state.loginModel.status){
            showToast(
                text: state.loginModel.message,
                state: ToastStates.SUCCESS
            );


          }else{

            showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR
            );
          }

        }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return Center(
          child: ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children:
                    [
                      if(state is ShopLoadingUpdateUserState)
                        const LinearProgressIndicator(),


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
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'name must not be empty';
                          }

                          return null;
                        },
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'email must not be empty';
                          }

                          return null;
                        },
                        label: 'Email Address',
                        prefix: Icons.email,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'phone must not be empty';
                          }

                          return null;
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        function: ()
                        {
                          if(formKey.currentState.validate())
                          {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          }
                        },
                        text: 'update',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          TextButton(
                            onPressed: (){
                              CacheHelper.removeData(key: 'token').then((value){
                                navigateAndFinish(context, LoginScreen());
                              });
                            },
                            child: const Text(
                                'LOGOUT'
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => const Center(child: const CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}