import 'package:apis/domain/usecase/create_productos_usecase.dart';
import 'package:apis/domain/usecase/delete_productos_usecase.dart';
import 'package:apis/domain/usecase/update_productos_usecase.dart';

import '../../domain/entities/producto_entity.dart';
import '../../domain/usecase/get_productos_usecase.dart';
import 'base_viewmodels.dart';

class ProductoViewModel extends BaseViewModel {
  final GetProductosUseCase usecase;
  final CreateProductosUsecase createUsecase;
  final UpdateProductosUsecase updateUsecase;
  final DeleteProductosUsecase deleteUsecase;


  List<ProductoEntity> productos = [];

  ProductoViewModel(this.usecase, this.createUsecase, this.updateUsecase, this.deleteUsecase);

  Future<void> cargarProductos() async {
    setLoading(true);
    productos = await usecase();
    setLoading(false);
  }
  Future<void> agregarProducto(ProductoEntity producto) async {
    
    await createUsecase(producto);
    await cargarProductos();
   
  }
  Future<void> actualizarProducto(String id, ProductoEntity producto) async {
   
    await updateUsecase(id, producto);
    await cargarProductos();
    
  }
  Future<void> eliminarProducto(String id) async {
    
    await deleteUsecase(id);
    await cargarProductos();
    
  }
}
