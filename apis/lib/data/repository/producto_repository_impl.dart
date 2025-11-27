import '../../domain/entities/producto_entity.dart';
import '../datasource/base_datasource.dart';
import '../models/producto_model.dart';
import 'base_repository.dart';

class ProductoRepositoryImpl implements BaseRepository {
  final BaseDataSource dataSource;

  ProductoRepositoryImpl(this.dataSource);

  @override
  Future<List<ProductoEntity>> getProductos() async {
   return dataSource.fetchProductos();
  }
  
  @override
  Future<ProductoEntity> createProductos(ProductoEntity producto) {
   return dataSource.createProductos({
      'nombre': producto.nombre,
      'precio': producto.precio,
      'stock': producto.stock,
      'categoria': producto.categoria,
   });
  }
  
  @override
  Future<bool> deleteProductos(String id) {
    return dataSource.deleteProductos(id);
  }
  
  @override
  Future<ProductoEntity> updateProductos(String id, ProductoEntity producto) {
       return dataSource.updateProductos(id,{
    'nombre': producto.nombre,
      'precio': producto.precio,
      'stock': producto.stock,
      'categoria': producto.categoria,
   });
  }
}






























































