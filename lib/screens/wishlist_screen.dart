import 'package:flutter/material.dart';
import 'package:my_app/provider/product_provider.dart';
import 'package:my_app/widgets/product_card.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final wishListItems = provider.wishlistItems;

        if (wishListItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.favorite_outline, size: 50),
                SizedBox(height: 12),
                Text("WishList is empty"),
              ],
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: wishListItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.66,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return ProductCard(product: wishListItems[index]);
          },
        );
      },
    );
  }
}
