import 'package:flutter/material.dart';
import '../models/bundle_model.dart';
import '../services/app_state_service.dart';
import '../theme/app_theme.dart';
import 'purchase_screen.dart';

enum PriceSortOrder {
  none,
  lowToHigh,
  highToLow,
}

class NetworkBundleScreen extends StatefulWidget {
  final AppStateService appState;
  final NetworkType network;

  const NetworkBundleScreen({
    super.key,
    required this.appState,
    required this.network,
  });

  @override
  State<NetworkBundleScreen> createState() => _NetworkBundleScreenState();
}

class _NetworkBundleScreenState extends State<NetworkBundleScreen> {
  BundleCategory _selectedCategory = BundleCategory.all;
  String _searchQuery = '';
  bool _popularOnly = false;
  PriceSortOrder _sortOrder = PriceSortOrder.none;

  Color get _networkColor {
    switch (widget.network) {
      case NetworkType.safaricom:
        return AppColors.safaricomGreen;
      case NetworkType.airtel:
        return AppColors.airtelRed;
      case NetworkType.telkom:
        return AppColors.telkomBlue;
      case NetworkType.faiba:
        return AppColors.faibaGold;
    }
  }

  List<BundleOffer> _filteredOffers() {
    final base = widget.appState.getOffersForNetwork(widget.network);

    final filtered = base.where((offer) {
      if (_selectedCategory != BundleCategory.all &&
          offer.category != _selectedCategory) {
        return false;
      }
      if (_popularOnly && !offer.isPopular) {
        return false;
      }
      if (_searchQuery.trim().isNotEmpty) {
        final q = _searchQuery.trim().toLowerCase();
        final matchesName = offer.name.toLowerCase().contains(q);
        final matchesValidity = offer.validity.toLowerCase().contains(q);
        final matchesPrice = offer.priceDisplay.toLowerCase().contains(q);
        if (!matchesName && !matchesValidity && !matchesPrice) {
          return false;
        }
      }
      return true;
    }).toList();

    if (_sortOrder == PriceSortOrder.lowToHigh) {
      filtered.sort((a, b) => (a.priceKes ?? 0).compareTo(b.priceKes ?? 0));
    } else if (_sortOrder == PriceSortOrder.highToLow) {
      filtered.sort((a, b) => (b.priceKes ?? 0).compareTo(a.priceKes ?? 0));
    }

    return filtered;
  }

  void _openPurchase(BundleOffer offer) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PurchaseScreen(
          appState: widget.appState,
          network: widget.network,
          offer: offer,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final offers = _filteredOffers();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('${widget.network.displayName} BUNDLES'),
        actions: [
          PopupMenuButton<PriceSortOrder>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort by price',
            onSelected: (order) => setState(() => _sortOrder = order),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: PriceSortOrder.none,
                child: Text('Default Order'),
              ),
              PopupMenuItem(
                value: PriceSortOrder.lowToHigh,
                child: Text('Price: Low to High'),
              ),
              PopupMenuItem(
                value: PriceSortOrder.highToLow,
                child: Text('Price: High to Low'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search ${widget.network.displayName} offers...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
              ),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: BundleCategory.values.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = BundleCategory.values[index];
                final selected = cat == _selectedCategory;
                return ChoiceChip(
                  label: Text(cat.label),
                  selected: selected,
                  selectedColor: _networkColor,
                  labelStyle: TextStyle(
                    color: selected ? AppColors.white : AppColors.darkText,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  onSelected: (_) {
                    setState(() => _selectedCategory = cat);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterChip(
                  label: const Text('Popular Offers'),
                  selected: _popularOnly,
                  onSelected: (v) => setState(() => _popularOnly = v),
                ),
                Text(
                  '${offers.length} offer(s)',
                  style: const TextStyle(
                    color: AppColors.mutedText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: offers.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No offers available in this category.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mutedText,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                    itemCount: offers.length,
                    itemBuilder: (context, index) {
                      final offer = offers[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(color: AppColors.borderGray),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.lightGreen,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            offer.category.label,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.darkGreen,
                                            ),
                                          ),
                                        ),
                                        if (offer.isPopular) ...[
                                          const SizedBox(width: 6),
                                          const Text(
                                            'POPULAR',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primaryGreen,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      offer.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.darkText,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Validity: ${offer.validity}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.mutedText,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      offer.priceDisplay,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: _networkColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () => _openPurchase(offer),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(104, 42),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                ),
                                child: const Text(
                                  'BUY NOW',
                                  style: TextStyle(fontSize: 12),
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
