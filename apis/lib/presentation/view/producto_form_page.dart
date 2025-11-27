import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/producto_viewmodels.dart';
import '../../../domain/entities/producto_entity.dart';

class ProductoFormPage extends StatefulWidget {
  const ProductoFormPage({super.key});

  @override
  State<ProductoFormPage> createState() => _ProductoFormPageState();
}

class _ProductoFormPageState extends State<ProductoFormPage> {
  final _formKey = GlobalKey<FormState>();

  final nombreCtrl = TextEditingController();
  final precioCtrl = TextEditingController();
  final stockCtrl = TextEditingController();
  final categoriaCtrl = TextEditingController();

  ProductoEntity? productoEditar;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    productoEditar = ModalRoute.of(context)!.settings.arguments as ProductoEntity?;

    if (productoEditar != null) {
      nombreCtrl.text = productoEditar!.nombre;
      precioCtrl.text = productoEditar!.precio.toString();
      stockCtrl.text = productoEditar!.stock.toString();
      categoriaCtrl.text = productoEditar!.categoria;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(productoEditar == null ? "Crear Producto" : "Editar Producto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nombreCtrl,
                decoration: const InputDecoration(labelText: "Nombre"),
                validator: (v) => v!.isEmpty ? "Ingrese un nombre" : null,
              ),

              TextFormField(
                controller: precioCtrl,
                decoration: const InputDecoration(labelText: "Precio"),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Ingrese un precio" : null,
              ),

              TextFormField(
                controller: stockCtrl,
                decoration: const InputDecoration(labelText: "Stock"),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Ingrese stock" : null,
              ),

              TextFormField(
                controller: categoriaCtrl,
                decoration: const InputDecoration(labelText: "Categoría"),
                validator: (v) => v!.isEmpty ? "Ingrese una categoría" : null,
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final double precio = double.tryParse(precioCtrl.text) ?? 0;
                  final int stock = int.tryParse(stockCtrl.text) ?? 0;

                  if (productoEditar == null) {
                    // CREAR
                    final nuevo = ProductoEntity(
                      id: "",
                      nombre: nombreCtrl.text,
                      precio: precio,
                      stock: stock,
                      categoria: categoriaCtrl.text,
                    );
                    await vm.agregarProducto(nuevo);

                  } else {
                    // EDITAR
                    final actualizado = ProductoEntity(
                      id: productoEditar!.id,
                      nombre: nombreCtrl.text,
                      precio: precio,
                      stock: stock,
                      categoria: categoriaCtrl.text,
                    );
                    await vm.actualizarProducto(productoEditar!.id, actualizado);
                  }

                  Navigator.pop(context);
                },
                child: Text(productoEditar == null ? "Guardar" : "Actualizar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
