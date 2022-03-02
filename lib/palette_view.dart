import 'package:esercizio_flutter/bloc/palette/api/api_status.dart';
import 'package:esercizio_flutter/bloc/palette/colorpalette_bloc.dart';
import 'package:esercizio_flutter/bloc/palette/colorpalette_state.dart';
import 'package:esercizio_flutter/bloc/palette/colorpalette_event.dart';
import 'package:esercizio_flutter/model/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaletteView extends StatelessWidget {
  PaletteView({Key? key}) : super(key: key);

  final ColorpaletteBloc _newBloc = ColorpaletteBloc();

  Widget _colorPalette() {
    return BlocListener<ColorpaletteBloc, ColorpaletteState>(
        listener: (context, state) {
      if (state.apiStatus is ApiError) {
        _snackBar(context, state.errorMessage!);
      }
    }, child: BlocBuilder<ColorpaletteBloc, ColorpaletteState>(
            builder: (context, state) {
      if (state.apiStatus is InitialApi) {
        return _buildLoading();
      } else if (state.apiStatus is ApiLoading) {
        return _buildLoading();
      } else if (state.apiStatus is ApiLoaded) {
        return _buildPalette(context, state.palette!);
      } else if (state.apiStatus is ApiError) {
        return _errorTryReload(context);
      } else {
        return _errorTryReload(context);
      }
    }));
  }

  Widget _errorTryReload(context){
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return RefreshIndicator(
          onRefresh: () => _refresh(),
          child: ListView(
            padding: EdgeInsets.only(top: height * 0.5),
            children: <Widget>[ Center(child: Text('Scoll down to realod', style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.4))),)]
          ));
  }


  void _colorDetails(BuildContext context, Palette color) {
    var size = MediaQuery.of(context).size;
    var width = size.width;

    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              _detailContainer(200, width * 0.5, color.color),
              const Spacer(flex: 10),
              _detailContainer(200, width * 0.8, null, color),
              const Spacer(flex: 10),
            ],
          );
        });
  }

  Widget _detailContainer(double? height, double? width,
      [int? backgroundcolor, Palette? color]) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(backgroundcolor ?? 0xFFFFFFFF),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: color != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    _detailText('Id', color.id.toString()),
                    _detailText('Name', color.name!),
                    _detailText('Year', color.year.toString()),
                    _detailText('Color', color.color.toString()),
                    _detailText('Pantone Value', color.pantoneValue!),
                  ])
            : Container(),
      ),
    );
  }

  Widget _detailText(String? name, String? value) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(
        '$name: ',
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      Text(
        '$value',
        style: const TextStyle(fontSize: 20.0),
      )
    ]);
  }

  Future<void> _refresh() async {
    _newBloc.add(GetColorPalette());
  }

  Widget _buildPalette(BuildContext context, ColorPalette colorPalette) {
    return Column(
      children: <Widget>[
        const Padding(
          padding:  EdgeInsets.fromLTRB(0,30,0,0),
          child:  Text(
                          'Color Palette',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
        ),
         Expanded(child: _buildCard(context, colorPalette)),
        _changePage(context, colorPalette)
      ]
    );
  }

  Widget _changePage(BuildContext context, ColorPalette colorPalette){
    return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              colorPalette.page == 1 ? Container() : ElevatedButton(onPressed: (){_newBloc.add(PrevColorPalette()); _newBloc.add(GetColorPalette());}, child: const Text('previous page')),
              Text(colorPalette.page.toString(), style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              colorPalette.page == colorPalette.totalPages ? Container() : ElevatedButton(onPressed: (){_newBloc.add(NextColorPalette()); _newBloc.add(GetColorPalette());}, child: const Text('next page')),
            ]
          ),
        );
  }

  Widget _buildCard(BuildContext context, ColorPalette colorPalette) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: colorPalette.data!.length,
        itemBuilder: (BuildContext ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                _colorDetails(context, colorPalette.data![index]);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(colorPalette.data![index].color!),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          );
        });
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    _newBloc.add(GetColorPalette());
    return Scaffold(
        body: BlocProvider<ColorpaletteBloc>(
            create: (_) => _newBloc, child: _colorPalette()));
  }

  void _snackBar(BuildContext context, String message) {
    final snakBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snakBar);
  }
}
