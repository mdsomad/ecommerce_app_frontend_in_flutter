import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app_frontend_in_flutter/core/ui.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/cart_cubit/cart_state.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/services/calculations.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/services/formatter.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/widgets/link_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = "cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SafeArea(child: Expanded(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {

            if(state is CartLoadingState && state.items.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if(state is CartErrorState && state.items.isEmpty) {
              return Center(
                child: Text(state.message),
              );
            }

            if(state is CartLoadedState && state.items.isEmpty) {
              return const Center(
                child: Text("Cart items will show up here..")
              );
            }
            
            
            return Column(children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.items.length,
                itemBuilder: (context, index) {

                final item = state.items[index];
                  
                  return ListTile(
                    leading: CachedNetworkImage(imageUrl: item.product!.images![0]),
                    title: Text(item.product!.title!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${Formatter.formatPrice(item.product!.price!)} x ${item.quantity} = total ${Formatter.formatPrice(
                          item.product!.price! * item.quantity!
                        )}"),

                        LinkButton(
                          onPressed: (){
                            BlocProvider.of<CartCubit>(context).removeFromCart(item.product!);
                          },
                          color: Colors.red,
                          text: "Delete"
                        )
                      ],
                    ),

                    trailing: InputQty(
                      maxVal: 99,
                      initVal: item.quantity!,
                      minVal: 1,
                      showMessageLimit: false,
                      onQtyChanged: (value) {
                        BlocProvider.of<CartCubit>(context).addToCart(item.product!,value as int);
                        log(value.toString());
                      },
                    ),
                  );
                },
              ),


              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text("${state.items.length} items", style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),),
                               Text("Total: ${Formatter.formatPrice(Calculations.cartTotal(state.items))}", style: TextStyles.heading3,),
                            ],
                          ),
                        ),


                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: CupertinoButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, OrderDetailScreen.routeName);
                            },
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width / 22),
                            color: AppColors.accent,
                            child: const Text("Place Order"),
                          ),
                        ),
                      ]))




            ]);
          },
        ),
      )),
    );
  }
}
