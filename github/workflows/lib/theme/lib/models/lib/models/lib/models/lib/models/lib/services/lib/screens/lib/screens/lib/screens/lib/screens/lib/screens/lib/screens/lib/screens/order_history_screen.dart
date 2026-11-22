import 'package:flutter/material.dart';
import '../models/bundle_model.dart';
import '../models/order_model.dart';
import '../services/app_state_service.dart';
import '../theme/app_theme.dart';
import 'airtime_screen.dart';
import 'purchase_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  final AppStateService appState;

  const OrderHistoryScreen({super.key, required this.appState});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  String _selectedFilter = 'ALL';

  static const List<String> _filters = [
    'ALL',
    'Pending Payment',
    'Payment Confirmed',
    'Processing Bundle',
    'Delivered',
    'Delivery Failed',
    'Refund Pending',
    'Refunded',
  ];

  List<OrderModel> _filteredOrders() {
    final all = widget.appState.orders;
    if (_selectedFilter == 'ALL') return all;
    return all
        .where((o) =>
            o.deliveryStatus.label.toLowerCase() ==
                _selectedFilter.toLowerCase() ||
            o.paymentStatus.toLowerCase() == _selectedFilter.toLowerCase())
        .toList();
  }

  void _onReorder(OrderModel order) {
    if (order.isAirtime) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AirtimeScreen(
            appState: widget.appState,
            initialNetwork: order.network,
          ),
        ),
      );
      return;
    }

    final matchedOffer = widget.appState.offers.cast<BundleOffer?>().firstWhere(
          (offer) =>
              offer != null &&
              offer.network == order.network &&
              offer.name == order.itemName,
          orElse: () => null,
        );

    final offerToUse = matchedOffer ??
        BundleOffer(
          id: 'reorder_${order.orderId}',
          network: order.network,
          category: BundleCategory.data,
          name: order.itemName,
          priceKes: order.amountKes,
          validity: 'Standard',
        );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PurchaseScreen(
          appState: widget.appState,
          network: order.network,
          offer: offerToUse,
        ),
      ),
    );
  }

  Color _statusColor(OrderLifecycleStatus status) {
    switch (status) {
      case OrderLifecycleStatus.delivered:
      case OrderLifecycleStatus.paymentConfirmed:
        return AppColors.primaryGreen;
      case OrderLifecycleStatus.processingBundle:
      case OrderLifecycleStatus.pendingPayment:
      case OrderLifecycleStatus.refundPending:
        return AppColors.warningAmber;
      case OrderLifecycleStatus.paymentFailed:
      case OrderLifecycleStatus.deliveryFailed:
        return AppColors.errorRed;
      case OrderLifecycleStatus.refunded:
        return AppColors.telkomBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = _filteredOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ORDER HISTORY'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 46,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final active = filter == _selectedFilter;
                return ChoiceChip(
                  label: Text(filter),
                  selected: active,
                  selectedColor: AppColors.primaryGreen,
                  labelStyle: TextStyle(
                    color: active ? AppColors.white : AppColors.darkText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (_) => setState(() => _selectedFilter = filter),
                );
              },
            ),
          ),
          Expanded(
            child: orders.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No orders found for the selected filter.',
                        style: TextStyle(
                          color: AppColors.mutedText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      final badgeColor = _statusColor(order.deliveryStatus);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(color: AppColors.borderGray),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order: ${order.orderId}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: badgeColor.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      order.deliveryStatus.label,
                                      style: TextStyle(
                                        color: badgeColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${order.network.displayName} • ${order.itemName}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Amount: KES ${order.amountKes} • Payment: ${order.paymentStatus}',
                                style: const TextStyle(fontSize: 13),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Recipient: ${order.recipientPhone} • Paid via: ${order.paymentPhone}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.mutedText,
                                ),
                              ),
                              if (order.paymentReference != null) ...[
                                const SizedBox(height: 2),
                                Text(
                                  'Ref: ${order.paymentReference}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                              ],
                              if (order.deliveryNote != null) ...[
                                const SizedBox(height: 6),
                                Text(
                                  order.deliveryNote!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.mutedText,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: OutlinedButton.icon(
                                  onPressed: () => _onReorder(order),
                                  icon: const Icon(Icons.replay, size: 16),
                                  label: const Text('Reorder'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.primaryGreen,
                                    side: const BorderSide(
                                        color: AppColors.primaryGreen),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
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
