import 'dart:async';
import 'dart:developer';

import 'package:ecommerce_app_frontend_in_flutter/logic/user_cubit/user_cubit.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/user_cubit/user_state.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';





class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


 void goToNextScreen() {
    UserState userState = BlocProvider.of<UserCubit>(context).state;
    if(userState is UserLoggedInState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      log('is UserLoggedInState');
      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    }
    else if(userState is UserLoggedOutState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
       log('is UserLoggedOutState');
      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }
    else if(userState is UserErrorState) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      log('is UserErrorState');
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }
  }


  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 100), () {
      goToNextScreen();
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        goToNextScreen();
      },
      child: const Scaffold(
          body: Center(
            child: Text("SplashScreen")
          ),
      ),
    );
  }
}