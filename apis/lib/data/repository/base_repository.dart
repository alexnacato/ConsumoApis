import '../../domain/entities/producto_entity.dart';


abstract class BaseRepository  {
  Future<List<ProductoEntity>> getProductos();
  Future<ProductoEntity> createProductos(ProductoEntity producto);
  Future<ProductoEntity> updateProductos(String id, ProductoEntity producto);
  Future<bool> deleteProductos(String id);

}