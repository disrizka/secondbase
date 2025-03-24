import 'dart:convert';

Album albumFromJson(String str) => Album.fromJson(json.decode(str));
String albumToJson(Album data) => json.encode(data.toJson());

class Album {
  int? code;
  String? message;
  List<Datum>? data;

  Album({this.code, this.message, this.data});

  Album copyWith({int? code, String? message, List<Datum>? data}) => Album(
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    code: json["code"],
    message: json["message"],
    data:
        json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data":
        data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : [],
  };
}

class Datum {
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  TempatTurun? tempatTurun;
  String? arti;
  String? deskripsi;
  Map<String, String>? audioFull;
  List<Ayat>? ayat; // Tambahan field ayat

  Datum({
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audioFull,
    this.ayat,
  });

  Datum copyWith({
    int? nomor,
    String? nama,
    String? namaLatin,
    int? jumlahAyat,
    TempatTurun? tempatTurun,
    String? arti,
    String? deskripsi,
    Map<String, String>? audioFull,
    List<Ayat>? ayat,
  }) => Datum(
    nomor: nomor ?? this.nomor,
    nama: nama ?? this.nama,
    namaLatin: namaLatin ?? this.namaLatin,
    jumlahAyat: jumlahAyat ?? this.jumlahAyat,
    tempatTurun: tempatTurun ?? this.tempatTurun,
    arti: arti ?? this.arti,
    deskripsi: deskripsi ?? this.deskripsi,
    audioFull: audioFull ?? this.audioFull,
    ayat: ayat ?? this.ayat,
  );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    nomor: json["nomor"],
    nama: json["nama"],
    namaLatin: json["namaLatin"],
    jumlahAyat: json["jumlahAyat"],
    tempatTurun:
        tempatTurunValues.map[json["tempatTurun"]] ?? TempatTurun.MEKAH,
    arti: json["arti"],
    deskripsi: json["deskripsi"],
    audioFull:
        json["audioFull"] != null
            ? Map<String, String>.from(json["audioFull"])
            : {},
    ayat:
        json["ayat"] != null
            ? List<Ayat>.from(json["ayat"].map((x) => Ayat.fromJson(x)))
            : null,
  );

  Map<String, dynamic> toJson() => {
    "nomor": nomor,
    "nama": nama,
    "namaLatin": namaLatin,
    "jumlahAyat": jumlahAyat,
    "tempatTurun": tempatTurunValues.reverse[tempatTurun],
    "arti": arti,
    "deskripsi": deskripsi,
    "audioFull":
        audioFull != null
            ? Map.from(
              audioFull!,
            ).map((k, v) => MapEntry<String, dynamic>(k, v))
            : {},
    "ayat":
        ayat != null ? List<dynamic>.from(ayat!.map((x) => x.toJson())) : null,
  };
}

enum TempatTurun { MADINAH, MEKAH }

final tempatTurunValues = EnumValues({
  "Madinah": TempatTurun.MADINAH,
  "Mekah": TempatTurun.MEKAH,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

// Class Ayat
class Ayat {
  int? nomorAyat;
  String? teksArab;
  String? teksLatin;
  String? teksIndonesia;

  Ayat({this.nomorAyat, this.teksArab, this.teksLatin, this.teksIndonesia});

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
    nomorAyat: json["nomorAyat"],
    teksArab: json["teksArab"],
    teksLatin: json["teksLatin"],
    teksIndonesia: json["teksIndonesia"],
  );

  Map<String, dynamic> toJson() => {
    "nomorAyat": nomorAyat,
    "teksArab": teksArab,
    "teksLatin": teksLatin,
    "teksIndonesia": teksIndonesia,
  };
}
