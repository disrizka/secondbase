import 'package:flutter/material.dart';
import 'package:secondbase/pages/dzikir/database/zikir_database.dart';
import 'package:secondbase/pages/dzikir/model/zikir_model.dart';
import 'package:secondbase/utils/constant/app_color.dart';

class TambahZikirScreen extends StatefulWidget {
  @override
  _TambahZikirScreenState createState() => _TambahZikirScreenState();
}

class _TambahZikirScreenState extends State<TambahZikirScreen> {
  final jenisController = TextEditingController();
  final jumlahController = TextEditingController();
  final pesanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor.withOpacity(0.8),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(24),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Tambah Zikir",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: jenisController,
                  decoration: InputDecoration(labelText: 'Jenis Zikir'),
                ),
                TextField(
                  controller: jumlahController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Jumlah'),
                ),
                TextField(
                  controller: pesanController,
                  decoration: InputDecoration(labelText: 'Pesan'),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Batal"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondaryColor,
                      ),
                      onPressed: () async {
                        if (jenisController.text.isNotEmpty &&
                            jumlahController.text.isNotEmpty) {
                          final zikir = Zikir(
                            jenis: jenisController.text,
                            jumlah: int.parse(jumlahController.text),
                            pesan: pesanController.text,
                          );
                          await ZikirDatabase.instance.insertZikir(zikir);
                          Navigator.pop(context, true);
                        }
                      },
                      child: Text("Simpan"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
