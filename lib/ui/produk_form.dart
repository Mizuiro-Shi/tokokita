import 'package:flutter/material.dart';
import '../model/produk.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;

  const ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  final _kodeProdukController = TextEditingController();
  final _namaProdukController = TextEditingController();
  final _hargaProdukController = TextEditingController();

  bool get _isUbah => widget.produk != null;

  @override
  void initState() {
    super.initState();
    if (_isUbah) {
      _kodeProdukController.text = widget.produk!.kodeProduk ?? '';
      _namaProdukController.text = widget.produk!.namaProduk ?? '';
      _hargaProdukController.text = widget.produk!.hargaProduk?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _kodeProdukController.dispose();
    _namaProdukController.dispose();
    _hargaProdukController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isUbah ? "Ubah Produk" : "Tambah Produk", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isUbah ? Icons.edit_note : Icons.add_box,
                        size: 60,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _isUbah ? "Form Ubah" : "Form Tambah",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _kodeProdukTextField(),
                      const SizedBox(height: 16),
                      _namaProdukTextField(),
                      const SizedBox(height: 16),
                      _hargaProdukTextField(),
                      const SizedBox(height: 30),
                      _buttonSubmit(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Kode Produk",
        prefixIcon: const Icon(Icons.qr_code, color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _kodeProdukController,
      validator: (value) {
        if (value!.isEmpty) return "Kode Produk harus diisi";
        return null;
      },
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Produk",
        prefixIcon: const Icon(Icons.label, color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _namaProdukController,
      validator: (value) {
        if (value!.isEmpty) return "Nama Produk harus diisi";
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Harga",
        prefixIcon: const Icon(Icons.attach_money, color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _hargaProdukController,
      validator: (value) {
        if (value!.isEmpty) return "Harga harus diisi";
        if (int.tryParse(value) == null) return "Harga harus berupa angka";
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.save),
        label: Text(
          _isUbah ? "UBAH" : "SIMPAN",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final produk = Produk(
              id: widget.produk?.id ?? DateTime.now().millisecondsSinceEpoch,
              kodeProduk: _kodeProdukController.text,
              namaProduk: _namaProdukController.text,
              hargaProduk: int.parse(_hargaProdukController.text),
            );
            Navigator.pop(context, produk);
          }
        },
      ),
    );
  }
}