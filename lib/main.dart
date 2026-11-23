import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const BingwaDataSwiftApp());
}

class BDSColors {
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color primaryGreen = Color(0xFF22A06B); // Light green accent
  static const Color lightGreenAccent = Color(0xFF4ADE80);
  static const Color softGreenBg = Color(0xFFEAF9F1);
  static const Color lightGreenBadgeBg = Color(0xFFD1FAE5);
  static const Color lightGreyPill = Color(0xFFEEEEEE);
  static const Color blackText = Color(0xFF111111);
  static const Color greyText = Color(0xFF666666);
  static const Color cardBorder = Color(0xFFDCEEE4);
  static const Color dangerRed = Color(0xFFB91C1C);
  static const Color amberBg = Color(0xFFFEF3C7);
  static const Color amberText = Color(0xFFB45309);
}

class OfferModel {
  final String id;
  final String network; // SAFARICOM, AIRTEL, TELKOM, FAIBA
  final String name;
  final String priceLabel;
  final int? fixedPriceKes;
  final int? minKes;
  final int? maxKes;
  final String validity;
  final String category;
  final bool isVisible;

  const OfferModel({
    required this.id,
    required this.network,
    required this.name,
    required this.priceLabel,
    this.fixedPriceKes,
    this.minKes,
    this.maxKes,
    required this.validity,
    required this.category,
    this.isVisible = true,
  });

  bool get isFlexibleAmount => fixedPriceKes == null;

  OfferModel copyWith({
    String? id,
    String? network,
    String? name,
    String? priceLabel,
    int? fixedPriceKes,
    int? minKes,
    int? maxKes,
    String? validity,
    String? category,
    bool? isVisible,
  }) {
    return OfferModel(
      id: id ?? this.id,
      network: network ?? this.network,
      name: name ?? this.name,
      priceLabel: priceLabel ?? this.priceLabel,
      fixedPriceKes: fixedPriceKes ?? this.fixedPriceKes,
      minKes: minKes ?? this.minKes,
      maxKes: maxKes ?? this.maxKes,
      validity: validity ?? this.validity,
      category: category ?? this.category,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

class AdItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;

  const AdItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class OrderRecord {
  final String orderId;
  final String network;
  final String bundleName;
  final String recipientPhone;
  final String paymentPhone;
  final int amountKes;
  final String paymentRef;
  final String dateLabel;
  final String paymentStatus;
  final String deliveryStatus;

  const OrderRecord({
    required this.orderId,
    required this.network,
    required this.bundleName,
    required this.recipientPhone,
    required this.paymentPhone,
    required this.amountKes,
    required this.paymentRef,
    required this.dateLabel,
    required this.paymentStatus,
    required this.deliveryStatus,
  });
}

class Catalogue68 {
  static const String appName = 'BINGWA DATA SWIFT';
  static const String tagline = 'Bundles and airtime that keep you connected.';
  static const String whatsappPhone = '0794363801';
  static const String callPhone = '0794363801';
  static const String adminPhone = '0794363801';
  static const String adminAccessCode = '2026';
  static const String whatsappGroupUrl =
      'https://chat.whatsapp.com/DB9snd9pSXf9vVrTN3vhTR?s=cl&p=a&iam=2';
  static const String appDownloadBaseUrl = 'https://bingwadataswift.app/download';

  static const List<OfferModel> initialOffers = [
    // SAFARICOM DATA/COMBO (24)
    OfferModel(id: 's_dc_1', network: 'SAFARICOM', name: '10MB+7SMS', priceLabel: 'KES 8', fixedPriceKes: 8, validity: '24Hrs', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_2', network: 'SAFARICOM', name: '250MB', priceLabel: 'KES 20', fixedPriceKes: 20, validity: '24Hrs', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_3', network: 'SAFARICOM', name: '1GB', priceLabel: 'KES 21', fixedPriceKes: 21, validity: '1Hr', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_4', network: 'SAFARICOM', name: '1GB', priceLabel: 'KES 19', fixedPriceKes: 19, validity: '1Hr', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_5', network: 'SAFARICOM', name: '450MB', priceLabel: 'KES 32', fixedPriceKes: 32, validity: 'Till Midnight', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_6', network: 'SAFARICOM', name: '1.5GB', priceLabel: 'KES 53', fixedPriceKes: 53, validity: '3Hrs', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_7', network: 'SAFARICOM', name: '750MB+50SMS', priceLabel: 'KES 54', fixedPriceKes: 54, validity: '24Hrs', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_8', network: 'SAFARICOM', name: '1GB', priceLabel: 'KES 55', fixedPriceKes: 55, validity: 'Till Midnight', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_9', network: 'SAFARICOM', name: '400MB', priceLabel: 'KES 56', fixedPriceKes: 56, validity: '7Days', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_10', network: 'SAFARICOM', name: '400MB', priceLabel: 'KES 49', fixedPriceKes: 49, validity: '7Days', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_11', network: 'SAFARICOM', name: '900MB', priceLabel: 'KES 58', fixedPriceKes: 58, validity: 'Till Midnight', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_12', network: 'SAFARICOM', name: '1GB', priceLabel: 'KES 60', fixedPriceKes: 60, validity: 'Till Midnight', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_13', network: 'SAFARICOM', name: '1.25GB', priceLabel: 'KES 78', fixedPriceKes: 78, validity: 'Till Midnight', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_14', network: 'SAFARICOM', name: '1.5GB+40SMS+WhatsApp', priceLabel: 'KES 106', fixedPriceKes: 106, validity: '24Hrs', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_15', network: 'SAFARICOM', name: '2GB', priceLabel: 'KES 110', fixedPriceKes: 110, validity: '24Hrs', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_16', network: 'SAFARICOM', name: '2.5GB', priceLabel: 'KES 99', fixedPriceKes: 99, validity: '24Hrs', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_17', network: 'SAFARICOM', name: '2.5GB', priceLabel: 'KES 250', fixedPriceKes: 250, validity: '30Days', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_18', network: 'SAFARICOM', name: '5GB', priceLabel: 'KES 255', fixedPriceKes: 255, validity: '3Days', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_19', network: 'SAFARICOM', name: '2.5GB', priceLabel: 'KES 256', fixedPriceKes: 256, validity: '30Days', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_20', network: 'SAFARICOM', name: '4GB+220Mins+50SMS', priceLabel: 'KES 505', fixedPriceKes: 505, validity: '7Days', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_21', network: 'SAFARICOM', name: '11GB+Free YouTube', priceLabel: 'KES 509', fixedPriceKes: 509, validity: '7Days', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_22', network: 'SAFARICOM', name: '21GB', priceLabel: 'KES 1006', fixedPriceKes: 1006, validity: '30Days', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_23', network: 'SAFARICOM', name: '21GB', priceLabel: 'KES 1020', fixedPriceKes: 1020, validity: '30Days', category: 'DATA/COMBO'),
    OfferModel(id: 's_dc_24', network: 'SAFARICOM', name: '150GB', priceLabel: 'KES 5012', fixedPriceKes: 5012, validity: '30Days', category: 'DATA/COMBO'),

    // SAFARICOM MINUTES (11)
    OfferModel(id: 's_m_1', network: 'SAFARICOM', name: '45Mins', priceLabel: 'KES 23', fixedPriceKes: 23, validity: '3Hrs', category: 'MINUTES'),
    OfferModel(id: 's_m_2', network: 'SAFARICOM', name: '45Mins', priceLabel: 'KES 22', fixedPriceKes: 22, validity: '3Hrs', category: 'MINUTES'),
    OfferModel(id: 's_m_3', network: 'SAFARICOM', name: '500Flex', priceLabel: 'KES 34', fixedPriceKes: 34, validity: '2Hrs', category: 'MINUTES'),
    OfferModel(id: 's_m_4', network: 'SAFARICOM', name: '60Mins', priceLabel: 'KES 51', fixedPriceKes: 51, validity: 'Till Midnight', category: 'MINUTES'),
    OfferModel(id: 's_m_5', network: 'SAFARICOM', name: '350Flex', priceLabel: 'KES 65', fixedPriceKes: 65, validity: 'Till Midnight', category: 'MINUTES'),
    OfferModel(id: 's_m_6', network: 'SAFARICOM', name: '1000Flex', priceLabel: 'KES 107', fixedPriceKes: 107, validity: 'Till Midnight', category: 'MINUTES'),
    OfferModel(id: 's_m_7', network: 'SAFARICOM', name: '250Mins', priceLabel: 'KES 249', fixedPriceKes: 249, validity: '7Days', category: 'MINUTES'),
    OfferModel(id: 's_m_8', network: 'SAFARICOM', name: '300Mins', priceLabel: 'KES 506', fixedPriceKes: 506, validity: '30Days', category: 'MINUTES'),
    OfferModel(id: 's_m_9', network: 'SAFARICOM', name: '1000Mins', priceLabel: 'KES 1017', fixedPriceKes: 1017, validity: '30Days', category: 'MINUTES'),
    OfferModel(id: 's_m_10', network: 'SAFARICOM', name: '1250Mins', priceLabel: 'KES 1019', fixedPriceKes: 1019, validity: '30Days', category: 'MINUTES'),
    OfferModel(id: 's_m_11', network: 'SAFARICOM', name: '1250Mins', priceLabel: 'KES 1010', fixedPriceKes: 1010, validity: '30Days', category: 'MINUTES'),

    // SAFARICOM SMS (9)
    OfferModel(id: 's_s_1', network: 'SAFARICOM', name: '20SMS', priceLabel: 'KES 5', fixedPriceKes: 5, validity: '24Hrs', category: 'SMS'),
    OfferModel(id: 's_s_2', network: 'SAFARICOM', name: '200SMS', priceLabel: 'KES 10', fixedPriceKes: 10, validity: '24Hrs', category: 'SMS'),
    OfferModel(id: 's_s_3', network: 'SAFARICOM', name: '200SMS', priceLabel: 'KES 12', fixedPriceKes: 12, validity: '24Hrs', category: 'SMS'),
    OfferModel(id: 's_s_4', network: 'SAFARICOM', name: 'Unlimited SMS', priceLabel: 'KES 28', fixedPriceKes: 28, validity: '24Hrs', category: 'SMS'),
    OfferModel(id: 's_s_5', network: 'SAFARICOM', name: '1000SMS', priceLabel: 'KES 30', fixedPriceKes: 30, validity: '7Days', category: 'SMS'),
    OfferModel(id: 's_s_6', network: 'SAFARICOM', name: '1000SMS', priceLabel: 'KES 33', fixedPriceKes: 33, validity: '7Days', category: 'SMS'),
    OfferModel(id: 's_s_7', network: 'SAFARICOM', name: 'Unlimited SMS', priceLabel: 'KES 64', fixedPriceKes: 64, validity: '7Days', category: 'SMS'),
    OfferModel(id: 's_s_8', network: 'SAFARICOM', name: '1500SMS', priceLabel: 'KES 103', fixedPriceKes: 103, validity: '30Days', category: 'SMS'),
    OfferModel(id: 's_s_9', network: 'SAFARICOM', name: '3500SMS', priceLabel: 'KES 209', fixedPriceKes: 209, validity: '30Days', category: 'SMS'),

    // SAFARICOM NO EXPIRY (2)
    OfferModel(id: 's_ne_1', network: 'SAFARICOM', name: 'No Expiry Airtime', priceLabel: 'KES 1-499', fixedPriceKes: null, minKes: 1, maxKes: 499, validity: 'No Expiry', category: 'NO EXPIRY'),
    OfferModel(id: 's_ne_2', network: 'SAFARICOM', name: 'No Expiry Data', priceLabel: 'KES 1-499', fixedPriceKes: null, minKes: 1, maxKes: 499, validity: 'No Expiry', category: 'NO EXPIRY'),

    // AIRTEL (13)
    OfferModel(id: 'a_1', network: 'AIRTEL', name: '40SMS', priceLabel: 'KES 6', fixedPriceKes: 6, validity: '24Hrs', category: 'SMS'),
    OfferModel(id: 'a_2', network: 'AIRTEL', name: '1200 On-Net SMS', priceLabel: 'KES 13', fixedPriceKes: 13, validity: '24Hrs', category: 'SMS'),
    OfferModel(id: 'a_3', network: 'AIRTEL', name: '250SMS', priceLabel: 'KES 15', fixedPriceKes: 15, validity: '24Hrs', category: 'SMS'),
    OfferModel(id: 'a_4', network: 'AIRTEL', name: '500SMS', priceLabel: 'KES 24', fixedPriceKes: 24, validity: '24Hrs', category: 'SMS'),
    OfferModel(id: 'a_5', network: 'AIRTEL', name: '50Mins', priceLabel: 'KES 27', fixedPriceKes: 27, validity: '2Days', category: 'MINUTES'),
    OfferModel(id: 'a_6', network: 'AIRTEL', name: '350 Airtel Mins', priceLabel: 'KES 61', fixedPriceKes: 61, validity: '7Days', category: 'MINUTES'),
    OfferModel(id: 'a_7', network: 'AIRTEL', name: '1500 Airtel Mins', priceLabel: 'KES 160', fixedPriceKes: 160, validity: '30Days', category: 'MINUTES'),
    OfferModel(id: 'a_8', network: 'AIRTEL', name: '3GB', priceLabel: 'KES 261', fixedPriceKes: 261, validity: '30Days', category: 'DATA'),
    OfferModel(id: 'a_9', network: 'AIRTEL', name: '12GB', priceLabel: 'KES 510', fixedPriceKes: 510, validity: '7Days', category: 'DATA'),
    OfferModel(id: 'a_10', network: 'AIRTEL', name: '8GB', priceLabel: 'KES 511', fixedPriceKes: 511, validity: '30Days', category: 'DATA'),
    OfferModel(id: 'a_11', network: 'AIRTEL', name: '25GB', priceLabel: 'KES 1015', fixedPriceKes: 1015, validity: '30Days', category: 'DATA'),
    OfferModel(id: 'a_12', network: 'AIRTEL', name: '55GB', priceLabel: 'KES 2017', fixedPriceKes: 2017, validity: '30Days', category: 'DATA'),
    OfferModel(id: 'a_13', network: 'AIRTEL', name: '55GB', priceLabel: 'KES 6020', fixedPriceKes: 6020, validity: '90Days', category: 'DATA'),

    // TELKOM (2)
    OfferModel(id: 't_1', network: 'TELKOM', name: 'Madaraka Life 1GB+100 Onnet Mins', priceLabel: 'KES 63', fixedPriceKes: 63, validity: '30Days', category: 'COMBO'),
    OfferModel(id: 't_2', network: 'TELKOM', name: 'Mambo 199 6GB+200 Telkom Mins', priceLabel: 'KES 204', fixedPriceKes: 204, validity: '30Days', category: 'COMBO'),

    // FAIBA (7)
    OfferModel(id: 'f_1', network: 'FAIBA', name: '500MB', priceLabel: 'KES 26', fixedPriceKes: 26, validity: '24Hrs', category: 'DATA'),
    OfferModel(id: 'f_2', network: 'FAIBA', name: '1.5GB', priceLabel: 'KES 59', fixedPriceKes: 59, validity: '24Hrs', category: 'DATA'),
    OfferModel(id: 'f_3', network: 'FAIBA', name: '3GB', priceLabel: 'KES 109', fixedPriceKes: 109, validity: '3Days', category: 'DATA'),
    OfferModel(id: 'f_4', network: 'FAIBA', name: '10GB', priceLabel: 'KES 311', fixedPriceKes: 311, validity: '7Days', category: 'DATA'),
    OfferModel(id: 'f_5', network: 'FAIBA', name: '15GB', priceLabel: 'KES 520', fixedPriceKes: 520, validity: '30Days', category: 'DATA'),
    OfferModel(id: 'f_6', network: 'FAIBA', name: '40GB', priceLabel: 'KES 1014', fixedPriceKes: 1014, validity: '30Days', category: 'DATA'),
    OfferModel(id: 'f_7', network: 'FAIBA', name: '120GB', priceLabel: 'KES 2020', fixedPriceKes: 2020, validity: '30Days', category: 'DATA'),
  ];
}

String _normalizePhone(String input) {
  final digits = input.replaceAll(RegExp(r'\D'), '');
  if (digits.startsWith('254') && digits.length == 12) {
    return '0${digits.substring(3)}';
  }
  return digits;
}

bool _checkIsAdmin(String phone, String pin) {
  return _normalizePhone(phone) == _normalizePhone(Catalogue68.adminPhone) &&
      pin.trim() == Catalogue68.adminAccessCode;
}

Future<String?> pickImageFromGallery(BuildContext context) async {
  try {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) {
      return null;
    }
    return picked.path;
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open gallery on this device.')),
      );
    }
    return null;
  }
}

Widget buildAvatarWidget({
  required String? imagePath,
  required double radius,
  Color bgColor = BDSColors.softGreenBg,
  Color iconColor = BDSColors.primaryGreen,
}) {
  if (imagePath != null && imagePath.isNotEmpty && File(imagePath).existsSync()) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: bgColor,
      backgroundImage: FileImage(File(imagePath)),
    );
  }
  return CircleAvatar(
    radius: radius,
    backgroundColor: bgColor,
    child: Icon(Icons.person, color: iconColor, size: radius),
  );
}

Future<void> openWhatsAppDirect(BuildContext context) async {
  final digits = Catalogue68.whatsappPhone.replaceAll(RegExp(r'\D'), '');
  final international = digits.startsWith('0') ? '254${digits.substring(1)}' : digits;
  final uri = Uri.parse('https://wa.me/$international');
  final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to open WhatsApp on this device.')),
    );
  }
}

Future<void> openCallDirect(BuildContext context) async {
  final uri = Uri(scheme: 'tel', path: Catalogue68.callPhone);
  final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to open phone dialer on this device.')),
    );
  }
}

Future<void> openWhatsAppGroupDirect(BuildContext context) async {
  final uri = Uri.parse(Catalogue68.whatsappGroupUrl);
  final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to open WhatsApp group link.')),
    );
  }
}

class BingwaDataSwiftApp extends StatefulWidget {
  const BingwaDataSwiftApp({super.key});

  @override
  State<BingwaDataSwiftApp> createState() => _BingwaDataSwiftAppState();
}

class _BingwaDataSwiftAppState extends State<BingwaDataSwiftApp> {
  bool _showSplash = true;
  bool _isAuthenticated = false;
  bool _isAdmin = false;
  String _userName = 'Bingwa User';
  String _userPhone = '07XXXXXXXX';
  String _userPin = '1234';
  String? _profilePhotoPath;
  bool _storeOpen = true;

  List<OfferModel> _offers = List<OfferModel>.from(Catalogue68.initialOffers);
  List<AdItem> _ads = [
    const AdItem(
      id: 'ad_1',
      title: 'Fast Data & Minutes Across Networks',
      subtitle: 'Instant M-Pesa STK Push checkout with clear bundle details.',
      icon: Icons.bolt,
    ),
    const AdItem(
      id: 'ad_2',
      title: 'Safaricom, Airtel, Telkom & Faiba',
      subtitle: 'Select your network and confirm your recipient number easily.',
      icon: Icons.wifi_tethering,
    ),
  ];
  final List<OrderRecord> _orders = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _showSplash = false);
      }
    });
  }

  void _onLoginSuccess({
    String? name,
    String? phone,
    String? pin,
    String? profilePhotoPath,
  }) {
    final resolvedPhone = (phone != null && phone.trim().isNotEmpty)
        ? phone.trim()
        : _userPhone;
    final resolvedPin = (pin != null && pin.length == 4)
        ? pin
        : _userPin;

    setState(() {
      if (name != null && name.trim().isNotEmpty) {
        _userName = name.trim();
      }
      _userPhone = resolvedPhone;
      _userPin = resolvedPin;
      if (profilePhotoPath != null && profilePhotoPath.isNotEmpty) {
        _profilePhotoPath = profilePhotoPath;
      }
      _isAdmin = _checkIsAdmin(resolvedPhone, resolvedPin);
      _isAuthenticated = true;
    });
  }

  void _onLogout() {
    setState(() {
      _isAuthenticated = false;
      _isAdmin = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Catalogue68.appName,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: BDSColors.pureWhite,
        colorScheme: ColorScheme.fromSeed(
          seedColor: BDSColors.primaryGreen,
          primary: BDSColors.primaryGreen,
          surface: BDSColors.pureWhite,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: BDSColors.primaryGreen,
            foregroundColor: BDSColors.pureWhite,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontWeight: FontWeight.normal, color: BDSColors.blackText),
          bodyMedium: TextStyle(fontWeight: FontWeight.normal, color: BDSColors.blackText),
          titleMedium: TextStyle(fontWeight: FontWeight.w500, color: BDSColors.blackText),
        ),
      ),
      home: _showSplash
          ? const SplashScreen()
          : !_isAuthenticated
              ? AuthScreen(onSuccess: _onLoginSuccess)
              : MainShellScreen(
                  userName: _userName,
                  userPhone: _userPhone,
                  profilePhotoPath: _profilePhotoPath,
                  isAdmin: _isAdmin,
                  storeOpen: _storeOpen,
                  offers: _offers,
                  ads: _ads,
                  orders: _orders,
                  onLogout: _onLogout,
                  onUpdatePin: (newPin) {
                    setState(() {
                      _userPin = newPin;
                      _isAdmin = _checkIsAdmin(_userPhone, newPin);
                    });
                  },
                  onUpdateProfilePhoto: (path) => setState(() => _profilePhotoPath = path),
                  onToggleStore: (open) => setState(() => _storeOpen = open),
                  onAddOffer: (offer) => setState(() => _offers.insert(0, offer)),
                  onEditOffer: (updated) {
                    setState(() {
                      final idx = _offers.indexWhere((o) => o.id == updated.id);
                      if (idx != -1) _offers[idx] = updated;
                    });
                  },
                  onDeleteOffer: (id) {
                    setState(() => _offers.removeWhere((o) => o.id == id));
                  },
                  onAddAd: (ad) => setState(() => _ads.add(ad)),
                  onRemoveAd: (index) => setState(() => _ads.removeAt(index)),
                  onRecordStkAttempt: (order) => setState(() => _orders.insert(0, order)),
                  onClearOrders: () => setState(() => _orders.clear()),
                ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BDSColors.pureWhite,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: BDSColors.softGreenBg,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: BDSColors.lightGreenAccent, width: 1.5),
                ),
                child: const Icon(
                  Icons.bolt,
                  size: 52,
                  color: BDSColors.primaryGreen,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                Catalogue68.appName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: BDSColors.blackText,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                Catalogue68.tagline,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: BDSColors.greyText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  final void Function({
    String? name,
    String? phone,
    String? pin,
    String? profilePhotoPath,
  }) onSuccess;

  const AuthScreen({
    super.key,
    required this.onSuccess,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;
  bool _forgotPinMode = false;
  bool _otpSent = false;
  String? _selectedPhotoPath;

  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _otpCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  String _error = '';

  Future<void> _uploadProfilePicture() async {
    final path = await pickImageFromGallery(context);
    if (path != null && mounted) {
      setState(() => _selectedPhotoPath = path);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture selected from gallery.')),
      );
    }
  }

  void _sendOtp() {
    if (_phoneCtrl.text.trim().length < 9) {
      setState(() => _error = 'Please enter a valid phone number first.');
      return;
    }
    setState(() {
      _otpSent = true;
      _error = '';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP sent to your phone number.')),
    );
  }

  void _submit() {
    final phone = _phoneCtrl.text.trim();
    final pin = _pinCtrl.text.trim();

    if (_forgotPinMode) {
      if (phone.length < 9 || _otpCtrl.text.trim().length < 4 || pin.length != 4) {
        setState(() => _error = 'Enter phone number, OTP, and a new 4-digit PIN.');
        return;
      }
      widget.onSuccess(
        phone: phone,
        pin: pin,
        profilePhotoPath: _selectedPhotoPath,
      );
      return;
    }

    if (_isLoginMode) {
      if (phone.length < 9 || pin.length != 4) {
        setState(() => _error = 'Enter your phone number and 4-digit PIN.');
        return;
      }
      widget.onSuccess(
        phone: phone,
        pin: pin,
        profilePhotoPath: _selectedPhotoPath,
      );
    } else {
      if (_nameCtrl.text.trim().isEmpty ||
          phone.length < 9 ||
          _otpCtrl.text.trim().length < 4 ||
          pin.length != 4) {
        setState(() => _error = 'Complete name, phone number, OTP, and 4-digit PIN.');
        return;
      }
      widget.onSuccess(
        name: _nameCtrl.text.trim(),
        phone: phone,
        pin: pin,
        profilePhotoPath: _selectedPhotoPath,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleText = _forgotPinMode
        ? 'Reset PIN with OTP'
        : (_isLoginMode ? 'Welcome Back' : 'Create Account');

    return Scaffold(
      backgroundColor: BDSColors.pureWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    Catalogue68.appName,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            _isLoginMode = true;
                            _forgotPinMode = false;
                            _error = '';
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _isLoginMode && !_forgotPinMode
                                  ? BDSColors.primaryGreen
                                  : BDSColors.lightGreyPill,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: _isLoginMode && !_forgotPinMode
                                      ? BDSColors.pureWhite
                                      : BDSColors.blackText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            _isLoginMode = false;
                            _forgotPinMode = false;
                            _error = '';
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: !_isLoginMode && !_forgotPinMode
                                  ? BDSColors.primaryGreen
                                  : BDSColors.lightGreyPill,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: !_isLoginMode && !_forgotPinMode
                                      ? BDSColors.pureWhite
                                      : BDSColors.blackText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _uploadProfilePicture,
                    child: Column(
                      children: [
                        buildAvatarWidget(
                          imagePath: _selectedPhotoPath,
                          radius: 38,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _selectedPhotoPath == null
                              ? 'Upload Profile Picture'
                              : 'Change Profile Picture',
                          style: const TextStyle(
                            color: BDSColors.primaryGreen,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    titleText,
                    style: const TextStyle(fontSize: 20, fontWeight:
