import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/aura_app.dart';
import 'provider/product_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductProvider())],
      child: const AuraApp(),
    ),
  );
}
