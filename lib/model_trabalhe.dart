import 'package:file_picker/file_picker.dart';

class DataUsers {
  final String nome;
  final String email;
  final String telefone;
  final String funcaoEsc;
  final PlatformFile? image;
  final String conteSobreVoce;

  DataUsers({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.funcaoEsc,
    this.image,
    required this.conteSobreVoce,
  });

  Map<String, String> toFields() {
    return {
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'funcaoEsc': funcaoEsc,
      'conteSobreVoce': conteSobreVoce,
    };
  }

  Map<String, PlatformFile>? get files {
    if (image == null) return null;
    return {'image': image!}; // ✔ nome compatível com o backend
  }
}
