class Zikir {
  final int? id;
  final String jenis;
  final int jumlah;
  final String pesan;

  Zikir({
    this.id,
    required this.jenis,
    required this.jumlah,
    required this.pesan,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'jenis': jenis, 'jumlah': jumlah, 'pesan': pesan};
  }

  factory Zikir.fromMap(Map<String, dynamic> map) {
    return Zikir(
      id: map['id'],
      jenis: map['jenis'],
      jumlah: map['jumlah'],
      pesan: map['pesan'],
    );
  }
}
