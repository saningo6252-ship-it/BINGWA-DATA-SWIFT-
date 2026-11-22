import 'bundle_model.dart';

enum OrderLifecycleStatus {
  pendingPayment('Pending Payment'),
  paymentFailed('Payment Failed'),
  paymentConfirmed('Payment Confirmed'),
  processingBundle('Processing Bundle'),
  delivered('Delivered'),
  deliveryFailed('Delivery Failed'),
  refundPending('Refund Pending'),
  refunded('Refunded');

  final String label;
  const OrderLifecycleStatus(this.label);

  static OrderLifecycleStatus fromLabel(String value) {
    return OrderLifecycleStatus.values.firstWhere(
      (e) =>
          e.label.toLowerCase() == value.toLowerCase() ||
          e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => OrderLifecycleStatus.pendingPayment,
    );
  }
}

class OrderModel {
  final String orderId;
  final NetworkType network;
  final String itemName;
  final bool isAirtime;
  final String recipientPhone;
  final String paymentPhone;
  final int amountKes;
  final String? paymentReference;
  final DateTime createdAt;
  final String paymentStatus;
  final OrderLifecycleStatus deliveryStatus;
  final String? deliveryNote;

  const OrderModel({
    required this.orderId,
    required this.network,
    required this.itemName,
    this.isAirtime = false,
    required this.recipientPhone,
    required this.paymentPhone,
    required this.amountKes,
    this.paymentReference,
    required this.createdAt,
    required this.paymentStatus,
    required this.deliveryStatus,
    this.deliveryNote,
  });

  OrderModel copyWith({
    String? orderId,
    NetworkType? network,
    String? itemName,
    bool? isAirtime,
    String? recipientPhone,
    String? paymentPhone,
    int? amountKes,
    String? paymentReference,
    DateTime? createdAt,
    String? paymentStatus,
    OrderLifecycleStatus? deliveryStatus,
    String? deliveryNote,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      network: network ?? this.network,
      itemName: itemName ?? this.itemName,
      isAirtime: isAirtime ?? this.isAirtime,
      recipientPhone: recipientPhone ?? this.recipientPhone,
      paymentPhone: paymentPhone ?? this.paymentPhone,
      amountKes: amountKes ?? this.amountKes,
      paymentReference: paymentReference ?? this.paymentReference,
      createdAt: createdAt ?? this.createdAt,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      deliveryNote: deliveryNote ?? this.deliveryNote,
    );
  }
}
