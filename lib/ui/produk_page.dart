import 'package:flutter/material.dart';
import '../model/produk.dart';
import 'produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  final List<Produk> _listProduk = [
    Produk(id: 1, kodeProduk: 'A001', namaProduk: 'Kamera', hargaProduk: 5000000),
    Produk(id: 2, kodeProduk: 'A002', namaProduk: 'Kulkas', hargaProduk: 2500000),
    Produk(id: 3, kodeProduk: 'A003', namaProduk: 'Mesin Cuci', hargaProduk: 2000000),
  ];

  Future<void> _tambahProduk() async {
    final hasil = await Navigator.push<Produk>(
      context,
      MaterialPageRoute(builder: (context) => const ProdukForm()),
    );
    if (hasil != null) {
      setState(() => _listProduk.add(hasil));
    }
  }

  Future<void> _ubahProduk(int index) async {
    final hasil = await Navigator.push<Produk>(
      context,
      MaterialPageRoute(
        builder: (context) => ProdukForm(produk: _listProduk[index]),
      ),
    );
    if (hasil != null) {
      setState(() => _listProduk[index] = hasil);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: _tambahProduk,
              child: const Icon(Icons.add_circle_outline, size: 28.0),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _listProduk.length,
          itemBuilder: (context, index) {
            final produk = _listProduk[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.inventory, color: Colors.white),
                ),
                title: Text(
                  produk.namaProduk ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${produk.kodeProduk} • Rp ${produk.hargaProduk}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                trailing: const Icon(Icons.edit, color: Colors.blue),
                onTap: () => _ubahProduk(index),
              ),
            );
          },
        ),
      ),
    );
  }
}