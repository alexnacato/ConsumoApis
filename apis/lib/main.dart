import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasource/producto_api_datasource.dart';
import 'data/repository/producto_repository_impl.dart';

// Usecases
import 'domain/usecase/get_productos_usecase.dart';
import 'domain/usecase/create_productos_usecase.dart';
import 'domain/usecase/update_productos_usecase.dart';
import 'domain/usecase/delete_productos_usecase.dart';

import 'presentation/viewmodels/producto_viewmodels.dart';
import 'presentation/routes/app_routes.dart';

void main() {
  // Inyección de dependencias
  final dataSource = ProductoApiDataSource();
  final repo = ProductoRepositoryImpl(dataSource);

  // Crear las 4 usecases que necesita el ViewModel
  final getUsecase = GetProductosUseCase(repo);
  final createUsecase = CreateProductosUsecase(repo);
  final updateUsecase = UpdateProductosUsecase(repo);
  final deleteUsecase = DeleteProductosUsecase(repo);

  runApp(MyApp(
    getUsecase: getUsecase,
    createUsecase: createUsecase,
    updateUsecase: updateUsecase,
    deleteUsecase: deleteUsecase,
  ));
}

class MyApp extends StatelessWidget {
  final GetProductosUseCase getUsecase;
  final CreateProductosUsecase createUsecase;
  final UpdateProductosUsecase updateUsecase;
  final DeleteProductosUsecase deleteUsecase;

  const MyApp({
    super.key,
    required this.getUsecase,
    required this.createUsecase,
    required this.updateUsecase,
    required this.deleteUsecase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductoViewModel(
            getUsecase,
            createUsecase,
            updateUsecase,
            deleteUsecase,
          )..cargarProductos(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Consumo API Flutter",
        routes: AppRoutes.routes,
        initialRoute: "/",
      ),
    );
  }
}
