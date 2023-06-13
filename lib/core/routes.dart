


import 'package:ecommerce_app_frontend_in_flutter/data/models/product/product_model.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/Cart/cart_screen.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/auth/providers/signup_provider.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/home/home_screen.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/product/category_product_screen.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/product/product_details_screen.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes {

  static Route? onGenerateRoute(RouteSettings settings) {

    switch(settings.name) {

      case LoginScreen.routeName: return CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => LoginProvider(context),
          child: const LoginScreen())
      );

      case SignupScreen.routeName: return CupertinoPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => SignupProvider(context),
          child: const SignupScreen())
      );

      case HomeScreen.routeName: return CupertinoPageRoute(
        builder: (context) => const  HomeScreen()
      );

      case SplashScreen.routeName: return CupertinoPageRoute(
        builder: (context) => const  SplashScreen()
      );

     case ProductDetailsScreen.routeName: return CupertinoPageRoute(
          builder: (context) => ProductDetailsScreen(
          productModel: settings.arguments as ProductModel,
        )
      );

     case CartScreen.routeName: return CupertinoPageRoute(
          builder: (context) => CartScreen()
      );
      
      
        
    }




  }





}