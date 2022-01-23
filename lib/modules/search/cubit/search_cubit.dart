import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/search_model.dart';
import '../../../shared/components/constents.dart';
import '../../../shared/network/remote/dio_helper.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: 'products/search',
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.formJson(value.data);
      emit(SearchSuccessState());
    }).catchError(
      (error) {
        emit(SearchErrorState());
      },
    );
  }
}
