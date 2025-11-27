import '../entities/producto_entity.dart';

import '../../data/repository/base_repository.dart';


class UpdateProductosUsecase {
  final BaseRepository repository;

  UpdateProductosUsecase(this.repository);

  Future<ProductoEntity> call(String id, ProductoEntity p) async {
    return await repository.updateProductos(id, p);
  }
}












