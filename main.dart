import 'package:flutter/material.dart';

void main() {
  runApp(const BingwaSokoniApp());
}

class BingwaSokoniApp extends StatelessWidget {
  const BingwaSokoniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BINGWA SOKONI DATA SWIFT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF008A55)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final networks = ['SAFARICOM', 'AIRTEL', 'TELKOM', 'FAIBA'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF008A55),
        foregroundColor: Colors.white,
        title: const Text('BINGWA SOKONI DATA SWIFT'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bundles and airtime that keep you connected.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text('Till: 1765260 | Support: 01812424100'),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: networks.length,
                itemBuilder: (context, index) {
                  final net = networks[index];
                  return Card(
                    child: ListTile(
                      title: Text(net),
                      subtitle: const Text('Tap to view offers'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$net selected')),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
