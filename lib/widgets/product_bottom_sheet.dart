import 'package:flutter/material.dart';
import 'package:my_app/model/new_product_model.dart';
import 'package:my_app/model/product_cart_model.dart';
import 'package:my_app/provider/product_provider.dart';
import 'package:provider/provider.dart';



class ProductBottomSheet extends StatelessWidget {
  final NewProductModel product;
  // final ProductModel product;

  const ProductBottomSheet({super.key, required this.product});

  static Future<void> show(BuildContext context, NewProductModel product) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ProductBottomSheet(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final isInCart = productProvider.isInCartlist("${product.id}");

    return DraggableScrollableSheet(
      initialChildSize: 0.68,
      minChildSize: 0.45,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Image.network(
                        product.images[0],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFF1F3F5),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.black38,
                              size: 36,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.category.name,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'This bottom sheet can be used for product details, quick actions, cart, and wishlist controls.',
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('Close'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: !isInCart
                            ? FilledButton(
                                onPressed: () {
                                  productProvider.addProductInCart(
                                    ProductCartModel(product: product),
                                  );
                                },
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text('Add to cart'),
                              )
                            : Builder(
                                builder: (context) {
                                  final cartProduct = productProvider
                                      .getProduct("${product.id}");
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Color(0xFF2563EB),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            productProvider.decreaseQuantity(
                                              cartProduct,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.remove_circle,
                                            color: Colors.white,
                                          ),
                                        ),

                                        Text(
                                          "${cartProduct.quantity}",
                                          style: TextStyle(color: Colors.white),
                                        ),

                                        IconButton(
                                          onPressed: () {
                                            productProvider.addQuantity(
                                              cartProduct,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.add_circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
