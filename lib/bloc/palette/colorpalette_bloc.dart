// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:esercizio_flutter/bloc/palette/api/api_repository.dart';
import 'package:esercizio_flutter/bloc/palette/api/api_status.dart';
import 'package:esercizio_flutter/bloc/palette/colorpalette_event.dart';
import 'package:esercizio_flutter/bloc/palette/colorpalette_state.dart';

class ColorpaletteBloc extends Bloc<ColorpaletteEvent, ColorpaletteState> {
  ColorpaletteBloc() : super(ColorpaletteState()) {
    ApiRepository apiRepository = ApiRepository();
    on<GetColorPalette>((event, emit) async {
      try {
        print('colorPAlette loading');
        emit(state.copyWith(apiStatus: ApiLoading()));
        final paletteList = await apiRepository.fetchPaletteList(state.page!);
        print('colorPAlette loaded');
        print(paletteList);
        
        emit(state.copyWith(palette: paletteList, apiStatus: ApiLoaded()));
        if (paletteList.error != null) {
          print('colorPAlette Error');
          emit(state.copyWith(
              errorMessage: paletteList.error, apiStatus: ApiError()));
        } else {
          print('finish');
        }
      } on NetworkError {
        emit(state.copyWith(
            errorMessage: 'Failed to fetch data. is your device online?',
            apiStatus: ApiError()));
      }
    });
    on<PrevColorPalette>((event, emit) async {
      emit(state.copyWith(apiStatus: ApiLoading()));
      emit(state.copyWith(page: state.page! - 1));
    });
    on<NextColorPalette>((event, emit) async {
      emit(state.copyWith(apiStatus: ApiLoading()));
      emit(state.copyWith(page: state.page! + 1));
    });
  }
}
