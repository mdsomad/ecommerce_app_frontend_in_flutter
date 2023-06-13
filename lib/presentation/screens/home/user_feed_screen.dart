import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app_frontend_in_flutter/core/ui.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/product_cubit/product_cubit.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/product_cubit/product_state.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/widgets/gap_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/services/formatter.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit,ProductState>(
      builder: (context, state) {
        
        if(state is ProductLoadingState && state.products.isEmpty){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(state is ProductErrorState && state.products.isEmpty){
          return Center(
            child:Text(state.message),
          );
        }
        
        
        return ListView.builder(
          itemCount: state.products.length,
          itemBuilder: (context, index) {

            final product = state.products[index];
            
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  CachedNetworkImage(
                      width: MediaQuery.of(context).size.width / 3,
                      imageUrl:"${product.images?[0]}"
                    ),
            
                          // 'https://rukminim1.flixcart.com/image/832/832/xif0q/mobile/2/s/7/-original-imagmg6gktts6sfy.jpeg?q=70'),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title.toString(),
                          style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,overflow: TextOverflow.ellipsis,
                        ),
                        
                        Text(
                           product.description.toString(),
                           style:
                              TextStyles.body2.copyWith(color: AppColors.textLight),
                              maxLines: 2,overflow:TextOverflow.ellipsis,
                        ),
            
                       const GapWidget(),
            
                        Text(
                          "${Formatter.formatPrice(product.price!)}",
                          style: TextStyles.heading3,
                        ),
                      ],
                    ),
                  ),
            
                  IconButton(onPressed: (){}, icon:Icon(CupertinoIcons.cart))
                  
                ],
              ),
            );
          },
        );
      },
    );
  }
}
