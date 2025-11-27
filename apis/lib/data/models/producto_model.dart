//Concxion del http 
import '../../domain/entities/producto_entity.dart';

class ProductoModel extends ProductoEntity {
  ProductoModel({
    required super.id,
    required super.nombre,
    required super.precio,
    required super.stock,
    required super.categoria,
    
  });

  //Conertir de json a objeto para mostrar los datos

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['_id'] ,
      nombre: json['nombre'] ,
      precio: (json['precio']),
      stock: json['stock'] ,
      categoria: json['categoria'] ,
    );
  }
}