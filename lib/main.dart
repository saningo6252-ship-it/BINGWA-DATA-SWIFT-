import 'package:flutter/material.dart';

void main() {
  runApp(const BingwaSokoniApp());
}

class AppColors {
  static const primaryGreen = Color(0xFF008A55);
  static const darkGreen = Color(0xFF075238);
  static const lightGreen = Color(0xFFEAF7F0);
  static const white = Color(0xFFFFFFFF);
  static const darkText = Color(0xFF111827);
  static const background = Color(0xFFF7FAF8);
}

class BundleOffer {
  final String id;
  final String network;
  final String name;
  final int priceKes;
  final String validity;
  final String category; // ALL, DATA, SMS, MINUTES, COMBO, NO EXPIRY
  final bool popular;
  final bool customAmount;
  final int minKes;
  final int maxKes;

  const BundleOffer({
    required this.id,
    required this.network,
    required this.name,
    required this.priceKes,
    required this.validity,
    required this.category,
    this.popular = false,
    this.customAmount = false,
    this.minKes = 1,
    this.maxKes = 499,
  });
}

class CatalogueData {
  static const String businessName = 'BINGWA SOKONI DATA SWIFT';
  static const String tagline = 'Bundles and airtime that keep you connected.';
  static const String tillNumber = '1765260';
  static const String supportPhone = '01812424100';

  static const List<String> networks = [
    'SAFARICOM',
    'AIRTEL',
    'TELKOM',
    'FAIBA',
  ];

  static const List<String> categories = [
    'ALL',
    'DATA',
    'SMS',
    'MINUTES',
    'COMBO',
    'NO EXPIRY',
  ];

  static const List<BundleOffer> offers = [
    // A. SAFARICOM CATALOGUE - DATA / COMBO
    BundleOffer(
      id: 'saf-10mb-7sms',
      network: 'SAFARICOM',
      name: '10MB + 7 SMS',
      priceKes: 8,
      validity: '24 Hrs / Daily',
      category: 'COMBO',
    ),
    BundleOffer(
      id: 'saf-250mb',
      network: 'SAFARICOM',
      name: '250MB',
      priceKes: 20,
      validity: '24 Hrs / Daily',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'saf-1gb-1hr',
      network: 'SAFARICOM',
      name: '1GB',
      priceKes: 21,
      validity: '1 Hr / Hourly',
      category: 'DATA',
      popular: true,
    ),
    BundleOffer(
      id: 'saf-450mb',
      network: 'SAFARICOM',
      name: '450MB',
      priceKes: 32,
      validity: 'Till Midnight / Daily',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'saf-1_5gb-3hr',
      network: 'SAFARICOM',
      name: '1.5GB',
      priceKes: 53,
      validity: '3 Hrs / Hourly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'saf-750mb-50sms',
      network: 'SAFARICOM',
      name: '750MB + 50 SMS',
      priceKes: 54,
      validity: '24 Hrs / Daily',
      category: 'COMBO',
    ),
    BundleOffer(
      id: 'saf-800mb',
      network: 'SAFARICOM',
      name: '800MB',
      priceKes: 55,
      validity: 'Till Midnight / Daily',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'saf-400mb-7d',
      network: 'SAFARICOM',
      name: '400MB',
      priceKes: 56,
      validity: '7 Days / Weekly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'saf-900mb',
      network: 'SAFARICOM',
      name: '900MB',
      priceKes: 58,
      validity: 'Till Midnight / Daily',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'saf-1gb-midnight',
      network: 'SAFARICOM',
      name: '1GB',
      priceKes: 60,
      validity: 'Till Midnight / Daily',
      category: 'DATA',
      popular: true,
    ),
    BundleOffer(
      id: 'saf-1_25gb',
      network: 'SAFARICOM',
      name: '1.25GB',
      priceKes: 78,
      validity: 'Till Midnight / Daily',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'saf-1_5gb-40sms-wa',
      network: 'SAFARICOM',
      name: '1.5GB + 40 SMS + WhatsApp',
      priceKes: 106,
      validity: '24 Hrs / Daily',
      category: 'COMBO',
      popular: true,
    ),
    BundleOffer(
      id: 'saf-1_1gb-yt',
      network: 'SAFARICOM',
      name: '1.1GB + Free YouTube',
      priceKes: 110,
      validity: '7 Days / Weekly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'saf-5gb-3d',
      network: 'SAFARICOM',
      name: '5GB',
      priceKes: 255,
      validity: '3 Days',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'saf-2_5gb-30d',
      network: 'SAFARICOM',
      name: '2.5GB',
      priceKes: 256,
      validity: '30 Days / Monthly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'saf-4gb-220mins-50sms',
      network: 'SAFARICOM',
      name: '4GB + 220 Mins + 50 SMS',
      priceKes: 505,
      validity: '7 Days / Weekly',
      category: 'COMBO',
    ),
    BundleOffer(
      id: 'saf-11gb-yt',
      network: 'SAFARICOM',
      name: '11GB + Free YouTube',
      priceKes: 509,
      validity: '7 Days / Weekly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'saf-21gb-30d',
      network: 'SAFARICOM',
      name: '21GB',
      priceKes: 1006,
      validity: '30 Days / Monthly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'saf-150gb-30d',
      network: 'SAFARICOM',
      name: '150GB',
      priceKes: 5012,
      validity: '30 Days / Monthly',
      category: 'DATA',
    ),

    // SAFARICOM MINUTES / FLEX
    BundleOffer(
      id: 'saf-45mins',
      network: 'SAFARICOM',
      name: '45 Mins',
      priceKes: 23,
      validity: '3 Hrs / Hourly',
      category: 'MINUTES',
    ),
    BundleOffer(
      id: 'saf-500flex',
      network: 'SAFARICOM',
      name: '500 Flex',
      priceKes: 34,
      validity: '2 Hrs / Hourly',
      category: 'MINUTES',
    ),
    BundleOffer(
      id: 'saf-350flex',
      network: 'SAFARICOM',
      name: '350 Flex',
      priceKes: 65,
      validity: 'Till Midnight / Daily',
      category: 'MINUTES',
    ),
    BundleOffer(
      id: 'saf-1000flex',
      network: 'SAFARICOM',
      name: '1000 Flex',
      priceKes: 107,
      validity: 'Till Midnight / Daily',
      category: 'MINUTES',
    ),
    BundleOffer(
      id: 'saf-300mins',
      network: 'SAFARICOM',
      name: '300 Mins',
      priceKes: 506,
      validity: '30 Days / Monthly',
      category: 'MINUTES',
    ),
    BundleOffer(
      id: 'saf-1000mins',
      network: 'SAFARICOM',
      name: '1000 Mins',
      priceKes: 1017,
      validity: '30 Days / Monthly',
      category: 'MINUTES',
    ),
    BundleOffer(
      id: 'saf-1250mins',
      network: 'SAFARICOM',
      name: '1250 Mins',
      priceKes: 1019,
      validity: '30 Days / Monthly',
      category: 'MINUTES',
    ),

    // SAFARICOM SMS
    BundleOffer(
      id: 'saf-200sms',
      network: 'SAFARICOM',
      name: '200 SMS',
      priceKes: 12,
      validity: '24 Hrs / Daily',
      category: 'SMS',
    ),
    BundleOffer(
      id: 'saf-unlim-sms-1d',
      network: 'SAFARICOM',
      name: 'Unlimited SMS',
      priceKes: 28,
      validity: '24 Hrs / Daily',
      category: 'SMS',
    ),
    BundleOffer(
      id: 'saf-1000sms',
      network: 'SAFARICOM',
      name: '1000 SMS',
      priceKes: 33,
      validity: '7 Days / Weekly',
      category: 'SMS',
    ),
    BundleOffer(
      id: 'saf-unlim-sms-7d',
      network: 'SAFARICOM',
      name: 'Unlimited SMS',
      priceKes: 64,
      validity: '7 Days / Weekly',
      category: 'SMS',
    ),
    BundleOffer(
      id: 'saf-1500sms',
      network: 'SAFARICOM',
      name: '1500 SMS',
      priceKes: 103,
      validity: '30 Days / Monthly',
      category: 'SMS',
    ),
    BundleOffer(
      id: 'saf-3500sms',
      network: 'SAFARICOM',
      name: '3500 SMS',
      priceKes: 209,
      validity: '30 Days / Monthly',
      category: 'SMS',
    ),

    // SAFARICOM NO EXPIRY
    BundleOffer(
      id: 'saf-no-expiry-airtime',
      network: 'SAFARICOM',
      name: 'No Expiry Airtime',
      priceKes: 10,
      validity: 'No Expiry',
      category: 'NO EXPIRY',
      customAmount: true,
      minKes: 1,
      maxKes: 499,
    ),
    BundleOffer(
      id: 'saf-no-expiry-data',
      network: 'SAFARICOM',
      name: 'No Expiry Data',
      priceKes: 20,
      validity: 'No Expiry',
      category: 'NO EXPIRY',
      customAmount: true,
      minKes: 1,
      maxKes: 499,
    ),

    // B. AIRTEL CATALOGUE - SMS
    BundleOffer(
      id: 'air-6sms',
      network: 'AIRTEL',
      name: '6 SMS',
      priceKes: 5,
      validity: '24 Hrs / Daily',
      category: 'SMS',
    ),
    BundleOffer(
      id: 'air-40sms',
      network: 'AIRTEL',
      name: '40 SMS',
      priceKes: 6,
      validity: '24 Hrs / Daily',
      category: 'SMS',
    ),
    BundleOffer(
      id: 'air-1200sms',
      network: 'AIRTEL',
      name: '1200 On-Net SMS',
      priceKes: 13,
      validity: '24 Hrs / Daily',
      category: 'SMS',
    ),
    BundleOffer(
      id: 'air-250sms',
      network: 'AIRTEL',
      name: '250 SMS',
      priceKes: 15,
      validity: '24 Hrs / Daily',
      category: 'SMS',
    ),
    BundleOffer(
      id: 'air-500sms',
      network: 'AIRTEL',
      name: '500 SMS',
      priceKes: 24,
      validity: '24 Hrs / Daily',
      category: 'SMS',
    ),

    // AIRTEL MINUTES
    BundleOffer(
      id: 'air-50mins',
      network: 'AIRTEL',
      name: '50 Mins',
      priceKes: 27,
      validity: '2 Days',
      category: 'MINUTES',
    ),
    BundleOffer(
      id: 'air-350mins',
      network: 'AIRTEL',
      name: '350 Airtel Mins',
      priceKes: 61,
      validity: '7 Days / Weekly',
      category: 'MINUTES',
      popular: true,
    ),
    BundleOffer(
      id: 'air-1500mins',
      network: 'AIRTEL',
      name: '1500 Airtel Mins',
      priceKes: 160,
      validity: '30 Days / Monthly',
      category: 'MINUTES',
    ),

    // AIRTEL DATA
    BundleOffer(
      id: 'air-3gb-30d',
      network: 'AIRTEL',
      name: '3GB',
      priceKes: 261,
      validity: '30 Days / Monthly',
      category: 'DATA',
      popular: true,
    ),
    BundleOffer(
      id: 'air-12gb-7d',
      network: 'AIRTEL',
      name: '12GB',
      priceKes: 510,
      validity: '7 Days / Weekly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'air-8gb-30d',
      network: 'AIRTEL',
      name: '8GB',
      priceKes: 511,
      validity: '30 Days / Monthly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'air-25gb-30d',
      network: 'AIRTEL',
      name: '25GB',
      priceKes: 1015,
      validity: '30 Days / Monthly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'air-55gb-30d',
      network: 'AIRTEL',
      name: '55GB',
      priceKes: 2017,
      validity: '30 Days / Monthly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'air-55gb-90d',
      network: 'AIRTEL',
      name: '55GB',
      priceKes: 6020,
      validity: '90 Days / Quarterly',
      category: 'DATA',
    ),

    // C. TELKOM CATALOGUE
    BundleOffer(
      id: 'tel-madaraka-life',
      network: 'TELKOM',
      name: 'Madaraka Life Includes: 1GB + 100 Onnet Mins',
      priceKes: 63,
      validity: '30 Days / Monthly',
      category: 'COMBO',
      popular: true,
    ),
    BundleOffer(
      id: 'tel-mambo-199',
      network: 'TELKOM',
      name: 'Mambo 199 Includes: 6GB + 200 Telkom Mins',
      priceKes: 204,
      validity: '30 Days / Monthly',
      category: 'COMBO',
    ),

    // D. FAIBA CATALOGUE
    BundleOffer(
      id: 'fai-500mb',
      network: 'FAIBA',
      name: '500MB',
      priceKes: 26,
      validity: '24 Hrs / Daily',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'fai-1_5gb',
      network: 'FAIBA',
      name: '1.5GB',
      priceKes: 59,
      validity: '24 Hrs / Daily',
      category: 'DATA',
      popular: true,
    ),
    BundleOffer(
      id: 'fai-3gb',
      network: 'FAIBA',
      name: '3GB',
      priceKes: 109,
      validity: '3 Days',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'fai-10gb',
      network: 'FAIBA',
      name: '10GB',
      priceKes: 311,
      validity: '7 Days / Weekly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'fai-15gb',
      network: 'FAIBA',
      name: '15GB',
      priceKes: 520,
      validity: '30 Days / Monthly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'fai-40gb',
      network: 'FAIBA',
      name: '40GB',
      priceKes: 1014,
      validity: '30 Days / Monthly',
      category: 'DATA',
    ),
    BundleOffer(
      id: 'fai-120gb',
      network: 'FAIBA',
      name: '120GB',
      priceKes: 2020,
      validity: '30 Days / Monthly',
      category: 'DATA',
    ),
  ];
}

class BingwaSokoniApp extends StatelessWidget {
  const BingwaSokoniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: CatalogueData.businessName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryGreen,
          primary: AppColors.primaryGreen,
          surface: AppColors.background,
        ),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.darkText),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              CatalogueData.businessName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              CatalogueData.tagline,
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.primaryGreen.withValues(alpha: 0.35),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Till: ${CatalogueData.tillNumber}',
                  style: TextStyle(
                    color: AppColors.darkGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Support: ${CatalogueData.supportPhone}',
                  style: TextStyle(color: AppColors.darkText, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Select Network',
            style: TextStyle(
              color: AppColors.darkText,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...CatalogueData.networks.map((networkName) {
            final count = CatalogueData.offers
                .where((o) => o.network == networkName)
                .length;
            return Card(
              color: AppColors.white,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.lightGreen,
                  child: Icon(Icons.sim_card, color: AppColors.primaryGreen),
                ),
                title: Text(
                  networkName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
                subtitle: Text('$count offers available'),
                trailing: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: AppColors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NetworkCatalogueScreen(
                          networkName: networkName,
                        ),
                      ),
                    );
                  },
                  child: const Text('View Offers'),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class NetworkCatalogueScreen extends StatefulWidget {
  final String networkName;

  const NetworkCatalogueScreen({super.key, required this.networkName});

  @override
  State<NetworkCatalogueScreen> createState() => _NetworkCatalogueScreenState();
}

class _NetworkCatalogueScreenState extends State<NetworkCatalogueScreen> {
  String _selectedCategory = 'ALL';
  String _searchQuery = '';
  String _sortMode = 'default'; // default, price_asc, price_desc, popular

  List<BundleOffer> get _filteredOffers {
    final list = CatalogueData.offers.where((offer) {
      if (offer.network != widget.networkName) return false;
      if (_selectedCategory != 'ALL' && offer.category != _selectedCategory) {
        return false;
      }
      if (_sortMode == 'popular' && !offer.popular) {
        return false;
      }
      if (_searchQuery.trim().isNotEmpty) {
        final q = _searchQuery.trim().toLowerCase();
        final matchesName = offer.name.toLowerCase().contains(q);
        final matchesValidity = offer.validity.toLowerCase().contains(q);
        final matchesPrice = 'kes ${offer.priceKes}'.contains(q) ||
            '${offer.priceKes}'.contains(q);
        if (!matchesName && !matchesValidity && !matchesPrice) return false;
      }
      return true;
    }).toList();

    if (_sortMode == 'price_asc') {
      list.sort((a, b) => a.priceKes.compareTo(b.priceKes));
    } else if (_sortMode == 'price_desc') {
      list.sort((a, b) => b.priceKes.compareTo(a.priceKes));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final offers = _filteredOffers;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
        title: Text('${widget.networkName} Bundles'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) => setState(() => _sortMode = value),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'default', child: Text('Default Order')),
              PopupMenuItem(value: 'popular', child: Text('Popular Offers')),
              PopupMenuItem(
                value: 'price_asc',
                child: Text('Price: Low to High'),
              ),
              PopupMenuItem(
                value: 'price_desc',
                child: Text('Price: High to Low'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search ${widget.networkName} offers...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: CatalogueData.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, index) {
                final cat = CatalogueData.categories[index];
                final selected = _selectedCategory == cat;
                return ChoiceChip(
                  label: Text(cat),
                  selected: selected,
                  selectedColor: AppColors.primaryGreen,
                  labelStyle: TextStyle(
                    color: selected ? AppColors.white : AppColors.darkText,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (_) => setState(() => _selectedCategory = cat),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: offers.isEmpty
                ? const Center(
                    child: Text(
                      'No offers available in this category.',
                      style: TextStyle(fontSize: 15, color: AppColors.darkText),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    itemCount: offers.length,
                    itemBuilder: (_, index) {
                      final offer = offers[index];
                      return Card(
                        color: AppColors.white,
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      offer.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: AppColors.darkText,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      offer.customAmount
                                          ? 'Amount: KES ${offer.minKes}–${offer.maxKes} • ${offer.validity}'
                                          : 'KES ${offer.priceKes} • ${offer.validity}',
                                      style: const TextStyle(
                                        color: AppColors.darkGreen,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.primaryGreen,
                                  foregroundColor: AppColors.white,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PurchaseConfirmScreen(
                                        offer: offer,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('BUY NOW'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class PurchaseConfirmScreen extends StatefulWidget {
  final BundleOffer offer;

  const PurchaseConfirmScreen({super.key, required this.offer});

  @override
  State<PurchaseConfirmScreen> createState() => _PurchaseConfirmScreenState();
}

class _PurchaseConfirmScreenState extends State<PurchaseConfirmScreen> {
  final _recipientCtrl = TextEditingController();
  final _paymentCtrl = TextEditingController();
  late final TextEditingController _amountCtrl;
  String? _statusMessage;

  @override
  void initState() {
    super.initState();
    _amountCtrl = TextEditingController(text: '${widget.offer.priceKes}');
  }

  @override
  void dispose() {
    _recipientCtrl.dispose();
    _paymentCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  bool _isValidKenyanPhone(String input) {
    final cleaned = input.replaceAll(RegExp(r'\s+'), '');
    return RegExp(r'^(?:\+254|254|0)(?:7\d{8}|1\d{8})$').hasMatch(cleaned);
  }

  void _onConfirmAndPay() {
    final recipient = _recipientCtrl.text.trim();
    final payer = _paymentCtrl.text.trim();
    final parsedAmount = int.tryParse(_amountCtrl.text.trim());

    if (!_isValidKenyanPhone(recipient)) {
      setState(() {
        _statusMessage = 'Enter a valid Recipient Phone Number.';
      });
      return;
    }
    if (!_isValidKenyanPhone(payer)) {
      setState(() {
        _statusMessage = 'Enter a valid M-PESA Payment Phone Number.';
      });
      return;
    }
    if (parsedAmount == null || parsedAmount <= 0) {
      setState(() {
        _statusMessage = 'Enter a valid amount in KES.';
      });
      return;
    }
    if (widget.offer.customAmount &&
        (parsedAmount < widget.offer.minKes ||
            parsedAmount > widget.offer.maxKes)) {
      setState(() {
        _statusMessage =
            'Amount must be between KES ${widget.offer.minKes} and KES ${widget.offer.maxKes}.';
      });
      return;
    }

    setState(() {
      _statusMessage =
          'Pending Payment: Connect your existing STK Push endpoint to initiate payment for ${widget.offer.name} (KES $parsedAmount) to $recipient. Manual Buy Goods Till: ${CatalogueData.tillNumber}.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
        title: const Text('CONFIRM YOUR PURCHASE'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Network: ${widget.offer.network}'),
                  const SizedBox(height: 4),
                  Text(
                    'Bundle: ${widget.offer.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Validity: ${widget.offer.validity}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _recipientCtrl,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Recipient Phone Number',
              hintText: '07XXXXXXXX or 01XXXXXXXX',
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _paymentCtrl,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Payment Phone Number (M-PESA)',
              hintText: '07XXXXXXXX or 01XXXXXXXX',
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountCtrl,
            readOnly: !widget.offer.customAmount,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount (KES)',
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _onConfirmAndPay,
            child: const Text('CONFIRM & PAY'),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HOW TO BUY MANUALLY',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGreen,
                  ),
                ),
                SizedBox(height: 6),
                Text('1. Open M-PESA'),
                Text('2. Select Lipa na M-PESA'),
                Text('3. Select Buy Goods'),
                Text('4. Enter Till Number: ${CatalogueData.tillNumber}'),
                Text('5. Enter Amount and M-PESA PIN'),
                SizedBox(height: 6),
                Text('Support: ${CatalogueData.supportPhone}'),
              ],
            ),
          ),
          if (_statusMessage != null) ...[
            const SizedBox(height: 14),
            Card(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(_statusMessage!),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
