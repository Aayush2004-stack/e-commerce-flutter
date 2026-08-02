import 'package:flutter/material.dart';
import 'package:my_app/provider/product_provider.dart';
import 'package:my_app/screens/empty_page.dart';
import 'package:my_app/widgets/cart_item_card.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  //
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final cartListItems = provider.cartItems;

        if (cartListItems.isEmpty) {
          return EmptyPage(title: 'Cart', icon: Icons.shopping_bag_outlined);
        }
        return Scaffold(
          backgroundColor: const Color(0xffF7F8FA),

          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),

                child: Row(
                  children: [
                    const Text(
                      "Your Bag",

                      style: TextStyle(
                        fontSize: 24,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      "${cartListItems.length} item${cartListItems.length > 1 ? "s" : ""}",

                      style: TextStyle(
                        color: Colors.grey.shade600,

                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),

                  itemCount: cartListItems.length,

                  separatorBuilder: (_, _) => const SizedBox(height: 18),

                  itemBuilder: (_, index) {
                    return CartItemCard(item: cartListItems[index]);
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),

                decoration: const BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),

                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15)],
                ),

                child: SafeArea(
                  top: false,

                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Total",

                            style: TextStyle(color: Colors.grey.shade600),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "\$${provider.totalPrice}",

                            style: const TextStyle(
                              fontSize: 28,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      SizedBox(
                        height: 54,

                        child: FilledButton(
                          onPressed: () {},

                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),

                          child: const Text(
                            "Checkout",

                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

        // return ListView.separated(
        //   itemCount: cartListItems.length,
        //   itemBuilder: (context, index) {
        //     return Container(
        //       padding: const EdgeInsets.all(16),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(16),
        //         color: Colors.white,
        //       ),
        //       child: Row(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           ClipRRect(
        //             borderRadius: BorderRadiusGeometry.circular(16),
        //             child: Image.network(
        //               cartListItems[index].product.images[0],
        //               fit: BoxFit.cover,
        //               errorBuilder: (context, error, stackTrace) {
        //                 return Container(
        //                   color: const Color(0xFFF1F3F5),
        //                   alignment: Alignment.center,
        //                   child: const Icon(
        //                     Icons.image_not_supported_outlined,
        //                     color: Colors.black38,
        //                   ),
        //                 );
        //               },
        //               width: 110,
        //               height: 110,
        //             ),
        //           ),
        //           SizedBox(width: 20),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(cartListItems[index].product.title),
        //               SizedBox(height: 20),
        //               Container(
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(16),
        //                   color: Color(0xFF2563EB),
        //                 ),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     IconButton(
        //                       onPressed: () {
        //                         productProvider.decreaseQuantity(
        //                           cartListItems[index],
        //                         );
        //                       },
        //                       icon: Icon(
        //                         Icons.remove_circle,
        //                         color: Colors.white,
        //                       ),
        //                     ),

        //                     Text(
        //                       "${cartListItems[index].quantity}",
        //                       style: TextStyle(color: Colors.white),
        //                     ),

        //                     IconButton(
        //                       onPressed: () {
        //                         productProvider.addQuantity(
        //                           cartListItems[index],
        //                         );
        //                       },
        //                       icon: Icon(Icons.add_circle, color: Colors.white),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        //   separatorBuilder: (context, index) {
        //     return const Divider();
        //   },
        // );
      },
    );
  }
}
