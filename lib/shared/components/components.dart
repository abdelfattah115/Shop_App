import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../layout/shop_cubit/shop_cubit.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

Widget defaultTextButton({
  required Function() onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text,
      ),
    );

Widget elevatedButtonBuilder(
        {Function()? onPressed, required String text, double? width}) =>
    ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        )),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
        fixedSize: MaterialStateProperty.all<Size?>(Size(width!, 60.0)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 26.0),
      ),
    );

Widget defaultButton({
  Function()? onPressed,
  String? text,
}) =>
    Container(
      width: double.infinity,
      height: 50,
      child: MaterialButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: onPressed,
        child: Text(
          text!,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue,
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  required String? validate(String? value),
  IconData? suffix,
  bool isPassword = false,
  Function()? suffixPressed,
  Function()? onTap,
  Function? onChange(String? val)?,
  Function? onSubmitted(String? val)?,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          onPressed: suffixPressed,
          icon: Icon(suffix),
        ),
        border: const OutlineInputBorder(),
      ),
      obscureText: isPassword,
      validator: validate,
      onTap: onTap,
      onFieldSubmitted: onSubmitted,
      onChanged: onChange,
    );

Widget defaultFormField(
        {onTap,
        required TextInputType type,
        String? label,
        required IconData prefix,
        required TextEditingController controller,
        IconData? suffix,
        bool isPassword = false,
        bool isClickable = true,
        onChanged,
        validate,
        onFieldSubmitted,
        suffixPassword,
        InputBorder? border}) =>
    TextFormField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onFieldSubmitted,
      validator: validate,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClickable,
      cursorHeight: 20.0,
      decoration: InputDecoration(
        border: border,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPassword,
              )
            : null,
        labelText: label,
        prefixIcon: Icon(prefix),
      ),
    );

void showToast({
  required String text,
  required ToastStates states,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: changeToastColor(states),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WREAD }

Color changeToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      return color = Colors.green;
      break;
    case ToastStates.ERROR:
      return color = Colors.red;
      break;
    case ToastStates.WREAD:
      return color = Colors.yellow;
      break;
  }
  return color;
}

Widget myDivider() => Divider(
      height: 1,
      color: Colors.grey[300],
      indent: 20,
      endIndent: 20,
    );

Widget buildListProduct(
  model,
  context, {
  bool isOldPrice = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 140,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                FadeInImage.assetNetwork(
                  placeholder: 'assets/images/onBoarding1.png',
                  image: model.image!,
                  width: 140,
                  height: 140,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price!.round()}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.old_price!.round()}',
                          style: TextStyle(
                            fontSize: 15.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            ShopCubit.get(context).favorites[model.id]!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
