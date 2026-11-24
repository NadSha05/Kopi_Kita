import 'package:flutter/material.dart';
import 'model_menu.dart';

// TAMPILAN 3: Ringkasan / struk pesanan
class HalamanRingkasan extends StatelessWidget {
  final MenuKopi menu;
  final String nama;
  final int jumlah;
  final String ukuran;
  final List<String> toppings;
  final bool bawaPulang;
  final DateTime tanggal;
  final int total;

  const HalamanRingkasan({
    super.key,
    required this.menu,
    required this.nama,
    required this.jumlah,
    required this.ukuran,
    required this.toppings,
    required this.bawaPulang,
    required this.tanggal,
    required this.total,
  });

  Widget _baris(String label, String nilai) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.black54)),
            const SizedBox(width: 16),
            Flexible(
              child: Text(nilai,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Berhasil'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 8),
            Text('Terima kasih, $nama!',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _baris('Menu', menu.nama),
                    _baris('Jumlah', '$jumlah gelas'),
                    _baris('Ukuran', ukuran),
                    _baris('Tambahan',
                        toppings.isEmpty ? '-' : toppings.join(', ')),
                    _baris('Jenis', bawaPulang ? 'Bawa pulang' : 'Minum di tempat'),
                    _baris('Tanggal',
                        '${tanggal.day}/${tanggal.month}/${tanggal.year}'),
                    const Divider(),
                    _baris('TOTAL', formatRupiah(total)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                icon: const Icon(Icons.home),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Kembali ke Beranda'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
