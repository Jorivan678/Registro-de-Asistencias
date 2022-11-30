import 'package:shared_preferences/shared_preferences.dart';

class PrefUser {
  static final PrefUser _instancia = PrefUser._internal();

  factory PrefUser() {
    return _instancia;
  }

  PrefUser._internal();

  //Con null safety debe llevar "late" antes de SharedPreferences _prefs
  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  set nombreUsuario(String sFolio) {
    _prefs.setString('nombre_usuario', sFolio);
  }

  String get nombreUsuario {
    return _prefs.getString('nombre_usuario') ?? '';
  }

  set folioUsuario(String sFolio) {
    _prefs.setString('folio_usuario', sFolio);
  }

  String get folioUsuario {
    return _prefs.getString('folio_usuario') ?? '';
  }

  set inicioSesion(bool value) {
    _prefs.setBool('inicioSesion', value);
  }

  bool get inicioSesion {
    return _prefs.getBool('inicioSesion') ?? false;
  }
}
