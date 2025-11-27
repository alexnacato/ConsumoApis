// Consume la API con http y Future
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'base_datasource.dart';
import '../models/producto_model.dart';

class ProductoApiDataSource implements BaseDataSource {
  final String apiUrl = 'http://localhost:3000/api/productos';

  /* ============================
        GET: Obtener productos
     ============================ */
  @override
  Future<List<ProductoModel>> fetchProductos() async {
    final url = Uri.parse(apiUrl);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load productos');
    }

    final List data = json.decode(response.body);
    return data.map((json) => ProductoModel.fromJson(json)).toList();
  }

  /* ============================
        POST: Crear producto
     ============================ */
  @override
  Future<ProductoModel> createProductos(Map<String, dynamic> data) async {
    final url = Uri.parse(apiUrl);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 201 &&
        response.statusCode != 200) {
      throw Exception('Error al crear producto');
    }

    return ProductoModel.fromJson(json.decode(response.body));
  }

  /* ============================
        DELETE: Eliminar producto
     ============================ */
  @override
  Future<bool> deleteProductos(String id) async {
    final resp = await http.delete(Uri.parse('$apiUrl/$id'));

    return resp.statusCode == 200;
  }

  /* ============================
        PUT: Actualizar producto
     ============================ */
  @override
  Future<ProductoModel> updateProductos(
      String id, Map<String, dynamic> data) async {
    final url = Uri.parse('$apiUrl/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar producto');
    }

    return ProductoModel.fromJson(json.decode(response.body));
  }
}
