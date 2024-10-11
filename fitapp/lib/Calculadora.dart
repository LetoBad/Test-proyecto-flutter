import 'package:fitapp/Alimentos.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatelessWidget {
  final List<Alimento> alimentos;

  const Calculadora({required this.alimentos, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _cantidadController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Alimentos"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          DropdownButton<Alimento>(
            items: alimentos.map((Alimento alimento) {
              return DropdownMenuItem<Alimento>(
                value: alimento,
                child: Text(alimento.nombre),
              );
            }).toList(),
            onChanged: (Alimento? seleccionado) {
              if (seleccionado != null) {
                // Aquí podrías implementar la lógica para seleccionar el alimento
              }
            },
            hint: const Text("Seleccione un alimento"),
          ),
          TextField(
            controller: _cantidadController,
            decoration: const InputDecoration(labelText: "Cantidad (g)"),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            child: const Text("Calcular"),
            onPressed: () {
              // Lógica para calcular el total
            },
          ),
          // Aquí mostrar los resultados
        ],
      ),
    );
  }
}
