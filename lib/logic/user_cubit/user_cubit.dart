import 'dart:developer';
import 'package:ecommerce_app_frontend_in_flutter/data/models/user/user_model.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/repositories/user_repository.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/user_cubit/user_state.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/services/preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class UserCubit extends Cubit<UserState> {
  
   UserCubit() : super( UserInitialState() ) {
     _initialize();
  }


final UserRepository _userRepository = UserRepository();




 // TODO Create User _initialize function Local Save details get
  void _initialize() async {
    final userDetails = await Preferences.fetchUserDetails();
    String? email = userDetails["email"];
    String? password = userDetails["password"];

    if(email == null || password == null) {
      emit( UserLoggedOutState() );
    }
    else {
      signIn(email: email, password: password);
    }
  }






 // TODO Create User _emitLoggedInState function Local Save User details
  void _emitLoggedInState({
    required UserModel userModel,
    required String email,
    required String password
  }) async {
    await Preferences.saveUserDetails(email, password);
    emit(UserLoggedInState(userModel) );
  }







 // TODO Create User signIn function
  void signIn({
    required String email,
    required String password
  }) async {
    emit( UserLoadingState() );
    try {
      UserModel userModel = await _userRepository.signIn(email: email, password: password);
       _emitLoggedInState(userModel: userModel, email: email, password: password);
    }
    catch(ex) {
      log(ex.toString());
      emit(UserErrorState(ex.toString()));
    }
  }





// TODO Create User createAccount function
  void createAccount({
    required String email,
    required String password
  }) async {
    emit( UserLoadingState() );
    try {
      UserModel userModel = await _userRepository.createAccount(email: email, password: password);
      _emitLoggedInState(userModel: userModel, email: email, password: password);

    }
    catch(ex) {
      emit(UserErrorState(ex.toString()) );
    }
  }
   
  





  // TODO Create updateUser function
  Future<bool> updateUser(UserModel userModel) async {
    emit( UserLoadingState() );
    try {
      UserModel updatedUser = await _userRepository.updateUser(userModel);
      emit( UserLoggedInState(updatedUser) );
      return true;
    }
    catch(ex) {
      emit( UserErrorState(ex.toString()) );
      return false;
    }
  }
  
  
  
  
   
// TODO Create User signOut function
  void signOut() async {
    await Preferences.clear();
    emit(UserLoggedOutState() );
  }
  
    
}