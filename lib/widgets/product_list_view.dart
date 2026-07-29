import 'package:flutter/material.dart';

import 'package:my_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'product_card.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductProvider>().getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      // return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final products = provider.products;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.66,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        );
      },
    );
  }
}
