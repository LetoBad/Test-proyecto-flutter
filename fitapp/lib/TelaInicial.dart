import 'package:fitapp/Alimentos.dart';
import 'package:fitapp/Calculadora.dart';
import 'package:fitapp/ListaDeAlimentos.dart';
import 'package:flutter/material.dart';

class Telainicial extends StatefulWidget {
  const Telainicial({super.key});

  @override
  State<Telainicial> createState() => _TelainicialState();
}

class _TelainicialState extends State<Telainicial> {
  int _indexSelecionado = 0;

  final List<Alimento> _alimentos = [];

  void _itemSelecionado(int index) {
    setState(() {
      _indexSelecionado = index;
    });
  }

  void _delAlimento(int index) {
    setState(() {
      _alimentos.removeAt(index);
    });
  }

  void _insAlimento(Alimento newAlimento) {
    setState(() {
      _alimentos.add(newAlimento);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      Calculadora(
        alimentos: _alimentos,
      ),
      ListaDeAlimentos(
        alimentos: _alimentos,
        onRemove: _delAlimento,
        onInsert: _insAlimento,
      ),
    ];

    return Scaffold(
      body: Center(
        child: widgetOptions[_indexSelecionado],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Cálculo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Alimentos',
          ),
        ],
        currentIndex: _indexSelecionado,
        selectedItemColor: Colors.lightGreen,
        onTap: _itemSelecionado,
      ),
    );
  }
}
