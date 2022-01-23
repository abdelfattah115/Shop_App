import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoping_app/models/Login_Model.dart';
import 'package:shoping_app/models/category_model.dart';
import 'package:shoping_app/models/change_favorite_model.dart';
import 'package:shoping_app/models/favorite_model.dart';
import 'package:shoping_app/models/shop_model.dart';
import 'package:shoping_app/modules/categories_screen.dart';
import 'package:shoping_app/modules/favorite_screen.dart';
import 'package:shoping_app/modules/products_screen.dart';
import 'package:shoping_app/modules/profile_screen.dart';
import 'package:shoping_app/shared/components/constents.dart';
import 'package:shoping_app/shared/network/remote/dio_helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void changeNavBottom(int index) {
    currentIndex = index;
    emit(ShopChangeNavBottomState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.in_favorites!});
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: 'categories',
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: 'favorites',
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError(
      (error) {
        favorites[productId] = !favorites[productId]!;
        emit(ShopErrorChangeFavoritesState(error.toString()));
      },
    );
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(ShopLoadingFavoritesDataState());
    DioHelper.getData(
      url: 'favorites',
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.formJson(value.data);
      emit(ShopSuccessFavoritesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavoritesDataState(error.toString()));
    });
  }

  LoginModel? userData;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: 'profile',
      token: token,
    ).then((value) {
      userData = LoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userData!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState(error.toString()));
    });
  }

  void updateUserData({
  required String name,
  required String email,
  required String phone,
}) {
    emit(ShopLoadingUpdateProfileState());
    DioHelper.putData(
      url: 'update-profile',
      token: token,
      query: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      },
    ).then((value) {
      userData = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateProfileState(userData!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateProfileState(error.toString()));
    });
  }
}
