import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bundle_model.dart';
import '../models/order_model.dart';
import '../models/payment_model.dart';
import '../models/user_model.dart';

class PromoAd {
  final String id;
  final String title;
  final String subtitle;
  final String tag;
  final bool isActive;
  final int clicks;

  const PromoAd({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.tag,
    this.isActive = true,
    this.clicks = 0,
  });

  PromoAd copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? tag,
    bool? isActive,
    int? clicks,
  }) {
    return PromoAd(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      tag: tag ?? this.tag,
      isActive: isActive ?? this.isActive,
      clicks: clicks ?? this.clicks,
    );
  }
}

class AppStateService extends ChangeNotifier {
  static const String _pinStorageKey = 'bingwa_user_pin_hash';
  static const String _userPrefsKey = 'bingwa_user_json';
  static const String _loggedInKey = 'bingwa_is_logged_in';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  String backendBaseUrl = const String.fromEnvironment(
    'BACKEND_BASE_URL',
    defaultValue: '',
  );

  bool isStoreOpen = true;
  UserModel? currentUser;
  bool isLoggedIn = false;
  int referralRewardAmountKes = 50;
  String referralConditionText =
      'Friend completes first confirmed purchase of KES 50+';

  final List<BundleOffer> _offers =
      List<BundleOffer>.from(OfficialCatalogueSeed.offers);
  final List<OrderModel> _orders = [];
  final List<PaymentModel> _payments = [];
  final List<String> _notifications = [
    'Welcome to BINGWA SOKONI DATA SWIFT! Direct M-PESA & Manual Till 1765260 supported.',
  ];

  final List<PromoAd> _ads = [
    const PromoAd(
      id: 'ad_1',
      title: 'Fast Data, Minutes & SMS Bundles',
      subtitle: 'Instant delivery for Safaricom, Airtel, Telkom & Faiba.',
      tag: 'NEW BUNDLES',
      isActive: true,
    ),
    const PromoAd(
      id: 'ad_2',
      title: 'Invite Friends & Earn Rewards',
      subtitle: 'Share your referral code via WhatsApp or SMS.',
      tag: 'REFER & EARN',
      isActive: true,
    ),
  ];

  List<BundleOffer> get offers => List.unmodifiable(_offers);
  List<OrderModel> get orders => List.unmodifiable(_orders);
  List<PaymentModel> get payments => List.unmodifiable(_payments);
  List<String> get notifications => List.unmodifiable(_notifications);
  List<PromoAd> get activeAds => _ads.where((a) => a.isActive).toList();
  List<PromoAd> get allAds => List.unmodifiable(_ads);

  List<BundleOffer> getSpecialOffers() {
    return _offers.where((o) => o.isActive && o.isPopular).toList();
  }

  List<BundleOffer> getOffersForNetwork(NetworkType network) {
    return _offers.where((o) => o.isActive && o.network == network).toList();
  }

  Future<void> initializeSession() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool(_loggedInKey) ?? false;
    final rawUser = prefs.getString(_userPrefsKey);
    if (rawUser != null && rawUser.isNotEmpty) {
      currentUser =
          UserModel.fromJson(jsonDecode(rawUser) as Map<String, dynamic>);
    }
    notifyListeners();
  }

  String _hashPin(String phone, String pin) {
    final input = '$phone:$pin:bingwa_sokoni_salt';
    var hash = 2166136261;
    for (final codeUnit in input.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 16777619) & 0xFFFFFFFF;
    }
    return hash.toRadixString(16);
  }

  bool isPhoneAlreadyRegistered(String normalizedPhone) {
    if (currentUser != null && currentUser!.phoneNumber == normalizedPhone) {
      return true;
    }
    return false;
  }

  Future<String?> registerCustomer({
    required String fullName,
    required String phoneNumber,
    required String pin,
    String? referredByCode,
  }) async {
    final cleanPhone = normalizeKenyanPhone(phoneNumber);
    if (cleanPhone == null) {
      return 'Enter a valid Kenyan phone number (e.g. 07XXXXXXXX or 01XXXXXXXX).';
    }
    if (isPhoneAlreadyRegistered(cleanPhone)) {
      return 'This phone number is already registered. Please log in with your PIN.';
    }
    if (pin.length != 4 || int.tryParse(pin) == null) {
      return 'PIN must be a 4-digit number.';
    }

    final codeDigits = cleanPhone.substring(cleanPhone.length - 4);
    final user = UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      fullName: fullName.trim(),
      phoneNumber: cleanPhone,
      referralCode: 'BS$codeDigits',
      referredByCode: referredByCode?.trim().isEmpty == true
          ? null
          : referredByCode?.trim().toUpperCase(),
      createdAt: DateTime.now(),
    );

    await _secureStorage.write(
      key: _pinStorageKey,
      value: _hashPin(cleanPhone, pin),
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userPrefsKey, jsonEncode(user.toJson()));
    await prefs.setBool(_loggedInKey, true);

    currentUser = user;
    isLoggedIn = true;
    addNotification('Account created for ${user.fullName}.');
    notifyListeners();
    return null;
  }

  Future<bool> loginWithPin(String pin) async {
    if (currentUser == null) return false;
    final storedHash = await _secureStorage.read(key: _pinStorageKey);
    if (storedHash == null) return false;
    final matches = storedHash == _hashPin(currentUser!.phoneNumber, pin);
    if (matches) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_loggedInKey, true);
      isLoggedIn = true;
      notifyListeners();
    }
    return matches;
  }

  Future<String?> resetPin(String newPin) async {
    if (currentUser == null) return 'No customer account found.';
    if (newPin.length != 4 || int.tryParse(newPin) == null) {
      return 'Enter a 4-digit numeric PIN.';
    }
    await _secureStorage.write(
      key: _pinStorageKey,
      value: _hashPin(currentUser!.phoneNumber, newPin),
    );
    addNotification('Your security PIN was updated.');
    notifyListeners();
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
    isLoggedIn = false;
    notifyListeners();
  }

  Future<({bool sent, String message})> requestOtp(String phoneNumber) async {
    final cleanPhone = normalizeKenyanPhone(phoneNumber);
    if (cleanPhone == null) {
      return (sent: false, message: 'Enter a valid Kenyan phone number.');
    }
    if (backendBaseUrl.isEmpty) {
      return (
        sent: false,
        message:
            'SMS OTP provider not configured yet. Set BACKEND_BASE_URL to connect your SMS gateway.',
      );
    }
    return (sent: false, message: 'Configure /api/auth/send-otp on backend.');
  }

  Future<({bool initiated, String? checkoutRequestId, String message})>
      initiateStkPush({
    required String orderId,
    required String paymentPhone,
    required int amountKes,
  }) async {
    if (!isStoreOpen) {
      return (
        initiated: false,
        checkoutRequestId: null,
        message: 'Store is currently closed and not accepting new orders.',
      );
    }
    if (backendBaseUrl.isEmpty) {
      return (
        initiated: false,
        checkoutRequestId: null,
        message:
            'STK Push backend endpoint not configured yet. Connect your existing STK Push API on the backend and pass BACKEND_BASE_URL.',
      );
    }
    return (
      initiated: false,
      checkoutRequestId: null,
      message: 'Connect backend STK Push endpoint for order $orderId.',
    );
  }

  void recordManualTillSubmission({
    required OrderModel order,
    required String mpesaReference,
  }) {
    final payment = PaymentModel(
      paymentId: 'PAY_${DateTime.now().millisecondsSinceEpoch}',
      orderId: order.orderId,
      method: PaymentMethodType.manualTill,
      paymentPhone: order.paymentPhone,
      amountKes: order.amountKes,
      referenceCode: mpesaReference.trim().toUpperCase(),
      status: PaymentRecordStatus.reconciliationPending,
      statusMessage: 'Submitted for verification against Till 1765260.',
      timestamp: DateTime.now(),
    );
    _payments.insert(0, payment);

    final updatedOrder = order.copyWith(
      paymentReference: payment.referenceCode,
      paymentStatus: PaymentRecordStatus.reconciliationPending.label,
      deliveryStatus: OrderLifecycleStatus.pendingPayment,
      deliveryNote:
          'Manual Till 1765260 payment requires verification before bundle delivery.',
    );
    _upsertOrder(updatedOrder);
    addNotification(
      'Order ${order.orderId} submitted with ref ${payment.referenceCode} for verification.',
    );
    notifyListeners();
  }

  void _upsertOrder(OrderModel order) {
    final idx = _orders.indexWhere((o) => o.orderId == order.orderId);
    if (idx >= 0) {
      _orders[idx] = order;
    } else {
      _orders.insert(0, order);
    }
  }

  void addNotification(String message) {
    _notifications.insert(0, message);
  }

  void setStoreOpen(bool open) {
    isStoreOpen = open;
    addNotification(
      open
          ? 'Store is now OPEN for orders.'
          : 'Store is temporarily CLOSED and not accepting new orders.',
    );
    notifyListeners();
  }

  void addOffer(BundleOffer offer) {
    _offers.insert(0, offer);
    notifyListeners();
  }

  void updateOffer(BundleOffer updated) {
    final idx = _offers.indexWhere((o) => o.id == updated.id);
    if (idx >= 0) {
      _offers[idx] = updated;
      notifyListeners();
    }
  }

  void deleteOffer(String id) {
    _offers.removeWhere((o) => o.id == id);
    notifyListeners();
  }

  void addAd(PromoAd ad) {
    _ads.insert(0, ad);
    notifyListeners();
  }

  void toggleAdActive(String id) {
    final idx = _ads.indexWhere((a) => a.id == id);
    if (idx >= 0) {
      _ads[idx] = _ads[idx].copyWith(isActive: !_ads[idx].isActive);
      notifyListeners();
    }
  }

  void deleteAd(String id) {
    _ads.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  void recordAdClick(String id) {
    final idx = _ads.indexWhere((a) => a.id == id);
    if (idx >= 0) {
      _ads[idx] = _ads[idx].copyWith(clicks: _ads[idx].clicks + 1);
      notifyListeners();
    }
  }

  void updateReferralSettings({
    required int rewardKes,
    required String condition,
  }) {
    referralRewardAmountKes = rewardKes;
    referralConditionText = condition;
    notifyListeners();
  }

  static String? normalizeKenyanPhone(String raw) {
    final digitsOnly = raw.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.startsWith('254') && digitsOnly.length == 12) {
      return '0${digitsOnly.substring(3)}';
    }
    if ((digitsOnly.startsWith('07') || digitsOnly.startsWith('01')) &&
        digitsOnly.length == 10) {
      return digitsOnly;
    }
    return null;
  }
}
