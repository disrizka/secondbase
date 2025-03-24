import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:secondbase/utils/app_color.dart';

class AyatView extends StatelessWidget {
  final int nomor;
  final String nama;

  const AyatView({Key? key, required this.nomor, required this.nama})
    : super(key: key);

  Future<List<dynamic>> fetchAyat() async {
    final response = await http.get(
      Uri.parse('https://equran.id/api/surat/$nomor'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['ayat'];
    } else {
      throw Exception('Gagal memuat ayat');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          nama,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColor.secondaryColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_return_outlined,
            color: AppColor.secondaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColor.secondaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchAyat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: TextStyle(color: AppColor.secondaryColor),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Tidak ada ayat.",
                style: TextStyle(color: AppColor.secondaryColor),
              ),
            );
          } else {
            final ayatList = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ayatList.length,
              itemBuilder: (context, index) {
                final ayat = ayatList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white.withOpacity(0.08),
                  shadowColor: const Color.fromARGB(
                    255,
                    164,
                    225,
                    253,
                  ).withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Teks Arab (kanan ke kiri)
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            ayat['ar'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.secondaryColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            ayat['idn'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.secondaryColor,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
