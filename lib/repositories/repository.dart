import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Repository {
  Future<Map> getDados() async {
    final Uri uri = Uri.https(
        "api.hgbrasil.com", "/finance", {"key": loadAsset().toString()});
    final resultado = await http.get(uri);
    //print("Codigo de status: ${resultado.statusCode}");
    return json.decode(resultado.body);
  }
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('../../../key.txt');
}
