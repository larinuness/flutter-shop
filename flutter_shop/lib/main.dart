import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product_list.dart';
import 'package:provider/provider.dart';
import 'pages/products_overview_page.dart';
import 'utils/app_routes.dart';

import 'pages/product_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //pra testar o componente inheritedWidget colocar o "return CounterProvider"
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
        ),
        home: ProductsOverviewPage(),
        routes: {
          AppRoutes.productDetail: (context) => const ProductDetailPage(),
        },
      ),
    );
  }
}
