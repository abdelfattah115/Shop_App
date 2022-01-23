import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoping_app/models/Login_Model.dart';
import 'package:shoping_app/shared/components/constents.dart';
import 'package:shoping_app/shared/network/remote/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  LoginModel? model;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingStates());
    DioHelper.postData(
        url: 'register',
        data: {
          'name' : name,
          'email':email,
          'password':password,
          'phone' : phone,
        },token: token,
    ).then((value){
      model = LoginModel.fromJson(value.data);
      emit(RegisterSuccessStates(model!));
      print(value.data);
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangeRegisterPasswordVisibilityStates());
  }
}
