import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app_frontend_in_flutter/core/ui.dart';
import 'package:ecommerce_app_frontend_in_flutter/data/models/product/product_model.dart';
import 'package:ecommerce_app_frontend_in_flutter/logic/services/formatter.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/screens/product/product_details_screen.dart';
import 'package:ecommerce_app_frontend_in_flutter/presentation/widgets/gap_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;
  
  const ProductListView({
    super.key,
    required this.products
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {

        final product = products[index];

        return CupertinoButton(
          onPressed: () {
            Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product);
          },
          padding: EdgeInsets.zero,
          child: Row(
            children: [
        
              CachedNetworkImage(
                width: MediaQuery.of(context).size.width / 3,
                imageUrl: "${product.images?[0]}",
              ),
        
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${product.title}", style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,),
                    Text("${product.description}", style: TextStyles.body2.copyWith(color: AppColors.textLight),maxLines: 2, overflow: TextOverflow.ellipsis,),
                    const GapWidget(),
                    Text(Formatter.formatPrice(product.price!), style: TextStyles.heading3,)
                  ],
                ),
              ),
        
            ],
          ),
        );

      },
    );
  }
}
