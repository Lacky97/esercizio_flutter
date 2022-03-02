import 'package:esercizio_flutter/bloc/api_status.dart';
import 'package:esercizio_flutter/model/color_palette.dart';

class ColorpaletteState {
  final int? page;
  final ColorPalette? palette;
  final String? errorMessage;
  final ApiStatus? apiStatus;

  ColorpaletteState({this.page = 1, this.palette, this.errorMessage = '', this.apiStatus = const InitialApi()});

  ColorpaletteState copyWith({
    int? page,
    ColorPalette? palette,
    String? errorMessage,
    ApiStatus? apiStatus
  }) {
    return ColorpaletteState(
      page: page ?? this.page,
      palette: palette ?? this.palette,
      errorMessage: errorMessage ?? this.errorMessage,
      apiStatus: apiStatus ?? this.apiStatus
    );
  }
}
