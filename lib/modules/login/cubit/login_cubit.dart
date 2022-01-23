import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoping_app/models/Login_Model.dart';
import 'package:shoping_app/shared/network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? model;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingStates());
    DioHelper.postData(
      url: 'login',
      data: {
        'email':email,
        'password':password,
      },token: 'token'
    ).then((value){
      model = LoginModel.fromJson(value.data);
      emit(LoginSuccessStates(model!));
      print(value.data);
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityStates());
  }
}
