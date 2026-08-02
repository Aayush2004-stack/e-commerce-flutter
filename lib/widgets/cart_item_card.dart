import 'package:flutter/material.dart';
import 'package:my_app/model/product_cart_model.dart';
import 'package:my_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  final ProductCartModel item;

  const CartItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProductProvider>();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              item.product.images.first,
              width: 95,
              height: 95,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) {
                return Container(
                  width: 95,
                  height: 95,
                  color: Colors.grey.shade200,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title + Delete
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        provider.removeProductFromCart(item);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  "\$${item.product.price}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF2563EB),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              provider.decreaseQuantity(item);
                            },
                            icon: const Icon(Icons.remove),
                          ),

                          Text(
                            "${item.quantity}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              provider.addQuantity(item);
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}