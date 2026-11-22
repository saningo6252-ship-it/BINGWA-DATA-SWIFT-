import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/app_state_service.dart';
import '../theme/app_theme.dart';

class ReferralScreen extends StatelessWidget {
  final AppStateService appState;

  const ReferralScreen({super.key, required this.appState});

  String _buildShareMessage(String code) {
    return 'Join ${AppBusinessInfo.appName} (${AppBusinessInfo.tagline}) '
        'using my referral code $code to get fast bundles and airtime on '
        'Safaricom, Airtel, Telkom & Faiba.';
  }

  void _copyCode(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied referral code: $code')),
    );
  }

  void _showSharePreview(
    BuildContext context, {
    required String channel,
    required String message,
  }) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Share via $channel'),
        content: SelectableText(message),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: message));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$channel invite message copied.')),
              );
            },
            child: const Text('Copy Invite Text'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = appState.currentUser;
    final code = user?.referralCode ?? 'BS0000';
    final shareText = _buildShareMessage(code);

    return Scaffold(
      appBar: AppBar(
        title: const Text('REFER & EARN'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'YOUR REFERRAL CODE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkGreen,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          code,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: AppColors.darkGreen,
                            letterSpacing: 1.4,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _copyCode(context, code),
                          icon: const Icon(Icons.copy, size: 16),
                          label: const Text('Copy Code'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(120, 40),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Reward: KES ${appState.referralRewardAmountKes} • ${appState.referralConditionText}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.darkText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showSharePreview(
                        context,
                        channel: 'WhatsApp',
                        message: shareText,
                      ),
                      icon: const Icon(Icons.chat_outlined),
                      label: const Text('Share WhatsApp'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showSharePreview(
                        context,
                        channel: 'SMS',
                        message: shareText,
                      ),
                      icon: const Icon(Icons.sms_outlined),
                      label: const Text('Share SMS'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryGreen,
                        side: const BorderSide(color: AppColors.primaryGreen),
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.55,
                children: [
                  _StatTile(
                    label: 'Total Invited',
                    value: '${user?.totalInvited ?? 0}',
                  ),
                  _StatTile(
                    label: 'Eligible Referrals',
                    value: '${user?.eligibleReferrals ?? 0}',
                  ),
                  _StatTile(
                    label: 'Approved Reward',
                    value: 'KES ${user?.approvedRewardKes ?? 0}',
                  ),
                  _StatTile(
                    label: 'Pending Reward',
                    value: 'KES ${user?.pendingRewardKes ?? 0}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;

  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.mutedText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }
}
