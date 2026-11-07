import 'package:flutter/material.dart';

import 'counter_buttons.dart';
import 'counter_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// Halaman awal: tombol untuk membuka & menutup CounterPage.
// Dibuat supaya dispose() CounterPage benar-benar terpanggil (saat kembali).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.exposure),
          label: const Text('Buka Counter'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CounterPage()),
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// PARENT: menyimpan state counter
// ---------------------------------------------------------------------------
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    debugPrint('Counter dimulai');
  }

  @override
  void dispose() {
    debugPrint('Counter ditutup');
    super.dispose();
  }

  void _tambah() {
    setState(() {
      _counter++;
    });
  }

  void _kurang() {
    // Angka tidak boleh minus: kalau sudah 0, tidak melakukan apa-apa.
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Passing data: parent -> child lewat constructor
            CounterDisplay(nilai: _counter),
            const SizedBox(height: 32),
            // Callback: child memanggil fungsi milik parent
            CounterButtons(
              onAdd: _tambah,
              onSubtract: _kurang,
              onReset: _reset,
            ),
          ],
        ),
      ),
    );
  }
}
