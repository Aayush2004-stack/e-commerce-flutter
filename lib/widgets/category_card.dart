import 'package:flutter/material.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();

    final noOfProducts = productProvider.getTotalProductByCategory(category);

    return InkWell(
      borderRadius: BorderRadius.circular(18),

      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 193, 192, 192),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Category Imagess
              Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.network(
                    category.image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "$noOfProducts items", // Placeholder
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
