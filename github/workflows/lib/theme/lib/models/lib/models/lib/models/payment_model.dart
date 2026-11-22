enum PaymentMethodType {
  stkPush,
  manualTill,
}

enum PaymentRecordStatus {
  pending,
  confirmed,
  failed,
  cancelled,
  timeout,
  reconciliationPending;

  String get label {
    switch (this) {
      case PaymentRecordStatus.pending:
        return 'Pending Confirmation';
      case PaymentRecordStatus.confirmed:
        return 'Payment Confirmed';
      case PaymentRecordStatus.failed:
        return 'Payment Failed';
      case PaymentRecordStatus.cancelled:
        return 'Cancelled';
      case PaymentRecordStatus.timeout:
        return 'Timed Out';
      case PaymentRecordStatus.reconciliationPending:
        return 'Awaiting Verification';
    }
  }
}

class PaymentModel {
  final String paymentId;
  final String orderId;
  final PaymentMethodType method;
  final String paymentPhone;
  final int amountKes;
  final String? referenceCode;
  final PaymentRecordStatus status;
  final String? statusMessage;
  final DateTime timestamp;

  const PaymentModel({
    required this.paymentId,
    required this.orderId,
    required this.method,
    required this.paymentPhone,
    required this.amountKes,
    this.referenceCode,
    required this.status,
    this.statusMessage,
    required this.timestamp,
  });

  PaymentModel copyWith({
    String? paymentId,
    String? orderId,
    PaymentMethodType? method,
    String? paymentPhone,
    int? amountKes,
    String? referenceCode,
    PaymentRecordStatus? status,
    String? statusMessage,
    DateTime? timestamp,
  }) {
    return PaymentModel(
      paymentId: paymentId ?? this.paymentId,
      orderId: orderId ?? this.orderId,
      method: method ?? this.method,
      paymentPhone: paymentPhone ?? this.paymentPhone,
      amountKes: amountKes ?? this.amountKes,
      referenceCode: referenceCode ?? this.referenceCode,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
