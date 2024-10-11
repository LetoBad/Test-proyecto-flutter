import 'package:fitapp/Alimentos.dart';
import 'package:flutter/material.dart';

class ListaDeAlimentos extends StatefulWidget {
  final List<Alimento> alimentos;
  final Function(Alimento) onInsert;
  final Function(int) onRemove;

  const ListaDeAlimentos({
    required this.alimentos,
    required this.onInsert,
    required this.onRemove,
    super.key,
  });

  @override
  State<ListaDeAlimentos> createState() => _ListaDeAlimentosState();
}

class _ListaDeAlimentosState extends State<ListaDeAlimentos> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _caloriasController = TextEditingController();
  final TextEditingController _carbohidratosController =
      TextEditingController();
  final TextEditingController _proteinasController = TextEditingController();
  final TextEditingController _grasasController = TextEditingController();

  void openModal(BuildContext scaffoldContext) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: Column(
            children: [
              TextField(
                decoration:
                    const InputDecoration(labelText: "Nombre del Alimento"),
                controller: _nombreController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Calorías"),
                controller: _caloriasController,
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: "Carbohidratos (g)"),
                controller: _carbohidratosController,
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Proteínas (g)"),
                controller: _proteinasController,
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Grasas (g)"),
                controller: _grasasController,
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                child: const Text("Salvar"),
                onPressed: () {
                  final String nombre = _nombreController.text;
                  final double? calorias =
                      double.tryParse(_caloriasController.text);
                  final double? carbohidratos =
                      double.tryParse(_carbohidratosController.text);
                  final double? proteinas =
                      double.tryParse(_proteinasController.text);
                  final double? grasas =
                      double.tryParse(_grasasController.text);

                  if (nombre.isNotEmpty &&
                      calorias != null &&
                      carbohidratos != null &&
                      proteinas != null &&
                      grasas != null) {
                    widget.onInsert(Alimento(
                      nombre: nombre,
                      calorias: calorias,
                      carbohidratos: carbohidratos,
                      proteinas: proteinas,
                      grasas: grasas,
                    ));

                    _nombreController.clear();
                    _caloriasController.clear();
                    _carbohidratosController.clear();
                    _proteinasController.clear();
                    _grasasController.clear();

                    Navigator.pop(context);
                    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                      const SnackBar(
                          content: Text("Alimento agregado con éxito!")),
                    );
                  } else {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                      const SnackBar(
                          content: Text(
                              "Por favor, complete todos los campos correctamente.")),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Alimentos"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.alimentos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.alimentos[index].nombre),
            subtitle: Text("Calorías: ${widget.alimentos[index].calorias} | "
                "Carbohidratos: ${widget.alimentos[index].carbohidratos}g | "
                "Proteínas: ${widget.alimentos[index].proteinas}g | "
                "Grasas: ${widget.alimentos[index].grasas}g"),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => widget.onRemove(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModal(context);
        },
        backgroundColor: Colors.lightGreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
