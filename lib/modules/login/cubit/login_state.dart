part of 'login_cubit.dart';

@immutable
abstract class LoginStates {}

class LoginInitialStates extends LoginStates {}

class LoginLoadingStates extends LoginStates {}

class LoginSuccessStates extends LoginStates {
  final LoginModel model;

  LoginSuccessStates(this.model);
}

class LoginErrorStates extends LoginStates {
  final String error;

  LoginErrorStates(this.error);
}

class ChangePasswordVisibilityStates extends LoginStates {}


