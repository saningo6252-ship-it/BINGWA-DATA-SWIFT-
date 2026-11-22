import 'package:flutter/material.dart';
import '../models/bundle_model.dart';
import '../services/app_state_service.dart';
import '../theme/app_theme.dart';
import 'admin_panel_screen.dart';
import 'airtime_screen.dart';
import 'network_bundle_screen.dart';
import 'order_history_screen.dart';
import 'pin_login_screen.dart';
import 'purchase_screen.dart';
import 'referral_screen.dart';
import 'support_screen.dart';

class HomeScreen extends StatefulWidget {
  final AppStateService appState;

  const HomeScreen({super.key, required this.appState});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  void _openNetworkBundles(NetworkType network) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NetworkBundleScreen(
          appState: widget.appState,
          network: network,
        ),
      ),
    );
  }

  void _openOfferPurchase(BundleOffer offer) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PurchaseScreen(
          appState: widget.appState,
          network: offer.network,
          offer: offer,
        ),
      ),
    );
  }

  void _showNotificationsSheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => ListView(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.darkGreen,
            ),
          ),
          const SizedBox(height: 12),
          if (widget.appState.notifications.isEmpty)
            const Text('No notifications yet.')
          else
            ...widget.appState.notifications.map(
              (msg) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(msg, style: const TextStyle(fontSize: 13)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onNavTap(int index) {
    if (index == 0) {
      setState(() => _navIndex = 0);
      return;
    }

    Widget target;
    switch (index) {
      case 1:
        target = AirtimeScreen(appState: widget.appState);
        break;
      case 2:
        target = OrderHistoryScreen(appState: widget.appState);
        break;
      case 3:
        target = ReferralScreen(appState: widget.appState);
        break;
      case 4:
      default:
        target = const SupportScreen();
        break;
    }

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => target))
        .then((_) {
      if (mounted) setState(() => _navIndex = 0);
    });
  }

  Widget _buildNetworkCard({
    required NetworkType network,
    required Color accentColor,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () => _openNetworkBundles(network),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accentColor.withValues(alpha: 0.45), width: 1.4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.sim_card_outlined,
                color: accentColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              network.displayName.toUpperCase(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: accentColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.mutedText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.appState.currentUser;
    final specialOffers = widget.appState.getSpecialOffers();
    final ads = widget.appState.activeAds;
    final isOpen = widget.appState.isStoreOpen;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppBusinessInfo.appName),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isOpen ? AppColors.lightGreen : const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              isOpen ? 'OPEN' : 'CLOSED',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: isOpen ? AppColors.darkGreen : AppColors.errorRed,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            tooltip: 'Notifications',
            onPressed: _showNotificationsSheet,
          ),
          IconButton(
            icon: const Icon(Icons.admin_panel_settings_outlined),
            tooltip: 'Admin Panel',
            onPressed: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (_) =>
                          AdminPanelScreen(appState: widget.appState),
                    ),
                  )
                  .then((_) {
                if (mounted) setState(() {});
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user != null
                                ? 'Karibu, ${user.fullName}'
                                : 'Karibu, BINGWA SOKONI',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkGreen,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user != null
                                ? '${user.phoneNumber} • Code: ${user.referralCode}'
                                : AppBusinessInfo.tagline,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        await widget.appState.logout();
                        if (!context.mounted) return;
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) =>
                                PinLoginScreen(appState: widget.appState),
                          ),
                        );
                      },
                      icon: const Icon(Icons.logout, size: 16),
                      label: const Text('Logout'),
                    ),
                  ],
                ),
              ),
              if (!isOpen) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Store is currently CLOSED. New orders are temporarily unavailable.',
                    style: TextStyle(
                      color: AppColors.warningAmber,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
              if (ads.isNotEmpty) ...[
                const SizedBox(height: 16),
                SizedBox(
                  height: 112,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: ads.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final ad = ads[index];
                      return InkWell(
                        onTap: () => setState(
                          () => widget.appState.recordAdClick(ad.id),
                        ),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 280,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.darkGreen,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ad.tag,
                                style: const TextStyle(
                                  color: AppColors.lightGreen,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                ad.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                ad.subtitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.lightGreen,
                                  fontSize: 12,
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
              const SizedBox(height: 20),
              const Text(
                'Select Network',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.25,
                children: [
                  _buildNetworkCard(
                    network: NetworkType.safaricom,
                    accentColor: AppColors.safaricomGreen,
                    subtitle: 'Data, SMS, Minutes & No Expiry',
                  ),
                  _buildNetworkCard(
                    network: NetworkType.airtel,
                    accentColor: AppColors.airtelRed,
                    subtitle: 'Tubonge, Data & Daily/Weekly',
                  ),
                  _buildNetworkCard(
                    network: NetworkType.telkom,
                    accentColor: AppColors.telkomBlue,
                    subtitle: 'Data & Combo Offers',
                  ),
                  _buildNetworkCard(
                    network: NetworkType.faiba,
                    accentColor: AppColors.faibaGold,
                    subtitle: '4G Data & Bundles',
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Text(
                'Special Offers',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 10),
              ...specialOffers.take(6).map(
                    (offer) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: const BorderSide(color: AppColors.borderGray),
                      ),
                      child: ListTile(
                        title: Text(
                          '${offer.network.displayName} • ${offer.name}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          '${offer.validity} • ${offer.priceDisplay}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () => _openOfferPurchase(offer),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(84, 36),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          child: const Text(
                            'BUY',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_in_talk_outlined),
            activeIcon: Icon(Icons.phone_in_talk),
            label: 'Airtime',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_outlined),
            activeIcon: Icon(Icons.card_giftcard),
            label: 'Refer & Earn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent_outlined),
            activeIcon: Icon(Icons.support_agent),
            label: 'Support',
          ),
        ],
      ),
    );
  }
}
