import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Network/Cubit/SearchCubit/search_states.dart';
import 'package:shop/Network/Shared/constant.dart';

import '../../Models/search_model.dart';
import '../../Shared/dio_helper.dart';
import '../../Shared/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}