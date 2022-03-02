
class Palette {
  int? id;
  String? name;
  int? year;
  int? color;
  String? pantoneValue;
  String? error;

  Palette(
      {this.id,
      this.name,
      this.year,
      this.color,
      this.pantoneValue,
      this.error});

  Palette.withError(String errorMessage) {
    error = errorMessage;
  }

  factory Palette.fromJson(Map<String, dynamic> json) {
    return Palette(
      id: json['id'],
      name: json['name'],
      year: json['year'],
      color: int.parse(json['color'].replaceAll('#', '0xFF')),
      pantoneValue: json['pantone_value'],
    );
  }
}

class ColorPalette {
  int? page;
  int? perPage;
  int? totalPages;
  List<Palette>? data;
  String? error;

  ColorPalette({
    this.page,
    this.perPage,
    this.totalPages,
    this.data,
    this.error
  });



  ColorPalette.withError(String errorMessage) {
    error = errorMessage;
  }

   ColorPalette.fromJson(Map<String, dynamic> json) {
    if(json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Palette.fromJson(v));
      });
    }
    page = json['page'];
    perPage = json['per_page'];
    totalPages = json['total_pages'];
  }

}


