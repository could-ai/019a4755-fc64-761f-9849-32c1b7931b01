import 'package:flutter/material.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  final _formKey = GlobalKey<FormState>();
  // Controllers for text fields
  final _visiMisiController = TextEditingController();
  final _tujuanController = TextEditingController();
  final _strukturKurikulumController = TextEditingController();

  @override
  void dispose() {
    _visiMisiController.dispose();
    _tujuanController.dispose();
    _strukturKurikulumController.dispose();
    super.dispose();
  }

  void _startAnalysis() {
    if (_formKey.currentState!.validate()) {
      // For now, just show a dialog with the entered data
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Hasil Analisis (Sementara)'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Visi, Misi, dan Tujuan:\n${_visiMisiController.text}\n'),
                  Text('Tujuan Pembelajaran:\n${_tujuanController.text}\n'),
                  Text('Struktur Kurikulum:\n${_strukturKurikulumController.text}'),
                  const SizedBox(height: 20),
                  const Text('Analisis: Data yang dimasukkan menunjukkan keselarasan awal. Diperlukan analisis lebih mendalam untuk evaluasi lengkap.', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Tutup'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Kurikulum'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'Silakan masukkan data kurikulum Anda pada kolom di bawah ini.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              _buildTextFormField(
                controller: _visiMisiController,
                label: 'Visi, Misi, dan Tujuan Satuan Pendidikan',
                hint: 'Contoh: Menjadi sekolah unggul yang berkarakter...',
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _tujuanController,
                label: 'Tujuan Pembelajaran (Learning Objectives)',
                hint: 'Contoh: Siswa mampu menjelaskan siklus air...',
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _strukturKurikulumController,
                label: 'Struktur dan Muatan Kurikulum',
                hint: 'Contoh: Mata pelajaran, alokasi waktu, kegiatan ekstrakurikuler...',
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _startAnalysis,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Lakukan Analisis'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      maxLines: 5,
      minLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bagian ini tidak boleh kosong';
        }
        return null;
      },
    );
  }
}
