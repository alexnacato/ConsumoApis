import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/producto_viewmodels.dart';
import '../../../domain/entities/producto_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<ProductoViewModel>().cargarProductos());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
      ),

      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vm.productos.length,
              itemBuilder: (context, index) {
                final ProductoEntity producto = vm.productos[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(producto.nombre),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Precio: \$${producto.precio}"),
                        Text("Stock: ${producto.stock}"),
                        Text("Categoría: ${producto.categoria}"),
                      ],
                    ),

                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        vm.eliminarProducto(producto.id);
                      },
                    ),

                    // 🔵 TAP para EDITAR usando la misma página
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/productoForm",
                        arguments: producto,
                      );
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // 🟢 CREAR usando la misma página
          Navigator.pushNamed(context, "/productoForm");
        },
      ),
    );
  }
}
