enum NetworkType {
  safaricom,
  airtel,
  telkom,
  faiba;

  String get displayName {
    switch (this) {
      case NetworkType.safaricom:
        return 'SAFARICOM';
      case NetworkType.airtel:
        return 'AIRTEL';
      case NetworkType.telkom:
        return 'TELKOM';
      case NetworkType.faiba:
        return 'FAIBA';
    }
  }

  String get apiKey => name.toUpperCase();

  static NetworkType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'SAFARICOM':
        return NetworkType.safaricom;
      case 'AIRTEL':
        return NetworkType.airtel;
      case 'TELKOM':
        return NetworkType.telkom;
      case 'FAIBA':
        return NetworkType.faiba;
      default:
        return NetworkType.safaricom;
    }
  }
}

enum BundleCategory {
  all,
  data,
  sms,
  minutes,
  combo,
  noExpiry;

  String get label {
    switch (this) {
      case BundleCategory.all:
        return 'ALL';
      case BundleCategory.data:
        return 'DATA';
      case BundleCategory.sms:
        return 'SMS';
      case BundleCategory.minutes:
        return 'MINUTES';
      case BundleCategory.combo:
        return 'COMBO';
      case BundleCategory.noExpiry:
        return 'NO EXPIRY';
    }
  }

  static BundleCategory fromString(String value) {
    final normalized = value.toUpperCase().replaceAll(' ', '_');
    switch (normalized) {
      case 'ALL':
        return BundleCategory.all;
      case 'DATA':
        return BundleCategory.data;
      case 'SMS':
        return BundleCategory.sms;
      case 'MINUTES':
        return BundleCategory.minutes;
      case 'COMBO':
        return BundleCategory.combo;
      case 'NO_EXPIRY':
      case 'NOEXPIRY':
        return BundleCategory.noExpiry;
      default:
        return BundleCategory.all;
    }
  }
}

class BundleOffer {
  final String id;
  final NetworkType network;
  final BundleCategory category;
  final String name;
  final int? priceKes;
  final int? minCustomAmount;
  final int? maxCustomAmount;
  final String validity;
  final bool isPopular;
  final bool isActive;
  final String? providerProductCode;

  const BundleOffer({
    required this.id,
    required this.network,
    required this.category,
    required this.name,
    this.priceKes,
    this.minCustomAmount,
    this.maxCustomAmount,
    required this.validity,
    this.isPopular = false,
    this.isActive = true,
    this.providerProductCode,
  });

  bool get isCustomAmount => priceKes == null;

  String get priceDisplay {
    if (priceKes != null) {
      return 'KES ${_formatWithCommas(priceKes!)}';
    }
    if (minCustomAmount != null && maxCustomAmount != null) {
      return 'Customer chooses KES $minCustomAmount–$maxCustomAmount';
    }
    return 'Custom Amount';
  }

  static String _formatWithCommas(int amount) {
    final digits = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  BundleOffer copyWith({
    String? id,
    NetworkType? network,
    BundleCategory? category,
    String? name,
    int? priceKes,
    int? minCustomAmount,
    int? maxCustomAmount,
    String? validity,
    bool? isPopular,
    bool? isActive,
    String? providerProductCode,
  }) {
    return BundleOffer(
      id: id ?? this.id,
      network: network ?? this.network,
      category: category ?? this.category,
      name: name ?? this.name,
      priceKes: priceKes ?? this.priceKes,
      minCustomAmount: minCustomAmount ?? this.minCustomAmount,
      maxCustomAmount: maxCustomAmount ?? this.maxCustomAmount,
      validity: validity ?? this.validity,
      isPopular: isPopular ?? this.isPopular,
      isActive: isActive ?? this.isActive,
      providerProductCode: providerProductCode ?? this.providerProductCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'network': network.apiKey,
      'category': category.name.toUpperCase(),
      'name': name,
      'priceKes': priceKes,
      'minCustomAmount': minCustomAmount,
      'maxCustomAmount': maxCustomAmount,
      'validity': validity,
      'isPopular': isPopular,
      'isActive': isActive,
      'providerProductCode': providerProductCode,
    };
  }

  factory BundleOffer.fromJson(Map<String, dynamic> json) {
    return BundleOffer(
      id: json['id'] as String,
      network: NetworkType.fromString(json['network'] as String),
      category: BundleCategory.fromString(json['category'] as String),
      name: json['name'] as String,
      priceKes: json['priceKes'] as int?,
      minCustomAmount: json['minCustomAmount'] as int?,
      maxCustomAmount: json['maxCustomAmount'] as int?,
      validity: json['validity'] as String,
      isPopular: (json['isPopular'] as bool?) ?? false,
      isActive: (json['isActive'] as bool?) ?? true,
      providerProductCode: json['providerProductCode'] as String?,
    );
  }
}

class OfficialCatalogueSeed {
  static const List<BundleOffer> offers = [
    // A. SAFARICOM
    BundleOffer(
      id: 'saf_combo_10mb_7sms_8',
      network: NetworkType.safaricom,
      category: BundleCategory.combo,
      name: '10MB + 7 SMS',
      priceKes: 8,
      validity: '24 Hrs / Daily',
      isPopular: true,
    ),
    BundleOffer(
      id: 'saf_data_250mb_20',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '250MB',
      priceKes: 20,
      validity: '24 Hrs / Daily',
    ),
    BundleOffer(
      id: 'saf_data_1gb_21',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '1GB',
      priceKes: 21,
      validity: '1 Hr / Hourly',
      isPopular: true,
    ),
    BundleOffer(
      id: 'saf_data_450mb_32',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '450MB',
      priceKes: 32,
      validity: 'Till Midnight / Daily',
    ),
    BundleOffer(
      id: 'saf_data_1_5gb_53',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '1.5GB',
      priceKes: 53,
      validity: '3 Hrs / Hourly',
    ),
    BundleOffer(
      id: 'saf_combo_750mb_50sms_54',
      network: NetworkType.safaricom,
      category: BundleCategory.combo,
      name: '750MB + 50 SMS',
      priceKes: 54,
      validity: '24 Hrs / Daily',
    ),
    BundleOffer(
      id: 'saf_data_800mb_55',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '800MB',
      priceKes: 55,
      validity: 'Till Midnight / Daily',
    ),
    BundleOffer(
      id: 'saf_data_400mb_56',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '400MB',
      priceKes: 56,
      validity: '7 Days / Weekly',
    ),
    BundleOffer(
      id: 'saf_data_900mb_58',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '900MB',
      priceKes: 58,
      validity: 'Till Midnight / Daily',
    ),
    BundleOffer(
      id: 'saf_data_1gb_60',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '1GB',
      priceKes: 60,
      validity: 'Till Midnight / Daily',
      isPopular: true,
    ),
    BundleOffer(
      id: 'saf_data_1_25gb_78',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '1.25GB',
      priceKes: 78,
      validity: 'Till Midnight / Daily',
    ),
    BundleOffer(
      id: 'saf_combo_1_5gb_40sms_wa_106',
      network: NetworkType.safaricom,
      category: BundleCategory.combo,
      name: '1.5GB + 40 SMS + WhatsApp',
      priceKes: 106,
      validity: '24 Hrs / Daily',
    ),
    BundleOffer(
      id: 'saf_data_1_1gb_yt_110',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '1.1GB + Free YouTube',
      priceKes: 110,
      validity: '7 Days / Weekly',
    ),
    BundleOffer(
      id: 'saf_data_5gb_255',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '5GB',
      priceKes: 255,
      validity: '3 Days',
      isPopular: true,
    ),
    BundleOffer(
      id: 'saf_data_2_5gb_256',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '2.5GB',
      priceKes: 256,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'saf_combo_4gb_220mins_50sms_505',
      network: NetworkType.safaricom,
      category: BundleCategory.combo,
      name: '4GB + 220 Mins + 50 SMS',
      priceKes: 505,
      validity: '7 Days / Weekly',
    ),
    BundleOffer(
      id: 'saf_data_11gb_yt_509',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '11GB + Free YouTube',
      priceKes: 509,
      validity: '7 Days / Weekly',
    ),
    BundleOffer(
      id: 'saf_data_21gb_1006',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '21GB',
      priceKes: 1006,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'saf_data_150gb_5012',
      network: NetworkType.safaricom,
      category: BundleCategory.data,
      name: '150GB',
      priceKes: 5012,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'saf_mins_45_23',
      network: NetworkType.safaricom,
      category: BundleCategory.minutes,
      name: '45 Mins',
      priceKes: 23,
      validity: '3 Hrs / Hourly',
    ),
    BundleOffer(
      id: 'saf_mins_500flex_34',
      network: NetworkType.safaricom,
      category: BundleCategory.minutes,
      name: '500 Flex',
      priceKes: 34,
      validity: '2 Hrs / Hourly',
    ),
    BundleOffer(
      id: 'saf_mins_350flex_65',
      network: NetworkType.safaricom,
      category: BundleCategory.minutes,
      name: '350 Flex',
      priceKes: 65,
      validity: 'Till Midnight / Daily',
    ),
    BundleOffer(
      id: 'saf_mins_1000flex_107',
      network: NetworkType.safaricom,
      category: BundleCategory.minutes,
      name: '1000 Flex',
      priceKes: 107,
      validity: 'Till Midnight / Daily',
    ),
    BundleOffer(
      id: 'saf_mins_300_506',
      network: NetworkType.safaricom,
      category: BundleCategory.minutes,
      name: '300 Mins',
      priceKes: 506,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'saf_mins_1000_1017',
      network: NetworkType.safaricom,
      category: BundleCategory.minutes,
      name: '1000 Mins',
      priceKes: 1017,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'saf_mins_1250_1019',
      network: NetworkType.safaricom,
      category: BundleCategory.minutes,
      name: '1250 Mins',
      priceKes: 1019,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'saf_sms_200_12',
      network: NetworkType.safaricom,
      category: BundleCategory.sms,
      name: '200 SMS',
      priceKes: 12,
      validity: '24 Hrs / Daily',
    ),
    BundleOffer(
      id: 'saf_sms_unlim_28',
      network: NetworkType.safaricom,
      category: BundleCategory.sms,
      name: 'Unlimited SMS',
      priceKes: 28,
      validity: '24 Hrs / Daily',
    ),
    BundleOffer(
      id: 'saf_sms_1000_33',
      network: NetworkType.safaricom,
      category: BundleCategory.sms,
      name: '1000 SMS',
      priceKes: 33,
      validity: '7 Days / Weekly',
    ),
    BundleOffer(
      id: 'saf_sms_unlim_64',
      network: NetworkType.safaricom,
      category: BundleCategory.sms,
      name: 'Unlimited SMS',
      priceKes: 64,
      validity: '7 Days / Weekly',
    ),
    BundleOffer(
      id: 'saf_sms_1500_103',
      network: NetworkType.safaricom,
      category: BundleCategory.sms,
      name: '1500 SMS',
      priceKes: 103,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'saf_sms_3500_209',
      network: NetworkType.safaricom,
      category: BundleCategory.sms,
      name: '3500 SMS',
      priceKes: 209,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'saf_no_expiry_airtime',
      network: NetworkType.safaricom,
      category: BundleCategory.noExpiry,
      name: 'No Expiry Airtime',
      priceKes: null,
      minCustomAmount: 1,
      maxCustomAmount: 499,
      validity: 'No Expiry',
    ),
    BundleOffer(
      id: 'saf_no_expiry_data',
      network: NetworkType.safaricom,
      category: BundleCategory.noExpiry,
      name: 'No Expiry Data',
      priceKes: null,
      minCustomAmount: 1,
      maxCustomAmount: 499,
      validity: 'No Expiry',
    ),

    // B. AIRTEL
    BundleOffer(
      id: 'air_sms_6_5',
      network: NetworkType.airtel,
      category: BundleCategory.sms,
      name: '6 SMS',
      priceKes: 5,
      validity: '24 Hrs / Daily',
    ),
    BundleOffer(
      id: 'air_sms_40_6',
      network: NetworkType.airtel,
      category: BundleCategory.sms,
      name: '40 SMS',
      priceKes: 6,
      validity: '24 Hrs / Daily',
    ),
    BundleOffer(
      id: 'air_sms_1200_onnet_13',
      network: NetworkType.airtel,
      category: BundleCategory.sms,
      name: '1200 On-Net SMS',
      priceKes: 13,
      validity: '24 Hrs / Daily',
    ),
    BundleOffer(
      id: 'air_sms_250_15',
      network: NetworkType.airtel,
      category: BundleCategory.sms,
      name: '250 SMS',
      priceKes: 15,
      validity: '24 Hrs / Daily',
    ),
    BundleOffer(
      id: 'air_sms_500_24',
      network: NetworkType.airtel,
      category: BundleCategory.sms,
      name: '500 SMS',
      priceKes: 24,
      validity: '24 Hrs / Daily',
    ),
    BundleOffer(
      id: 'air_mins_50_27',
      network: NetworkType.airtel,
      category: BundleCategory.minutes,
      name: '50 Mins',
      priceKes: 27,
      validity: '2 Days',
    ),
    BundleOffer(
      id: 'air_mins_350_61',
      network: NetworkType.airtel,
      category: BundleCategory.minutes,
      name: '350 Airtel Mins',
      priceKes: 61,
      validity: '7 Days / Weekly',
    ),
    BundleOffer(
      id: 'air_mins_1500_160',
      network: NetworkType.airtel,
      category: BundleCategory.minutes,
      name: '1500 Airtel Mins',
      priceKes: 160,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'air_data_3gb_261',
      network: NetworkType.airtel,
      category: BundleCategory.data,
      name: '3GB',
      priceKes: 261,
      validity: '30 Days / Monthly',
      isPopular: true,
    ),
    BundleOffer(
      id: 'air_data_12gb_510',
      network: NetworkType.airtel,
      category: BundleCategory.data,
      name: '12GB',
      priceKes: 510,
      validity: '7 Days / Weekly',
    ),
    BundleOffer(
      id: 'air_data_8gb_511',
      network: NetworkType.airtel,
      category: BundleCategory.data,
      name: '8GB',
      priceKes: 511,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'air_data_25gb_1015',
      network: NetworkType.airtel,
      category: BundleCategory.data,
      name: '25GB',
      priceKes: 1015,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'air_data_55gb_2017',
      network: NetworkType.airtel,
      category: BundleCategory.data,
      name: '55GB',
      priceKes: 2017,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'air_data_55gb_6020',
      network: NetworkType.airtel,
      category: BundleCategory.data,
      name: '55GB',
      priceKes: 6020,
      validity: '90 Days / Quarterly',
    ),

    // C. TELKOM
    BundleOffer(
      id: 'tel_combo_madaraka_life_63',
      network: NetworkType.telkom,
      category: BundleCategory.combo,
      name: 'Madaraka Life Includes: 1GB + 100 Onnet Mins',
      priceKes: 63,
      validity: '30 Days / Monthly',
      isPopular: true,
    ),
    BundleOffer(
      id: 'tel_combo_mambo_199_204',
      network: NetworkType.telkom,
      category: BundleCategory.combo,
      name: 'Mambo 199 Includes: 6GB + 200 Telkom Mins',
      priceKes: 204,
      validity: '30 Days / Monthly',
    ),

    // D. FAIBA
    BundleOffer(
      id: 'fai_data_500mb_26',
      network: NetworkType.faiba,
      category: BundleCategory.data,
      name: '500MB',
      priceKes: 26,
      validity: '24 Hrs / Daily',
    ),
    BundleOffer(
      id: 'fai_data_1_5gb_59',
      network: NetworkType.faiba,
      category: BundleCategory.data,
      name: '1.5GB',
      priceKes: 59,
      validity: '24 Hrs / Daily',
      isPopular: true,
    ),
    BundleOffer(
      id: 'fai_data_3gb_109',
      network: NetworkType.faiba,
      category: BundleCategory.data,
      name: '3GB',
      priceKes: 109,
      validity: '3 Days',
    ),
    BundleOffer(
      id: 'fai_data_10gb_311',
      network: NetworkType.faiba,
      category: BundleCategory.data,
      name: '10GB',
      priceKes: 311,
      validity: '7 Days / Weekly',
    ),
    BundleOffer(
      id: 'fai_data_15gb_520',
      network: NetworkType.faiba,
      category: BundleCategory.data,
      name: '15GB',
      priceKes: 520,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'fai_data_40gb_1014',
      network: NetworkType.faiba,
      category: BundleCategory.data,
      name: '40GB',
      priceKes: 1014,
      validity: '30 Days / Monthly',
    ),
    BundleOffer(
      id: 'fai_data_120gb_2020',
      network: NetworkType.faiba,
      category: BundleCategory.data,
      name: '120GB',
      priceKes: 2020,
      validity: '30 Days / Monthly',
    ),
  ];
}
