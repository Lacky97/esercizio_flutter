

import 'package:esercizio_flutter/model/color_palette.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiProvider {
  Future<ColorPalette> fetchPaletteList(int page) async {
    try{
      // Richiesta http all'api
      final response = await http
        .get(Uri.parse('https://reqres.in/api/unknown?page=$page'));

    if (response.statusCode == 200) {
      // Se l'api ritorna 200 OK
      // allora possiamo fare il parsing del json
      return ColorPalette.fromJson(jsonDecode(response.body));
    } else {
      // Se l'api non ritorna 200 ok
      // Setto l'errore di ColorPalette
      return ColorPalette.withError('Failed to load palette');
    }
    } catch (e) {
      // Se rispontriamo errori durante la chiamata http
      // Setto l'errore di ColorPalette
      return ColorPalette.withError('Connection Error');
    }
  }
}
