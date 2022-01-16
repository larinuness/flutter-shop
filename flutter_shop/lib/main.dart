import 'package:flutter/material.dart';
import 'models/order_list_model.dart';
import 'package:provider/provider.dart';

import 'models/cart_model.dart';
import 'models/product_list_model.dart';
import 'pages/cart_page.dart';
import 'pages/order_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/product_form_page.dart';
import 'pages/products_page.dart';
import 'pages/products_overview_page.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //pra testar o componente inheritedWidget colocar o "return CounterProvider"
    //quando tiver apenas um provider usar = return ChangeNotifierProvider
    //quando mais que um, usar o multiprovider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //cria uma lista de produtos
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          //cria um carrinho
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          //cria um pedidop
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
              .copyWith(secondary: Colors.deepOrange),
        ),
        // home: const ProductsOverviewPage(),
        routes: {
          AppRoutes.productDetail: (context) => const ProductDetailPage(),
          AppRoutes.cart: (context) => const CartPage(),
          AppRoutes.home: (context) => const ProductsOverviewPage(),
          AppRoutes.orders: (context) => const OrderPage(),
          AppRoutes.products: (context) => const ProductsPage(),
          AppRoutes.productsForm: (context) => const ProductFormPage(),
        },
      ),
    );
  }
}
