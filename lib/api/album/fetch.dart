import 'package:flutter/material.dart';
import 'package:secondbase/api/album/ayat_view.dart';
import 'package:secondbase/api/album/model/album_api.dart';
import 'package:secondbase/utils/constant/app_color.dart';
import 'package:secondbase/utils/constant/app_image';

import '../repo.dart';

class FetchAlbum extends StatefulWidget {
  @override
  _FetchAlbumState createState() => _FetchAlbumState();
}

class _FetchAlbumState extends State<FetchAlbum> {
  late Future<Album> futureAlbums;
  final AlbumRepository repository = AlbumRepository();

  @override
  void initState() {
    super.initState();
    futureAlbums = repository.fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Quraisyah',
              style: TextStyle(
                fontFamily: "Baloo2",
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: AppColor.secondaryColor,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.keyboard_return, color: AppColor.secondaryColor),
              iconSize: 24.0,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: AppColor.secondaryColor),
                iconSize: 30.0,
                onPressed: () {},
              ),
            ],
          ),

          // Banner Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: AppColor.secondaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Text(
                      "الفاتح",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 40,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  Positioned(
                    right: 20,
                    child: Image.asset(AppImage.intro2, width: 120),
                  ),
                ],
              ),
            ),
          ),

          // Fetch & Display Surah List
          Expanded(
            child: FutureBuilder<Album>(
              future: futureAlbums,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text("No data available"));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.data?.length,
                    itemBuilder: (context, index) {
                      final surah = snapshot.data!.data![index];

                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => AyatView(
                                    nomor: surah.nomor!,
                                    nama: surah.nama!,
                                  ),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundColor: AppColor.secondaryColor,
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                        title: Text(
                          surah.nama ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                        subtitle: Text(
                          "Ayat: ${surah.jumlahAyat} - ${surah.arti}",
                          style: TextStyle(color: AppColor.secondaryColor),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
