import 'package:flutter/material.dart';
import 'model_menu.dart';
import 'halaman_ringkasan.dart';

// TAMPILAN 2: Form pemesanan
// (Form Field, Slider, Radio, Checkbox, Switch, Date Picker)
class HalamanPesan extends StatefulWidget {
  final MenuKopi menu;
  const HalamanPesan({super.key, required this.menu});

  @override
  State<HalamanPesan> createState() => _HalamanPesanState();
}

class _HalamanPesanState extends State<HalamanPesan> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();

  double _jumlah = 1;
  String _ukuran = 'Sedang';
  bool _extraShot = false;
  bool _whippedCream = false;
  bool _bawaPulang = false;
  DateTime _tanggal = DateTime.now();

  static const Map<String, int> _hargaUkuran = {
    'Kecil': 0,
    'Sedang': 3000,
    'Besar': 6000,
  };

  int get _total {
    int satuan = widget.menu.harga + _hargaUkuran[_ukuran]!;
    if (_extraShot) satuan += 4000;
    if (_whippedCream) satuan += 3000;
    return satuan * _jumlah.round();
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (hasil != null) setState(() => _tanggal = hasil);
  }

  void _kirim() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HalamanRingkasan(
          menu: widget.menu,
          nama: _namaCtrl.text.trim(),
          jumlah: _jumlah.round(),
          ukuran: _ukuran,
          toppings: [
            if (_extraShot) 'Extra shot',
            if (_whippedCream) 'Whipped cream',
          ],
          bawaPulang: _bawaPulang,
          tanggal: _tanggal,
          total: _total,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.menu;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan ${m.nama}'),
        backgroundColor: m.warna,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _namaCtrl,
              decoration: const InputDecoration(
                labelText: 'Nama pemesan',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
            ),
            const SizedBox(height: 20),
            Text('Jumlah: ${_jumlah.round()} gelas',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _jumlah,
              min: 1,
              max: 10,
              divisions: 9,
              label: _jumlah.round().toString(),
              onChanged: (v) => setState(() => _jumlah = v),
            ),
            const Text('Ukuran',
                style: TextStyle(fontWeight: FontWeight.bold)),
            RadioGroup<String>(
              groupValue: _ukuran,
              onChanged: (v) => setState(() => _ukuran = v!),
              child: Column(
                children: _hargaUkuran.entries
                    .map((e) => RadioListTile<String>(
                          value: e.key,
                          title: Text(e.key),
                          subtitle: Text(e.value == 0
                              ? 'Harga normal'
                              : '+ ${formatRupiah(e.value)}'),
                          dense: true,
                        ))
                    .toList(),
              ),
            ),
            const Text('Tambahan',
                style: TextStyle(fontWeight: FontWeight.bold)),
            CheckboxListTile(
              value: _extraShot,
              onChanged: (v) => setState(() => _extraShot = v!),
              title: const Text('Extra shot'),
              subtitle: const Text('+ Rp 4.000'),
              dense: true,
            ),
            CheckboxListTile(
              value: _whippedCream,
              onChanged: (v) => setState(() => _whippedCream = v!),
              title: const Text('Whipped cream'),
              subtitle: const Text('+ Rp 3.000'),
              dense: true,
            ),
            SwitchListTile(
              value: _bawaPulang,
              onChanged: (v) => setState(() => _bawaPulang = v),
              title: const Text('Bawa pulang'),
              secondary: const Icon(Icons.shopping_bag),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Tanggal ambil'),
              subtitle: Text(
                  '${_tanggal.day}/${_tanggal.month}/${_tanggal.year}'),
              trailing: const Icon(Icons.edit_calendar),
              onTap: _pilihTanggal,
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 18)),
                Text(
                  formatRupiah(_total),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _kirim,
              icon: const Icon(Icons.check),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Pesan Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
