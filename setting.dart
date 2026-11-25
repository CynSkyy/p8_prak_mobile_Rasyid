import 'package:flutter/material.dart';
import 'package:pertemuan8/theme.dart';
import 'package:provider/provider.dart';

class HalamanSetting extends StatefulWidget {
  const HalamanSetting({super.key});

  @override
  State<HalamanSetting> createState() => _HalamanSettingState();
}

class _HalamanSettingState extends State<HalamanSetting> {
  final TextEditingController _namaController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProvider>(context);
    final isDark = themeprovider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
        title: const Text('Pengaturan Tema'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              // Card Input dan Tampilan Nama Pengguna
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        themeprovider.namaUser.isEmpty
                            ? 'Selamat Datang di aplikasi'
                            : 'Halo, ${themeprovider.namaUser}!',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          labelText: 'Masukkan Nama',
                          hintText: 'Ketik nama Anda di sini...',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_namaController.text.trim().isNotEmpty) {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .saveNama(_namaController.text.trim());
                              _namaController.clear();
                              FocusScope.of(context).unfocus();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Nama berhasil disimpan!'),
                                ),
                              );
                            }
                          },
                          child: const Text('Simpan Nama'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Card Status Tema
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Icon(
                        isDark ? Icons.dark_mode : Icons.light_mode,
                        size: 30,
                        color: isDark ? Colors.yellow : Colors.orange,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isDark
                            ? 'Mode Gelap On Aktif'
                            : 'Mode terang Aktif Dinyalakan',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Card Switch Tema
              Card(
                child: SwitchListTile(
                  secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                  title: const Text('Mode Hytam'),
                  subtitle: Text(isDark ? 'Aktif' : 'Nonaktif'),
                  value: isDark,
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}