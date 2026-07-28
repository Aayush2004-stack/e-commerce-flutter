# Wishlist Section Student Guide

Use this as a classroom TODO sheet and implementation guide for adding a wishlist section to the app with `provider`.

## Student TODO

- [ ] Add wishlist state to `ProductProvider`
- [ ] Add `toggleWishlist`, `isInWishlist`, and `wishlistItems`
- [ ] Update `ProductCard` so the heart icon toggles wishlist state
- [ ] Create a `WishlistScreen`
- [ ] Replace the wishlist placeholder in `MainShell`
- [ ] Test that tapping the heart adds and removes items

## Build Order

1. Update the provider first.
2. Update the product card second.
3. Create the wishlist screen third.
4. Connect the screen in the bottom navigation last.

## Goal

The wishlist feature should:

- save products when the heart icon is tapped,
- remove products when the heart icon is tapped again,
- show saved items on a dedicated Wishlist page,
- keep all wishlist data inside `ProductProvider`.

## 1) Update the provider

Edit `lib/provider/product_provider.dart`.

```dart
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final List<ProductModel> _products = [
    ProductModel(
      id: '1',
      name: 'Essence Organic Hoodie',
      imageUrl:
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&q=80&w=400',
      price: 120.00,
      oldPrice: 165.00,
      rating: 4.9,
      category: 'Clothing',
    ),
    ProductModel(
      id: '2',
      name: 'Vanguard Chelsea Boots',
      imageUrl:
          'https://images.unsplash.com/photo-1638247025967-b4e38f787b76?auto=format&fit=crop&q=80&w=400',
      price: 245.00,
      oldPrice: 310.00,
      rating: 4.8,
      category: 'Accessories',
    ),
  ];

  final List<ProductModel> _wishlist = [];

  List<ProductModel> get products => List.unmodifiable(_products);
  List<ProductModel> get wishlistItems => List.unmodifiable(_wishlist);

  void toggleWishlist(ProductModel product) {
    final exists = _wishlist.any((item) => item.id == product.id);

    if (exists) {
      _wishlist.removeWhere((item) => item.id == product.id);
    } else {
      _wishlist.add(product);
    }

    notifyListeners();
  }

  bool isInWishlist(String id) {
    return _wishlist.any((product) => product.id == id);
  }
}
```

### What students should learn

- `_wishlist` is the private list that stores saved products.
- `wishlistItems` exposes a read-only version for the UI.
- `toggleWishlist` adds or removes a product.
- `notifyListeners()` tells Flutter to rebuild the screen.

## 2) Update the product card

Edit `lib/widgets/product_card.dart`.

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../provider/product_provider.dart';
import 'product_bottom_sheet.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final isWishlisted = productProvider.isInWishlist(product.id);

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
                        product.imageUrl,
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
                          context.read<ProductProvider>().toggleWishlist(product);
                        },
                        icon: Icon(
                          isWishlisted ? Icons.favorite : Icons.favorite_border,
                          color: isWishlisted ? Colors.red : Colors.black87,
                        ),
                      ),
                    ),
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
```

### What students should check

- The heart should change color after tapping.
- The wishlist state should update immediately.
- The product card should rebuild automatically.

## 3) Create the wishlist screen

Create `lib/screens/wishlist_screen.dart`.

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';
import '../widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final wishlistItems = provider.wishlistItems;

        if (wishlistItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.favorite_outline, size: 48),
                SizedBox(height: 12),
                Text('Wishlist is empty'),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.66,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: wishlistItems.length,
          itemBuilder: (context, index) {
            return ProductCard(product: wishlistItems[index]);
          },
        );
      },
    );
  }
}
```

### Student task

- Show an empty state when no items are saved.
- Show the saved products in a grid when items exist.

## 4) Connect the wishlist screen

Edit `lib/screens/main_shell.dart`.

```dart
import 'empty_page.dart';
import 'home_screen.dart';
import 'wishlist_screen.dart';

class _MainShellState extends State<MainShell> {
  int currentIndex = 0;

  late final List<Widget> pages = [
    const HomeScreen(),
    const EmptyPage(title: 'Categories', icon: Icons.grid_view_outlined),
    const EmptyPage(title: 'Cart', icon: Icons.shopping_bag_outlined),
    const WishlistScreen(),
    const EmptyPage(title: 'Profile', icon: Icons.person_outline),
  ];
}
```

### What students should test

- The Wishlist tab opens the new screen.
- Saved products appear in the Wishlist tab.
- Empty pages for the other tabs can stay unchanged.

## 5) Teaching notes

This is a simple `provider` example because:

- the provider stores the data,
- the UI reads the data,
- the UI does not manage the wishlist list directly,
- `notifyListeners()` updates the screen automatically.

## 6) Student challenge

Ask students to extend the feature by:

- adding a badge count on the Wishlist tab,
- adding a `clearWishlist()` method,
- showing a snackbar when an item is saved or removed,
- adding a remove button on the Wishlist screen.

## Summary

The wishlist works like this:

- store products in `_wishlist`,
- expose them with `wishlistItems`,
- toggle the item from the heart icon,
- rebuild the UI with `notifyListeners()`,
- show saved items in a separate screen.
