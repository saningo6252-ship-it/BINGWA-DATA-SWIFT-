import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const BingwaSokoniApp());
}

class BSColors {
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color primaryGreen = Color(0xFF008A55);
  static const Color softGreenBg = Color(0xFFEAF7F0);
  static const Color lightGreyPill = Color(0xFFEEEEEE);
  static const Color blackText = Color(0xFF111111);
  static const Color greyText = Color(0xFF666666);
  static const Color cardBorder = Color(0xFFE6E6E6);
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
  static const String appName = 'BINGWA SOKONI DATA SWIFT';
  static const String tagline = 'Bundles and airtime that keep you connected.';
  static const String whatsappPhone = '0794363801';
  static const String callPhone = '0794 363801';

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

class BingwaSokoniApp extends StatefulWidget {
  const BingwaSokoniApp({super.key});

  @override
  State<BingwaSokoniApp> createState() => _BingwaSokoniAppState();
}

class _BingwaSokoniAppState extends State<BingwaSokoniApp> {
  bool _showSplash = true;
  bool _isAuthenticated = false;
  String _userName = 'BINGWA USER';
  String _userPhone = '07XXXXXXXX';
  String _userPin = '1234';
  String _referralCode = 'BSDS-0794';
  bool _storeOpen = true;

  List<OfferModel> _offers = List<OfferModel>.from(Catalogue68.initialOffers);
  List<String> _ads = [
    'BEI NAFUU KULIKO WOTE SOKONI - BINGWA SOKONI DATA SWIFT!',
    'DELIVERY IN SECONDS - UKILIPA, UNAINGIA MARA MOJA!',
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

  void _onLoginSuccess({String? name, String? phone, String? pin}) {
    setState(() {
      if (name != null && name.trim().isNotEmpty) {
        _userName = name.trim().toUpperCase();
      }
      if (phone != null && phone.trim().isNotEmpty) {
        _userPhone = phone.trim();
        final digits = phone.replaceAll(RegExp(r'\D'), '');
        final tail = digits.length >= 4 ? digits.substring(digits.length - 4) : '0794';
        _referralCode = 'BSDS-$tail';
      }
      if (pin != null && pin.length == 4) {
        _userPin = pin;
      }
      _isAuthenticated = true;
    });
  }

  void _onLogout() {
    setState(() {
      _isAuthenticated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Catalogue68.appName,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: BSColors.pureWhite,
        colorScheme: ColorScheme.fromSeed(
          seedColor: BSColors.primaryGreen,
          primary: BSColors.primaryGreen,
          surface: BSColors.pureWhite,
        ),
      ),
      home: _showSplash
          ? const SplashScreen()
          : !_isAuthenticated
              ? AuthScreen(
                  savedName: _userName,
                  savedPhone: _userPhone,
                  savedPin: _userPin,
                  onSuccess: _onLoginSuccess,
                )
              : MainShellScreen(
                  userName: _userName,
                  userPhone: _userPhone,
                  userPin: _userPin,
                  referralCode: _referralCode,
                  storeOpen: _storeOpen,
                  offers: _offers,
                  ads: _ads,
                  orders: _orders,
                  onLogout: _onLogout,
                  onUpdatePin: (newPin) => setState(() => _userPin = newPin),
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
                ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BSColors.pureWhite,
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
                  color: BSColors.softGreenBg,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: BSColors.primaryGreen, width: 2),
                ),
                child: const Icon(
                  Icons.bolt,
                  size: 54,
                  color: BSColors.primaryGreen,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                Catalogue68.appName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: BSColors.blackText,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                Catalogue68.tagline,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: BSColors.greyText,
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
  final String savedName;
  final String savedPhone;
  final String savedPin;
  final void Function({String? name, String? phone, String? pin}) onSuccess;

  const AuthScreen({
    super.key,
    required this.savedName,
    required this.savedPhone,
    required this.savedPin,
    required this.onSuccess,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;
  bool _forgotPinMode = false;
  bool _otpSent = false;

  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _otpCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  String _error = '';

  void _sendOtp() {
    if (_phoneCtrl.text.trim().length < 9) {
      setState(() => _error = 'ENTER VALID PHONE NUMBER FIRST');
      return;
    }
    setState(() {
      _otpSent = true;
      _error = '';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'OTP SENT TO YOUR PHONE NUMBER',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  void _submit() {
    final phone = _phoneCtrl.text.trim();
    final pin = _pinCtrl.text.trim();

    if (_forgotPinMode) {
      if (phone.length < 9 || _otpCtrl.text.trim().length < 4 || pin.length != 4) {
        setState(() => _error = 'ENTER PHONE, OTP, AND NEW 4-DIGIT PIN');
        return;
      }
      widget.onSuccess(phone: phone, pin: pin);
      return;
    }

    if (_isLoginMode) {
      if (phone.length < 9 || pin.length != 4) {
        setState(() => _error = 'ENTER PHONE AND 4-DIGIT PIN');
        return;
      }
      widget.onSuccess(phone: phone, pin: pin);
    } else {
      if (_nameCtrl.text.trim().isEmpty ||
          phone.length < 9 ||
          _otpCtrl.text.trim().length < 4 ||
          pin.length != 4) {
        setState(() => _error = 'COMPLETE NAME, PHONE, OTP, AND 4-DIGIT PIN');
        return;
      }
      widget.onSuccess(name: _nameCtrl.text.trim(), phone: phone, pin: pin);
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleText = _forgotPinMode
        ? 'RESET PIN WITH OTP'
        : (_isLoginMode ? 'WELCOME BACK!' : 'REGISTER ACCOUNT');

    return Scaffold(
      backgroundColor: BSColors.pureWhite,
      appBar: AppBar(
        backgroundColor: BSColors.pureWhite,
        title: const Text(
          Catalogue68.appName,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                            ? BSColors.primaryGreen
                            : BSColors.lightGreyPill,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: _isLoginMode && !_forgotPinMode
                                ? BSColors.pureWhite
                                : BSColors.blackText,
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
                            ? BSColors.primaryGreen
                            : BSColors.lightGreyPill,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: !_isLoginMode && !_forgotPinMode
                                ? BSColors.pureWhite
                                : BSColors.blackText,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              titleText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 14),
            if (!_isLoginMode && !_forgotPinMode) ...[
              const Text('FULL NAME', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              TextField(
                controller: _nameCtrl,
                style: const TextStyle(fontWeight: FontWeight.w800),
                decoration: const InputDecoration(
                  hintText: 'ENTER FULL NAME',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
            ],
            const Text('PHONE NUMBER', style: TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                    decoration: const InputDecoration(
                      hintText: '07XXXXXXXX',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                if (!_isLoginMode || _forgotPinMode) ...[
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _sendOtp,
                    child: Text(
                      _otpSent ? 'RESEND OTP' : 'SEND OTP',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ],
            ),
            if (!_isLoginMode || _forgotPinMode) ...[
              const SizedBox(height: 12),
              const Text('ENTER OTP', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              TextField(
                controller: _otpCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontWeight: FontWeight.w800),
                decoration: const InputDecoration(
                  hintText: '4-6 DIGIT OTP',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            const SizedBox(height: 12),
            const Text('4-DIGIT PIN', style: TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            TextField(
              controller: _pinCtrl,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
              style: const TextStyle(fontWeight: FontWeight.w800),
              decoration: const InputDecoration(
                hintText: '****',
                border: OutlineInputBorder(),
              ),
            ),
            if (_error.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                _error,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: BSColors.dangerRed,
                ),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _forgotPinMode
                      ? 'SAVE NEW PIN'
                      : (_isLoginMode ? 'LOGIN' : 'CREATE ACCOUNT'),
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () => setState(() {
                  _forgotPinMode = !_forgotPinMode;
                  _error = '';
                }),
                child: Text(
                  _forgotPinMode ? 'BACK TO LOGIN' : 'FORGOT PIN WITH OTP?',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: BSColors.primaryGreen,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainShellScreen extends StatefulWidget {
  final String userName;
  final String userPhone;
  final String userPin;
  final String referralCode;
  final bool storeOpen;
  final List<OfferModel> offers;
  final List<String> ads;
  final List<OrderRecord> orders;
  final VoidCallback onLogout;
  final ValueChanged<String> onUpdatePin;
  final ValueChanged<bool> onToggleStore;
  final ValueChanged<OfferModel> onAddOffer;
  final ValueChanged<OfferModel> onEditOffer;
  final ValueChanged<String> onDeleteOffer;
  final ValueChanged<String> onAddAd;
  final ValueChanged<int> onRemoveAd;
  final ValueChanged<OrderRecord> onRecordStkAttempt;

  const MainShellScreen({
    super.key,
    required this.userName,
    required this.userPhone,
    required this.userPin,
    required this.referralCode,
    required this.storeOpen,
    required this.offers,
    required this.ads,
    required this.orders,
    required this.onLogout,
    required this.onUpdatePin,
    required this.onToggleStore,
    required this.onAddOffer,
    required this.onEditOffer,
    required this.onDeleteOffer,
    required this.onAddAd,
    required this.onRemoveAd,
    required this.onRecordStkAttempt,
  });

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _navIndex = 0;

  void _openNetwork(String network) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NetworkOffersScreen(
          network: network,
          offers: widget.offers,
          storeOpen: widget.storeOpen,
          onRecordStkAttempt: widget.onRecordStkAttempt,
        ),
      ),
    );
  }

  void _openAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AccountScreen(
          userName: widget.userName,
          userPhone: widget.userPhone,
          onUpdatePin: widget.onUpdatePin,
          onLogout: widget.onLogout,
          onOpenAdmin: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AdminDashboardScreen(
                  storeOpen: widget.storeOpen,
                  offers: widget.offers,
                  ads: widget.ads,
                  orders: widget.orders,
                  onToggleStore: widget.onToggleStore,
                  onAddOffer: widget.onAddOffer,
                  onEditOffer: widget.onEditOffer,
                  onDeleteOffer: widget.onDeleteOffer,
                  onAddAd: widget.onAddAd,
                  onRemoveAd: widget.onRemoveAd,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeTabScreen(
        userName: widget.userName,
        storeOpen: widget.storeOpen,
        ads: widget.ads,
        onProfileTap: _openAccount,
        onNetworkTap: _openNetwork,
        onReferTap: () => setState(() => _navIndex = 1),
      ),
      ReferTabScreen(referralCode: widget.referralCode),
      HistoryTabScreen(orders: widget.orders),
      const SupportTabScreen(),
    ];

    return Scaffold(
      backgroundColor: BSColors.pureWhite,
      body: pages[_navIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: BSColors.pureWhite,
        selectedItemColor: BSColors.primaryGreen,
        unselectedItemColor: BSColors.blackText,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
        onTap: (idx) => setState(() => _navIndex = idx),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Refer'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.support_agent), label: 'Support'),
        ],
      ),
    );
  }
}

class HomeTabScreen extends StatelessWidget {
  final String userName;
  final bool storeOpen;
  final List<String> ads;
  final VoidCallback onProfileTap;
  final ValueChanged<String> onNetworkTap;
  final VoidCallback onReferTap;

  const HomeTabScreen({
    super.key,
    required this.userName,
    required this.storeOpen,
    required this.ads,
    required this.onProfileTap,
    required this.onNetworkTap,
    required this.onReferTap,
  });

  @override
  Widget build(BuildContext context) {
    const companies = ['SAFARICOM', 'AIRTEL', 'TELKOM', 'FAIBA'];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar: Left Logo + Name Bold, Right Profile Pic circle
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: BSColors.softGreenBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.bolt, color: BSColors.primaryGreen),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    Catalogue68.appName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: BSColors.blackText,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onProfileTap,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: BSColors.primaryGreen,
                    child: Text(
                      userName.isNotEmpty ? userName[0] : 'B',
                      style: const TextStyle(
                        color: BSColors.pureWhite,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Karibu Tena!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            const Text(
              'Bundles Rahisi, Haraka, na za Kuaminika.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: BSColors.greyText),
            ),
            const SizedBox(height: 4),
            const Text(
              'Delivery in Seconds - Ukilipa, Unaingia Mara Moja!',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: BSColors.primaryGreen),
            ),
            const SizedBox(height: 4),
            const Text(
              'Bei Nafuu Kuliko Wote Sokoni - Bingwa Sokoni Data Swift!',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: BSColors.blackText),
            ),
            if (!storeOpen) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: BSColors.amberBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'STORE CLOSED: BROWSE ONLY. NO ORDERS RIGHT NOW.',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: BSColors.amberText,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            // Large dynamic Ad Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: BSColors.primaryGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ads
                    .map(
                      (ad) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          ad,
                          style: const TextStyle(
                            color: BSColors.pureWhite,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 14),
            // Refer card
            GestureDetector(
              onTap: onReferTap,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: BSColors.softGreenBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: BSColors.primaryGreen),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.people_alt, color: BSColors.primaryGreen),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'INVITE FRIENDS & EARN REWARDS!',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: BSColors.primaryGreen,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16, color: BSColors.primaryGreen),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            // 4 Big Company Cards Bold
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: companies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.45,
              ),
              itemBuilder: (context, index) {
                final company = companies[index];
                return GestureDetector(
                  onTap: () => onNetworkTap(company),
                  child: Container(
                    decoration: BoxDecoration(
                      color: BSColors.pureWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: BSColors.cardBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        company,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: BSColors.blackText,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NetworkOffersScreen extends StatelessWidget {
  final String network;
  final List<OfferModel> offers;
  final bool storeOpen;
  final ValueChanged<OrderRecord> onRecordStkAttempt;

  const NetworkOffersScreen({
    super.key,
    required this.network,
    required this.offers,
    required this.storeOpen,
    required this.onRecordStkAttempt,
  });

  @override
  Widget build(BuildContext context) {
    final visibleOffers =
        offers.where((o) => o.network == network && o.isVisible).toList();

    return Scaffold(
      backgroundColor: BSColors.pureWhite,
      appBar: AppBar(
        backgroundColor: BSColors.pureWhite,
        title: Text(
          network,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          if (!storeOpen)
            Container(
              width: double.infinity,
              color: BSColors.amberBg,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'STORE CLOSED: BROWSE ONLY',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: BSColors.amberText,
                ),
              ),
            ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: visibleOffers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = visibleOffers[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: BSColors.pureWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: BSColors.cardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: BSColors.softGreenBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.card_giftcard,
                          color: BSColors.primaryGreen,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: BSColors.blackText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item.priceLabel}  •  ${item.validity}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                                color: BSColors.greyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: storeOpen
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BuyConfirmScreen(
                                      offer: item,
                                      storeOpen: storeOpen,
                                      onRecordStkAttempt: onRecordStkAttempt,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: BSColors.pureWhite,
                          foregroundColor: BSColors.primaryGreen,
                          side: const BorderSide(
                            color: BSColors.primaryGreen,
                            width: 1.6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'BUY',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: BSColors.primaryGreen,
                          ),
                        ),
                      ),
                    ],
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

class BuyConfirmScreen extends StatefulWidget {
  final OfferModel offer;
  final bool storeOpen;
  final ValueChanged<OrderRecord> onRecordStkAttempt;

  const BuyConfirmScreen({
    super.key,
    required this.offer,
    required this.storeOpen,
    required this.onRecordStkAttempt,
  });

  @override
  State<BuyConfirmScreen> createState() => _BuyConfirmScreenState();
}

class _BuyConfirmScreenState extends State<BuyConfirmScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientCtrl = TextEditingController();
  final _paymentCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String _statusMsg = '';

  @override
  void initState() {
    super.initState();
    if (!widget.offer.isFlexibleAmount && widget.offer.fixedPriceKes != null) {
      _amountCtrl.text = widget.offer.fixedPriceKes.toString();
    }
  }

  String? _validatePhone(String? v) {
    final clean = (v ?? '').replaceAll(RegExp(r'\s+'), '');
    if (!RegExp(r'^(?:\+254|254|0)(?:7\d{8}|1\d{8})$').hasMatch(clean)) {
      return 'ENTER VALID NUMBER (E.G. 07XXXXXXXX)';
    }
    return null;
  }

  String? _validateAmount(String? v) {
    final amt = int.tryParse((v ?? '').trim());
    if (amt == null) return 'ENTER VALID AMOUNT';
    if (widget.offer.isFlexibleAmount) {
      final minVal = widget.offer.minKes ?? 1;
      final maxVal = widget.offer.maxKes ?? 499;
      if (amt < minVal || amt > maxVal) {
        return 'MUST BE KES $minVal TO $maxVal';
      }
    } else if (amt != widget.offer.fixedPriceKes) {
      return 'MUST BE KES ${widget.offer.fixedPriceKes}';
    }
    return null;
  }

  void _confirmAndPay() {
    if (!widget.storeOpen) {
      setState(() => _statusMsg = 'STORE IS CLOSED. ORDERS DISABLED.');
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final amount = int.parse(_amountCtrl.text.trim());
    final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';

    widget.onRecordStkAttempt(
      OrderRecord(
        orderId: orderId,
        network: widget.offer.network,
        bundleName: widget.offer.name,
        recipientPhone: _recipientCtrl.text.trim(),
        paymentPhone: _paymentCtrl.text.trim(),
        amountKes: amount,
        paymentRef: 'AWAITING DARAJA CALLBACK',
        dateLabel: 'NOW',
        paymentStatus: 'PENDING CALLBACK VERIFICATION',
        deliveryStatus: 'WAITING PROVIDER CONFIRMATION',
      ),
    );

    setState(() {
      _statusMsg =
          'STK PUSH REQUEST LOGGED ($orderId). CONNECT DARAJA BACKEND TO VERIFY CALLBACK BEFORE CONFIRMING DELIVERY.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BSColors.pureWhite,
      appBar: AppBar(
        backgroundColor: BSColors.pureWhite,
        title: const Text(
          'BUY / CONFIRM',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: BSColors.pureWhite,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: BSColors.cardBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NETWORK: ${widget.offer.network}', style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text('BUNDLE: ${widget.offer.name}', style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text('AMOUNT: ${widget.offer.priceLabel}', style: const TextStyle(fontWeight: FontWeight.w800, color: BSColors.primaryGreen)),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text('RECIPIENT PHONE', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _recipientCtrl,
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
                style: const TextStyle(fontWeight: FontWeight.w800),
                decoration: const InputDecoration(hintText: '07XXXXXXXX', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              const Text('PAYMENT PHONE (M-PESA STK PUSH)', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _paymentCtrl,
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
                style: const TextStyle(fontWeight: FontWeight.w800),
                decoration: const InputDecoration(hintText: '07XXXXXXXX', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              const Text('AMOUNT (KES)', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _amountCtrl,
                readOnly: !widget.offer.isFlexibleAmount,
                keyboardType: TextInputType.number,
                validator: _validateAmount,
                style: const TextStyle(fontWeight: FontWeight.w800),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _confirmAndPay,
                  child: const Text(
                    'CONFIRM & PAY',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                ),
              ),
              if (_statusMsg.isNotEmpty) ...[
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: BSColors.amberBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _statusMsg,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: BSColors.amberText,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ReferTabScreen extends StatelessWidget {
  final String referralCode;
  const ReferTabScreen({super.key, required this.referralCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BSColors.pureWhite,
      appBar: AppBar(
        backgroundColor: BSColors.pureWhite,
        title: const Text('REFER', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'INVITE FRIENDS & EARN REWARDS!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: BSColors.primaryGreen),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: BSColors.softGreenBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: BSColors.primaryGreen),
              ),
              child: Text(
                'YOUR REFERRAL CODE: $referralCode',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'INVITED LIST: NO REFERRALS RECORDED YET',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'REWARDS STATUS: PENDING / APPROVED (ADMIN CONTROLLED)',
              style: TextStyle(fontWeight: FontWeight.w800, color: BSColors.greyText),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryTabScreen extends StatelessWidget {
  final List<OrderRecord> orders;
  const HistoryTabScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BSColors.pureWhite,
      appBar: AppBar(
        backgroundColor: BSColors.pureWhite,
        title: const Text('HISTORY', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text(
                'NO ORDERS YET',
                style: TextStyle(fontWeight: FontWeight.w800, color: BSColors.greyText),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final o = orders[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: BSColors.pureWhite,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: BSColors.cardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ORDER ID: ${o.orderId}', style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text('NETWORK: ${o.network} | BUNDLE: ${o.bundleName}', style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text('RECIPIENT: ${o.recipientPhone} | AMOUNT: KES ${o.amountKes}', style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text('REF: ${o.paymentRef} | DATE: ${o.dateLabel}', style: const TextStyle(fontWeight: FontWeight.w800)),
                      Text('PAYMENT: ${o.paymentStatus}', style: const TextStyle(fontWeight: FontWeight.w800, color: BSColors.amberText)),
                      Text('DELIVERY: ${o.deliveryStatus}', style: const TextStyle(fontWeight: FontWeight.w800, color: BSColors.greyText)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class SupportTabScreen extends StatelessWidget {
  const SupportTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BSColors.pureWhite,
      appBar: AppBar(
        backgroundColor: BSColors.pureWhite,
        title: const Text('SUPPORT', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'WE ARE HERE TO HELP YOU!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: BSColors.primaryGreen),
            ),
            const SizedBox(height: 8),
            const Text(
              'Uko na shida na order? Tuambie, tunakusaidia haraka!',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'WHATSAPP: ${Catalogue68.whatsappPhone}',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.chat),
                label: const Text(
                  'WHATSAPP US 0794363801',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'CALL US: ${Catalogue68.callPhone}',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: BSColors.primaryGreen, width: 1.6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                icon: const Icon(Icons.call, color: BSColors.primaryGreen),
                label: const Text(
                  'CALL US 0794 363801',
                  style: TextStyle(fontWeight: FontWeight.w800, color: BSColors.primaryGreen),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  final String userName;
  final String userPhone;
  final ValueChanged<String> onUpdatePin;
  final VoidCallback onLogout;
  final VoidCallback onOpenAdmin;

  const AccountScreen({
    super.key,
    required this.userName,
    required this.userPhone,
    required this.onUpdatePin,
    required this.onLogout,
    required this.onOpenAdmin,
  });

  @override
  Widget build(BuildContext context) {
    final pinCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: BSColors.pureWhite,
      appBar: AppBar(
        backgroundColor: BSColors.pureWhite,
        title: const Text('ACCOUNT', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('NAME: $userName', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 6),
          Text('PHONE: $userPhone', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: BSColors.greyText)),
          const SizedBox(height: 18),
          const Text('CHANGE 4-DIGIT PIN', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: pinCtrl,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  obscureText: true,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                  decoration: const InputDecoration(hintText: 'NEW PIN', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  if (pinCtrl.text.trim().length == 4) {
                    onUpdatePin(pinCtrl.text.trim());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('PIN UPDATED', style: TextStyle(fontWeight: FontWeight.w800))),
                    );
                  }
                },
                child: const Text('SAVE', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const Divider(height: 28),
          const Text('NOTIFICATIONS: ENABLED', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          const Text('TERMS & CONDITIONS: DIRECT STK PUSH ONLY', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          const Text('PRIVACY POLICY: SECRETS STORED ON SERVER ONLY', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              onOpenAdmin();
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: BSColors.primaryGreen, width: 1.6),
            ),
            child: const Text(
              'ADMIN DASHBOARD',
              style: TextStyle(fontWeight: FontWeight.w800, color: BSColors.primaryGreen),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onLogout();
            },
            style: ElevatedButton.styleFrom(backgroundColor: BSColors.dangerRed),
            child: const Text('LOGOUT', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}

class AdminDashboardScreen extends StatefulWidget {
  final bool storeOpen;
  final List<OfferModel> offers;
  final List<String> ads;
  final List<OrderRecord> orders;
  final ValueChanged<bool> onToggleStore;
  final ValueChanged<OfferModel> onAddOffer;
  final ValueChanged<OfferModel> onEditOffer;
  final ValueChanged<String> onDeleteOffer;
  final ValueChanged<String> onAddAd;
  final ValueChanged<int> onRemoveAd;

  const AdminDashboardScreen({
    super.key,
    required this.storeOpen,
    required this.offers,
    required this.ads,
    required this.orders,
    required this.onToggleStore,
    required this.onAddOffer,
    required this.onEditOffer,
    required this.onDeleteOffer,
    required this.onAddAd,
    required this.onRemoveAd,
  });

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  String _selectedNet = 'SAFARICOM';
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _validityCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController(text: 'DATA');
  final _adCtrl = TextEditingController();

  void _addNewOffer() {
    final name = _nameCtrl.text.trim();
    final priceNum = int.tryParse(_priceCtrl.text.trim());
    final validity = _validityCtrl.text.trim();
    if (name.isEmpty || priceNum == null || validity.isEmpty) return;

    widget.onAddOffer(
      OfferModel(
        id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
        network: _selectedNet,
        name: name,
        priceLabel: 'KES $priceNum',
        fixedPriceKes: priceNum,
        validity: validity,
        category: _categoryCtrl.text.trim().isEmpty ? 'DATA' : _categoryCtrl.text.trim().toUpperCase(),
      ),
    );
    _nameCtrl.clear();
    _priceCtrl.clear();
    _validityCtrl.clear();
    setState(() {});
  }

  void _confirmDelete(OfferModel offer) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('DELETE OFFER PERMANENTLY?', style: TextStyle(fontWeight: FontWeight.w800)),
        content: Text('${offer.network} - ${offer.name} (${offer.priceLabel})', style: const TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('CANCEL', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
          TextButton(
            onPressed: () {
              widget.onDeleteOffer(offer.id);
              Navigator.pop(ctx);
              setState(() {});
            },
            child: const Text('DELETE', style: TextStyle(fontWeight: FontWeight.w800, color: BSColors.dangerRed)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BSColors.pureWhite,
      appBar: AppBar(
        backgroundColor: BSColors.pureWhite,
        title: const Text('ADMIN DASHBOARD', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'STATS: TOTAL OFFERS ${widget.offers.length} | LOGGED ORDERS ${widget.orders.length}',
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            title: Text(
              widget.storeOpen ? 'STORE STATUS: OPEN' : 'STORE STATUS: CLOSED',
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            value: widget.storeOpen,
            activeTrackColor: BSColors.primaryGreen,
            onChanged: (val) {
              widget.onToggleStore(val);
              setState(() {});
            },
          ),
          const Divider(height: 24),
          const Text('MANAGE ADS', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _adCtrl,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                  decoration: const InputDecoration(hintText: 'NEW AD TEXT', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (_adCtrl.text.trim().isNotEmpty) {
                    widget.onAddAd(_adCtrl.text.trim());
                    _adCtrl.clear();
                    setState(() {});
                  }
                },
                child: const Text('ADD AD', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          ...List.generate(
            widget.ads.length,
            (i) => ListTile(
              title: Text(widget.ads[i], style: const TextStyle(fontWeight: FontWeight.w800)),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: BSColors.dangerRed),
                onPressed: () {
                  widget.onRemoveAd(i);
                  setState(() {});
                },
              ),
            ),
          ),
          const Divider(height: 24),
          const Text('ADD NEW OFFER', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _selectedNet,
            items: const ['SAFARICOM', 'AIRTEL', 'TELKOM', 'FAIBA']
                .map((n) => DropdownMenuItem(value: n, child: Text(n, style: const TextStyle(fontWeight: FontWeight.w800))))
                .toList(),
            onChanged: (v) => setState(() => _selectedNet = v ?? 'SAFARICOM'),
          ),
          const SizedBox(height: 8),
          TextField(controller: _nameCtrl, style: const TextStyle(fontWeight: FontWeight.w800), decoration: const InputDecoration(hintText: 'OFFER NAME (E.G. 2GB)', border: OutlineInputBorder())),
          const SizedBox(height: 8),
          TextField(controller: _priceCtrl, keyboardType: TextInputType.number, style: const TextStyle(fontWeight: FontWeight.w800), decoration: const InputDecoration(hintText: 'PRICE IN KES (E.G. 110)', border: OutlineInputBorder())),
          const SizedBox(height: 8),
          TextField(controller: _validityCtrl, style: const TextStyle(fontWeight: FontWeight.w800), decoration: const InputDecoration(hintText: 'VALIDITY (E.G. 24Hrs)', border: OutlineInputBorder())),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _addNewOffer,
            child: const Text('ADD OFFER', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
          const Divider(height: 24),
          const Text('MANAGE OFFERS (HIDE / SHOW / DELETE)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 8),
          ...widget.offers.map(
            (offer) => ListTile(
              title: Text(
                '${offer.network} | ${offer.name} (${offer.priceLabel})',
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
              ),
              subtitle: Text(
                offer.isVisible ? 'VISIBLE' : 'HIDDEN',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: offer.isVisible ? BSColors.primaryGreen : BSColors.greyText,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(offer.isVisible ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      widget.onEditOffer(offer.copyWith(isVisible: !offer.isVisible));
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: BSColors.dangerRed),
                    onPressed: () => _confirmDelete(offer),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
