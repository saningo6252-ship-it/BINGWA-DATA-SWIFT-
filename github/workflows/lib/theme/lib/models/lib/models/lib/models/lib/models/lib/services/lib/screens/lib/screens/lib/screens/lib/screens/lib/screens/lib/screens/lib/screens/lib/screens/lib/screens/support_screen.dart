import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  void _copyValue(BuildContext context, String label, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied $label: $value')),
    );
  }

  void _showChannelSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Contact Support: ${AppBusinessInfo.supportPhone}',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: AppColors.darkGreen,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Choose how you want to reach ${AppBusinessInfo.businessName}:',
              style: TextStyle(color: AppColors.mutedText, fontSize: 13),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.call, color: AppColors.primaryGreen),
              title: const Text('Call Support'),
              subtitle: const Text(AppBusinessInfo.supportPhone),
              onTap: () {
                Navigator.pop(ctx);
                _copyValue(
                  context,
                  'Support Phone',
                  AppBusinessInfo.supportPhone,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: AppColors.primaryGreen),
              title: const Text('WhatsApp Support'),
              subtitle: const Text(AppBusinessInfo.supportPhone),
              onTap: () {
                Navigator.pop(ctx);
                _copyValue(
                  context,
                  'WhatsApp Number',
                  AppBusinessInfo.supportPhone,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sms, color: AppColors.primaryGreen),
              title: const Text('SMS Support'),
              subtitle: const Text(AppBusinessInfo.supportPhone),
              onTap: () {
                Navigator.pop(ctx);
                _copyValue(
                  context,
                  'SMS Number',
                  AppBusinessInfo.supportPhone,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SUPPORT & HELP'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color: AppColors.borderGray),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppBusinessInfo.businessName,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkGreen,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        AppBusinessInfo.tagline,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.mutedText,
                        ),
                      ),
                      const Divider(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Support Phone',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.mutedText,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                AppBusinessInfo.supportPhone,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () => _copyValue(
                              context,
                              'Support Phone',
                              AppBusinessInfo.supportPhone,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Buy Goods Till Number',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.mutedText,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                AppBusinessInfo.tillNumber,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () => _copyValue(
                              context,
                              'Till Number',
                              AppBusinessInfo.tillNumber,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton.icon(
                        onPressed: () => _showChannelSheet(context),
                        icon: const Icon(Icons.support_agent),
                        label: const Text('Contact Support'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HOW TO BUY MANUALLY',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkGreen,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('1. Open M-PESA.'),
                      Text('2. Select Lipa na M-PESA.'),
                      Text('3. Select Buy Goods.'),
                      Text('4. Enter Till Number: ${AppBusinessInfo.tillNumber}.'),
                      Text('5. Enter Amount.'),
                      Text('6. Enter M-PESA PIN.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const _FaqTile(
                question: 'Can I buy a bundle or airtime for another phone number?',
                answer:
                    'Yes. On the purchase screen, enter the recipient phone number in Recipient Phone Number and the M-PESA number in Payment Phone Number.',
              ),
              const _FaqTile(
                question: 'When is a manual Till payment marked confirmed?',
                answer:
                    'Manual payments submitted with an M-PESA reference remain awaiting verification until confirmed against Till ${AppBusinessInfo.tillNumber}.',
              ),
              const _FaqTile(
                question: 'What happens if an order fails after payment?',
                answer:
                    'Failed deliveries are tracked in Order History and may move to refund handling according to order status updates.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqTile({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 13, color: AppColors.mutedText),
            ),
          ),
        ],
      ),
    );
  }
}
