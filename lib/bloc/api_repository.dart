
import 'package:esercizio_flutter/bloc/api_provider.dart';
import 'package:esercizio_flutter/model/color_palette.dart';

class ApiRepository{
  final _provider = ApiProvider();

  Future<ColorPalette> fetchPaletteList(int page){
    return _provider.fetchPaletteList(page);
  }
}

class NetworkError extends Error{}