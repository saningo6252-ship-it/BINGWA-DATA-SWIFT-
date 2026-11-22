class UserModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String referralCode;
  final String? referredByCode;
  final int totalInvited;
  final int eligibleReferrals;
  final int approvedRewardKes;
  final int pendingRewardKes;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.referralCode,
    this.referredByCode,
    this.totalInvited = 0,
    this.eligibleReferrals = 0,
    this.approvedRewardKes = 0,
    this.pendingRewardKes = 0,
    required this.createdAt,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? referralCode,
    String? referredByCode,
    int? totalInvited,
    int? eligibleReferrals,
    int? approvedRewardKes,
    int? pendingRewardKes,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      referralCode: referralCode ?? this.referralCode,
      referredByCode: referredByCode ?? this.referredByCode,
      totalInvited: totalInvited ?? this.totalInvited,
      eligibleReferrals: eligibleReferrals ?? this.eligibleReferrals,
      approvedRewardKes: approvedRewardKes ?? this.approvedRewardKes,
      pendingRewardKes: pendingRewardKes ?? this.pendingRewardKes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'referralCode': referralCode,
      'referredByCode': referredByCode,
      'totalInvited': totalInvited,
      'eligibleReferrals': eligibleReferrals,
      'approvedRewardKes': approvedRewardKes,
      'pendingRewardKes': pendingRewardKes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      referralCode: json['referralCode'] as String,
      referredByCode: json['referredByCode'] as String?,
      totalInvited: (json['totalInvited'] as int?) ?? 0,
      eligibleReferrals: (json['eligibleReferrals'] as int?) ?? 0,
      approvedRewardKes: (json['approvedRewardKes'] as int?) ?? 0,
      pendingRewardKes: (json['pendingRewardKes'] as int?) ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
