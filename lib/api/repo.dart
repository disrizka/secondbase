import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:secondbase/api/album/model/album_api.dart';
import 'endpoint.dart';

class AlbumRepository {
  Future<Album> fetchAlbums() async {
    final response = await http.get(Uri.parse("${Endpoint.baseUrl}/surat"));

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<Datum> fetchAyat(int nomor) async {
    final response = await http.get(
      Uri.parse("${Endpoint.baseUrl}/surat/$nomor"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Datum.fromJson(data);
    } else {
      throw Exception("Failed to load surah detail");
    }
  }
}
