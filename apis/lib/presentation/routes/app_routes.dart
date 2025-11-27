import 'package:flutter/material.dart';
import '../view/home_pages.dart';
import '../view/producto_form_page.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    "/": (context) => const HomePage(),


    "/productoForm": (context) => const ProductoFormPage(),
  };
}
