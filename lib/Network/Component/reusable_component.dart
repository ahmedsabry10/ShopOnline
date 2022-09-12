import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/Network/Cubit/HomeCubit/shop_cubit.dart';
Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
        labelText: label,
        labelStyle: const TextStyle(
          fontStyle: FontStyle.italic
        ),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.deepOrange,
            width: .3,
          ),
        ),
        /*
        border:  OutlineInputBorder(

          borderRadius: BorderRadius.circular(20.0)
        ),

         */
      ),
    );


//color: HexColor('#F39C12'),


Widget defaultLine()=>Container(
  width: double.infinity,
  height: 1.0,
  color: HexColor('#F39C12'),
);
Widget defaultLine2()=>Container(
  width: double.infinity,
  height: 1.0,
  color:Colors.grey[300],
);
/*
Widget defaultSignOut()=>
    TextButton(
      onPressed: (){
        CacheHelper.removeData(key: 'token').then((value){
          navigateAndFinish(context , LoginScreen());
        });
      },
      child: const Text(
          'Sigh Out'
      ),
    );

*/
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.deepOrange,
  bool isUpperCase = true,
  double radius = 15.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );


void navigateTo (context ,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context)=>widget),);



void navigateAndFinish(context ,widget)=>Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context)=>widget
  ),
      (Route <dynamic> route)=>false,
);

void showToast({
  @required String text,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 14.0,
    );

// enum
enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.deepOrange;
      break;
    case ToastStates.ERROR:
      color = HexColor('#7B7D7D');
      break;
    case ToastStates.WARNING:
      color = Colors.amber[300];
      break;
  }

  return color;
}


Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 14.0,
          fontStyle: FontStyle.italic


        ),
      ),
    );


Widget buildListProduct(
    model,
    context,

    ) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 75.0,
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 75.0,
              height: 75.0,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),

                  ),
                  const Spacer(),
              Text(
                model.price.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.deepOrange,
                ),
              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );