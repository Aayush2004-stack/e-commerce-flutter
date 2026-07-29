import 'package:flutter/material.dart';
import 'package:my_app/model/new_product_model.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';
import 'product_bottom_sheet.dart';

class ProductCard extends StatelessWidget {
  final NewProductModel product;
  // final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final isWishlisted = productProvider.isInWishlist("${product.id}");

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => ProductBottomSheet.show(context, product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    child: SizedBox.expand(
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
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white.withValues(alpha: 0.95),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 18,
                        onPressed: () {
                          context.read<ProductProvider>().toggleWishlist(
                            product,
                          );
                        },
                        icon: Icon(
                          isWishlisted ? Icons.favorite : Icons.favorite_border,

                          color: isWishlisted
                              ? Colors.red
                              : const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Material(
                      color: const Color(0xFF2563EB),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => ProductBottomSheet.show(context, product),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.add, color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF2563EB),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
