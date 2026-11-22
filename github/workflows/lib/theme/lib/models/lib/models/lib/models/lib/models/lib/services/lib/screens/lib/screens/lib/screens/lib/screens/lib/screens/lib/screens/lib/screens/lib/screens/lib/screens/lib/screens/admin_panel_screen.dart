import 'package:flutter/material.dart';
import '../models/bundle_model.dart';
import '../models/order_model.dart';
import '../services/app_state_service.dart';
import '../theme/app_theme.dart';

class AdminPanelScreen extends StatefulWidget {
  final AppStateService appState;

  const AdminPanelScreen({super.key, required this.appState});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _showOfferFormDialog({BundleOffer? existing}) async {
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final priceCtrl = TextEditingController(
      text: existing?.priceKes?.toString() ?? '',
    );
    final validityCtrl = TextEditingController(
      text: existing?.validity ?? '24 Hrs / Daily',
    );
    NetworkType selectedNet = existing?.network ?? NetworkType.safaricom;
    BundleCategory selectedCat = existing?.category ?? BundleCategory.data;
    bool isPopular = existing?.isPopular ?? false;
    bool isCustom = existing?.isCustomAmount ?? false;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(existing == null ? 'Add Bundle Offer' : 'Edit Bundle Offer'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<NetworkType>(
                  value: selectedNet,
                  decoration: const InputDecoration(labelText: 'Network'),
                  items: NetworkType.values
                      .map((n) => DropdownMenuItem(
                            value: n,
                            child: Text(n.displayName),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setDialogState(() => selectedNet = v);
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<BundleCategory>(
                  value: selectedCat,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: BundleCategory.values
                      .where((c) => c != BundleCategory.all)
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c.label),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setDialogState(() => selectedCat = v);
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Offer Name (e.g. 1GB)',
                  ),
                ),
                const SizedBox(height: 10),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Customer Chooses Amount (KES 1–499)'),
                  value: isCustom,
                  onChanged: (v) => setDialogState(() => isCustom = v),
                ),
                if (!isCustom)
                  TextField(
                    controller: priceCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Price (KES)',
                    ),
                  ),
                const SizedBox(height: 10),
                TextField(
                  controller: validityCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Validity',
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Mark as Popular'),
                  value: isPopular,
                  onChanged: (v) => setDialogState(() => isPopular = v),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameCtrl.text.trim();
                if (name.isEmpty) return;
                final price = isCustom ? null : int.tryParse(priceCtrl.text.trim());

                final offer = BundleOffer(
                  id: existing?.id ?? 'adm_${DateTime.now().millisecondsSinceEpoch}',
                  network: selectedNet,
                  category: selectedCat,
                  name: name,
                  priceKes: price,
                  minCustomAmount: isCustom ? 1 : null,
                  maxCustomAmount: isCustom ? 499 : null,
                  validity: validityCtrl.text.trim().isEmpty
                      ? '24 Hrs / Daily'
                      : validityCtrl.text.trim(),
                  isPopular: isPopular,
                );

                setState(() {
                  if (existing == null) {
                    widget.appState.addOffer(offer);
                  } else {
                    widget.appState.updateOffer(offer);
                  }
                });
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddAdDialog() async {
    final titleCtrl = TextEditingController();
    final subCtrl = TextEditingController();
    final tagCtrl = TextEditingController(text: 'PROMO');

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Promotional Ad'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tagCtrl,
              decoration: const InputDecoration(labelText: 'Tag (e.g. PROMO)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Ad Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: subCtrl,
              decoration: const InputDecoration(labelText: 'Subtitle'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleCtrl.text.trim().isEmpty) return;
              setState(() {
                widget.appState.addAd(
                  PromoAd(
                    id: 'ad_${DateTime.now().millisecondsSinceEpoch}',
                    title: titleCtrl.text.trim(),
                    subtitle: subCtrl.text.trim(),
                    tag: tagCtrl.text.trim().isEmpty
                        ? 'PROMO'
                        : tagCtrl.text.trim().toUpperCase(),
                  ),
                );
              });
              Navigator.pop(ctx);
            },
            child: const Text('Publish Ad'),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreAndOrdersTab() {
    final orders = widget.appState.orders;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: AppColors.borderGray),
          ),
          child: SwitchListTile(
            title: const Text(
              'Store Order Acceptance Status',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              widget.appState.isStoreOpen
                  ? 'OPEN — Customers can place new bundle & airtime orders.'
                  : 'CLOSED — New orders are paused.',
            ),
            value: widget.appState.isStoreOpen,
            activeTrackColor: AppColors.primaryGreen,
            onChanged: (val) => setState(() => widget.appState.setStoreOpen(val)),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Recent Orders',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        if (orders.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'No orders recorded yet.',
              style: TextStyle(color: AppColors.mutedText),
            ),
          )
        else
          ...orders.map(
            (order) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order.orderId} • ${order.network.displayName} ${order.itemName}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'KES ${order.amountKes} • Recipient: ${order.recipientPhone}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      'Payment: ${order.paymentStatus} • Status: ${order.deliveryStatus.label}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.mutedText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<OrderLifecycleStatus>(
                      value: order.deliveryStatus,
                      decoration: const InputDecoration(
                        labelText: 'Update Order Status',
                        isDense: true,
                      ),
                      items: OrderLifecycleStatus.values
                          .map((st) => DropdownMenuItem(
                                value: st,
                                child: Text(st.label),
                              ))
                          .toList(),
                      onChanged: (nextStatus) {
                        if (nextStatus != null) {
                          setState(() {
                            widget.appState.updateOrderStatus(
                              order.orderId,
                              nextStatus,
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildOffersTab() {
    final offers = widget.appState.offers;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ElevatedButton.icon(
          onPressed: () => _showOfferFormDialog(),
          icon: const Icon(Icons.add),
          label: const Text('Add New Bundle Offer'),
        ),
        const SizedBox(height: 14),
        ...offers.map(
          (offer) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text(
                '${offer.network.displayName} • ${offer.name}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                '${offer.category.label} • ${offer.priceDisplay} • ${offer.validity}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => _showOfferFormDialog(existing: offer),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: AppColors.errorRed),
                    onPressed: () => setState(() => widget.appState.deleteOffer(offer.id)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdsAndReferralsTab() {
    final rewardCtrl = TextEditingController(
      text: widget.appState.referralRewardAmountKes.toString(),
    );
    final condCtrl = TextEditingController(
      text: widget.appState.referralConditionText,
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Referral Reward Settings',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: rewardCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Reward Amount (KES)'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: condCtrl,
                  decoration: const InputDecoration(labelText: 'Eligibility Condition'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    final amt = int.tryParse(rewardCtrl.text.trim());
                    if (amt != null && amt >= 0) {
                      setState(() {
                        widget.appState.updateReferralSettings(
                          rewardKes: amt,
                          condition: condCtrl.text.trim(),
                        );
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Referral settings updated.')),
                      );
                    }
                  },
                  child: const Text('Save Referral Rules'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _showAddAdDialog,
          icon: const Icon(Icons.campaign_outlined),
          label: const Text('Create Promotional Ad'),
        ),
        const SizedBox(height: 12),
        ...widget.appState.allAds.map(
          (ad) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text(
                '[${ad.tag}] ${ad.title}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text('${ad.subtitle} • Clicks: ${ad.clicks}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: ad.isActive,
                    onChanged: (_) =>
                        setState(() => widget.appState.toggleAdActive(ad.id)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: AppColors.errorRed),
                    onPressed: () =>
                        setState(() => widget.appState.deleteAd(ad.id)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADMIN PANEL'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Store & Orders'),
            Tab(text: 'Offers'),
            Tab(text: 'Ads & Referrals'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStoreAndOrdersTab(),
          _buildOffersTab(),
          _buildAdsAndReferralsTab(),
        ],
      ),
    );
  }
}
