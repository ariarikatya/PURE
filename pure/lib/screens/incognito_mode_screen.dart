import 'package:flutter/material.dart';
import 'package:pure/constants/app_colors.dart';
import '../widgets/svg_icons.dart';

class IncognitoModeScreen extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onPurchase;

  const IncognitoModeScreen({
    super.key,
    required this.onClose,
    required this.onPurchase,
  });

  @override
  State<IncognitoModeScreen> createState() => _IncognitoModeScreenState();
}

class _IncognitoModeScreenState extends State<IncognitoModeScreen> {
  int _selectedPlanIndex = 1;

  final List<Map<String, dynamic>> _plans = [
    {'glasses': 1, 'price': '99 ₽', 'tag': null},
    {'glasses': 3, 'price': '199 ₽', 'tag': 'Хит', 'discount': null},
    {'glasses': 7, 'price': '399 ₽', 'tag': null, 'discount': '-42%'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = screenHeight * 0.9;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1B4B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 22, top: 10),
                      child: const SunglassesIcon(width: 170, height: 68),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: widget.onClose,
                    ),
                  ),
                ],
              ),
            ),

            const Text(
              'РЕЖИМ ИНКОГНИТО НА 24 ЧАСА',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Стань невидимкой в ленте и чатах, скрой\nобъявление и наслаждайся <Space> незамеченным',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(_plans.length, (index) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: _PlanCard(
                        isSelected: _selectedPlanIndex == index,
                        glasses: _plans[index]['glasses'],
                        price: _plans[index]['price'],
                        tag: _plans[index]['tag'],
                        discount: _plans[index]['discount'],
                        onTap: () {
                          setState(() {
                            _selectedPlanIndex = index;
                          });
                        },
                        cardBackground: AppColors.background,
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: widget.onPurchase,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAA044A),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Купить',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),

            TextButton(
              onPressed: () {},
              child: const Text(
                'УСЛОВИЯ И ПОЛОЖЕНИЯ',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final bool isSelected;
  final int glasses;
  final String price;
  final String? tag;
  final String? discount;
  final VoidCallback onTap;
  final Color cardBackground;

  const _PlanCard({
    required this.isSelected,
    required this.glasses,
    required this.price,
    this.tag,
    this.discount,
    required this.onTap,
    required this.cardBackground,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider, width: 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 24,
                      alignment: Alignment.center,
                      child: Text(
                        glasses.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const EyeIcon(size: 24, color: Colors.amber),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (tag != null)
            Positioned(
              top: -18,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  height: 36,
                  width: 80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withValues(alpha: 0.1),
                              blurRadius: 7,
                              spreadRadius: 0,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/sale.png',
                        height: 36,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        tag!,
                        style: const TextStyle(
                          color: AppColors.background,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (discount != null)
            Positioned(
              top: -18,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  height: 36,
                  width: 80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withValues(alpha: 0.1),
                              blurRadius: 7,
                              spreadRadius: 0,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/sale.png',
                        height: 36,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        discount!,
                        style: const TextStyle(
                          color: AppColors.background,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
