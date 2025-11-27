import '../entities/producto_entity.dart';

import '../../data/repository/base_repository.dart';


class DeleteProductosUsecase {
  final BaseRepository repository;

  DeleteProductosUsecase(this.repository);

  Future<bool> call(String id) async {
    return await repository.deleteProductos(id);
  }
}












