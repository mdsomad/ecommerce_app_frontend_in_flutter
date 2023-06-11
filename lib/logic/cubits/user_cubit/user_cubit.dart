import 'dart:developer';
import 'package:ecommerce_app_frontend_in_flutter/data/models/user/user_model.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/repositories/user_repository.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class UserCubit extends Cubit<UserState> {
  
   UserCubit() : super( UserInitialState() ) {
    // _initialize();
  }


final UserRepository _userRepository = UserRepository();

   
  void signIn({
    required String email,
    required String password
  }) async {
    emit( UserLoadingState() );
    try {
      UserModel userModel = await _userRepository.signIn(email: email, password: password);
      emit(UserLoggedInState(userModel));
    }
    catch(ex) {
      log(ex.toString());
      emit(UserErrorState(ex.toString()));
    }
  }






  void createAccount({
    required String email,
    required String password
  }) async {
    emit( UserLoadingState() );
    try {
      UserModel userModel = await _userRepository.createAccount(email: email, password: password);
      emit(UserLoggedInState(userModel));
    }
    catch(ex) {
      emit(UserErrorState(ex.toString()) );
    }
  }
   
   
   
   
  
    
}