import 'package:flutter/material.dart';
import 'package:secondbase/pages/dzikir/database/zikir_database.dart';
import 'package:secondbase/pages/dzikir/model/zikir_model.dart';
import 'package:secondbase/utils/constant/app_color.dart';
import 'tambah_zikir_screen.dart';

class ZikirScreen extends StatefulWidget {
  @override
  _ZikirScreenState createState() => _ZikirScreenState();
}

class _ZikirScreenState extends State<ZikirScreen> {
  List<Zikir> zikirList = [];

  @override
  void initState() {
    super.initState();
    fetchZikir();
  }

  Future<void> fetchZikir() async {
    final data = await ZikirDatabase.instance.getAllZikir();
    setState(() {
      zikirList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
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
      
      body: ListView.builder(
        itemCount: zikirList.length,
        itemBuilder: (context, index) {
          final zikir = zikirList[index];
          return Card(
            margin: EdgeInsets.all(10),
            color: Colors.white, 
            child: ListTile(
              title: Text(
                zikir.jenis,
                style: TextStyle(
                  color: AppColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${zikir.jumlah} kali\n${zikir.pesan}",
                style: TextStyle(color: AppColor.secondaryColor),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: AppColor.secondaryColor),
                onPressed: () async {
                  await ZikirDatabase.instance.deleteZikir(zikir.id!);
                  fetchZikir();
                },
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.secondaryColor,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahZikirScreen()),
          );
          if (result == true) {
            fetchZikir();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
