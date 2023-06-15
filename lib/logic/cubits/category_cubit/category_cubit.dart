import 'package:ecommerce_app_frontend_in_flutter/data/models/category/category_model.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/repositories/category_repository.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cubits/category_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';





class CategoryCubit extends Cubit<CategoryState> {

  CategoryCubit() : super( CategoryInitialState() ) {
    _initialize();
  }

  final _categoryRepository = CategoryRepository();

  void _initialize() async {

    emit(CategoryLoadingState(state.categories));

    try {
      List<CategoryModel> categories = await _categoryRepository.fetchAllCategories();   //* <-- fetchAllCategories function call
      emit( CategoryLoadedState(categories) );
    }
    catch(ex) {
      emit( CategoryErrorState(ex.toString(), state.categories) );
    }
  }


}