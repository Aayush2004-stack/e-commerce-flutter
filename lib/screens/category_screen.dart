import 'package:flutter/material.dart';
import 'package:my_app/provider/category_provider.dart';
import 'package:my_app/screens/empty_page.dart';
import 'package:my_app/widgets/category_card.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CategoryProvider>().getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, provider, child) {
        final categoryItems = provider.categories;

        if (categoryItems.isEmpty) {
          return EmptyPage(title: 'Categories', icon: Icons.grid_view_outlined);
        }
        // return EmptyPage(title: "This is working", icon: Icons.abc);

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: categoryItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.66,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return CategoryCard(category: categoryItems[index]);
            },
          ),
        );
      },
    );
  }
}
