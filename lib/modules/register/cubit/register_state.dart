part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingStates extends RegisterState {}

class RegisterSuccessStates extends RegisterState {
  final LoginModel model;

  RegisterSuccessStates(this.model);
}

class RegisterErrorStates extends RegisterState {
  final String error;

  RegisterErrorStates(this.error);
}

class ChangeRegisterPasswordVisibilityStates extends RegisterState {}
