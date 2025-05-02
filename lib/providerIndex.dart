import 'package:flutter/material.dart';

class IndexProvider with ChangeNotifier {
  // Inicializando o índice com 0
  int _selectedIndex = 0; // Começar com o índice 0 selecionado

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners(); // Notifica todos os widgets que estão ouvindo
    }
  }
}
