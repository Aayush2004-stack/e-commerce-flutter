import 'package:flutter/material.dart';
import 'package:my_app/provider/product_provider.dart';
import 'package:my_app/screens/empty_page.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  //
  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final cartListItems = provider.cartItems;

        if (cartListItems.isEmpty) {
          return EmptyPage(title: 'Cart', icon: Icons.shopping_bag_outlined);
        }
        return ListView.separated(
          itemCount: cartListItems.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    child: Image.network(
                      cartListItems[index].product.images[0],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFF1F3F5),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.black38,
                          ),
                        );
                      },
                      width: 110,
                      height: 110,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartListItems[index].product.title),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xFF2563EB),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                productProvider.decreaseQuantity(
                                  cartListItems[index],
                                );
                              },
                              icon: Icon(
                                Icons.remove_circle,
                                color: Colors.white,
                              ),
                            ),

                            Text(
                              "${cartListItems[index].quantity}",
                              style: TextStyle(color: Colors.white),
                            ),

                            IconButton(
                              onPressed: () {
                                productProvider.addQuantity(
                                  cartListItems[index],
                                );
                              },
                              icon: Icon(Icons.add_circle, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        );
      },
    );
  }
}
