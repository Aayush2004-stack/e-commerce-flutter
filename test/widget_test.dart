import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:my_app/app/aura_app.dart';
import 'package:my_app/provider/product_provider.dart';

void main() {
  testWidgets('App loads the home shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ProductProvider())],
        child: const AuraApp(),
      ),
    );

    expect(find.text('Home'), findsWidgets);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
