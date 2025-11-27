import '../entities/producto_entity.dart';

import '../../data/repository/base_repository.dart';


class CreateProductosUsecase {
  final BaseRepository repository;

  CreateProductosUsecase(this.repository);

  Future<ProductoEntity> call(ProductoEntity producto) async {
    return await repository.createProductos(producto);
  }
}












