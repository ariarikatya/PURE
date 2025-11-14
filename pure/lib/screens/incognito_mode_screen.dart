import 'package:flutter/material.dart';
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
  int _selectedPlanIndex = 1; // Middle option selected by default

  final List<Map<String, dynamic>> _plans = [
    {'glasses': 1, 'price': '99 ₽', 'tag': null},
    {'glasses': 3, 'price': '199 ₽', 'tag': 'Хит', 'discount': null},
    {'glasses': 7, 'price': '399 ₽', 'tag': null, 'discount': '-42%'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Color(0xFF1E1B4B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Close button
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: widget.onClose,
            ),
          ),

          // Sunglasses icon
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            child: const SunglassesIcon(width: 120, height: 50),
          ),

          // Title
          const Text(
            'РЕЖИМ ИНКОГНИТО НА 24 ЧАСА',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Стань невидимкой в ленте и чатах, скрой\nобъявление и наслаждайся незамеченным',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: TextAlign.left,
            ),
          ),

          const SizedBox(height: 32),

          // Pricing options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: List.generate(_plans.length, (index) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 0 : 6,
                      right: index == _plans.length - 1 ? 0 : 6,
                    ),
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
                    ),
                  ),
                );
              }),
            ),
          ),

          const Spacer(),

          // Purchase button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onPurchase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFAA044A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Купить',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Terms link
          TextButton(
            onPressed: () {},
            child: const Text(
              'УСЛОВИЯ И ПОЛОЖЕНИЯ',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
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

  const _PlanCard({
    required this.isSelected,
    required this.glasses,
    required this.price,
    this.tag,
    this.discount,
    required this.onTap,
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
              color: isSelected
                  ? Colors.white.withOpacity(0.15)
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.white : Colors.transparent,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      glasses.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const EyeIcon(size: 24, color: Colors.amber),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (tag != null)
            Positioned(
              top: -12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tag!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          if (discount != null)
            Positioned(
              top: -12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    discount!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
