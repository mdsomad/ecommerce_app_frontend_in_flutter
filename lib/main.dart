import 'dart:developer';

import 'package:ecommerce_app_frontend_in_flutter/core/routes.dart';
import 'package:ecommerce_app_frontend_in_flutter/core/ui.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/category_cubit/category_cubit.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/product_cubit/product_cubit.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/home/home_screen.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [

        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => CategoryCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => CartCubit(
          BlocProvider.of<UserCubit>(context)           //* <-- Send _userCubit 
        )),

      ],
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce App',
        theme: Themes.defaultTheme,
        
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: SplashScreen.routeName,



        // home:HomeScreen() ,
        
      ),

    );
  }
}







class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("Change in $bloc: $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("Change in $bloc: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log("Closed: $bloc");
    super.onClose(bloc);
  }
}