part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopChangeNavBottomState extends ShopState {}

class ShopLoadingHomeDataState extends ShopState {}

class ShopSuccessHomeDataState extends ShopState {}
class ShopErrorHomeDataState extends ShopState {
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopState {}
class ShopErrorCategoriesState extends ShopState {
  final String error;

  ShopErrorCategoriesState(this.error);
}

class ShopChangeFavoritesState extends ShopState {}

class ShopSuccessChangeFavoritesState extends ShopState {
  final ChangeFavoritesModel favoritesModel;

  ShopSuccessChangeFavoritesState(this.favoritesModel);
}

class ShopErrorChangeFavoritesState extends ShopState {
  final String error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopLoadingFavoritesDataState extends ShopState {}

class ShopSuccessFavoritesDataState extends ShopState {}
class ShopErrorFavoritesDataState extends ShopState {
  final String error;

  ShopErrorFavoritesDataState(this.error);
}

class ShopLoadingUserDataState extends ShopState {}
class ShopSuccessUserDataState extends ShopState {
  final LoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopState {
  final String error;

  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateProfileState extends ShopState {}
class ShopSuccessUpdateProfileState extends ShopState {
  final LoginModel loginModel;

  ShopSuccessUpdateProfileState(this.loginModel);
}
class ShopErrorUpdateProfileState extends ShopState {
  final String error;

  ShopErrorUpdateProfileState(this.error);
}