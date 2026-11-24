import 'package:flutter/material.dart';

class MenuKopi {
  final String nama;
  final String deskripsi;
  final int harga;
  final IconData ikon;
  final Color warna;

  const MenuKopi({
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.ikon,
    required this.warna,
  });
}

const List<MenuKopi> daftarMenu = [
  MenuKopi(
    nama: 'Espresso',
    deskripsi: 'Kopi pekat dan kuat',
    harga: 15000,
    ikon: Icons.coffee,
    warna: Color(0xFF6D4C41),
  ),
  MenuKopi(
    nama: 'Cappuccino',
    deskripsi: 'Espresso dengan susu berbusa',
    harga: 22000,
    ikon: Icons.local_cafe,
    warna: Color(0xFF8D6E63),
  ),
  MenuKopi(
    nama: 'Latte',
    deskripsi: 'Lembut dan creamy',
    harga: 24000,
    ikon: Icons.coffee_maker,
    warna: Color(0xFFA1887F),
  ),
  MenuKopi(
    nama: 'Es Kopi Susu',
    deskripsi: 'Segar, manis, favorit semua',
    harga: 18000,
    ikon: Icons.icecream,
    warna: Color(0xFF5D4037),
  ),
];

String formatRupiah(int angka) {
  final s = angka.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp $buf';
}
