import 'package:flutter/material.dart';
import '../../../app/theme/app_typography.dart';
import '../data/pharmacy_data.dart';

class PetTopBrandsSection extends StatelessWidget {
  const PetTopBrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final brands = PharmacyData.petTopBrands;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pet care top brands',
            style: AppTypography.headline2.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),

          // 3x3 Circular Brands Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              final brand = brands[index];
              return InkWell(
                onTap: () {},
                shape: const CircleBorder(),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [
                        Colors.white,
                        Color(0xFFFFEEF0),
                        Color(0xFFFFDEE3),
                      ],
                      stops: [0.3, 0.8, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE11D48).withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: const Color(0xFFFFD1D8),
                      width: 1.2,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: _buildBrandLogo(brand),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBrandLogo(PharmacyBrandItem brand) {
    switch (brand.name) {
      case 'ROYAL CANIN':
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, size: 12, color: Color(0xFFDC2626)),
            const SizedBox(height: 2),
            Text(
              brand.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w900,
                color: Color(0xFFDC2626),
                letterSpacing: 0.5,
              ),
            ),
          ],
        );
      case 'drools':
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              brand.name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1E40AF),
                fontFamily: 'serif',
                fontStyle: FontStyle.italic,
              ),
            ),
            const Text(
              'Feed real. Feel real.',
              style: TextStyle(
                fontSize: 6.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2563EB),
              ),
            ),
          ],
        );
      case 'Pedigree':
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Color(0xFFEA580C),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.pets, size: 10, color: Colors.white),
            ),
            const SizedBox(height: 2),
            Text(
              brand.name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: Color(0xFF9A3412),
              ),
            ),
          ],
        );
      case 'whiskas':
        return Text(
          brand.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Color(0xFF7E22CE),
            letterSpacing: -0.3,
          ),
        );
      case 'Himalaya':
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEA580C),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  brand.name,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F766E),
                  ),
                ),
              ],
            ),
            const Text(
              'SINCE 1930',
              style: TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F766E),
                letterSpacing: 1.0,
              ),
            ),
          ],
        );
      case 'JerHigh':
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              brand.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Color(0xFF15803D),
              ),
            ),
            const Text(
              'Feed me love ♡',
              style: TextStyle(
                fontSize: 6.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFFE11D48),
              ),
            ),
          ],
        );
      case 'Aniamor':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1E3A8A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            brand.name,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        );
      case 'VetLife':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF0284C7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'VetLife',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(Icons.eco_rounded, size: 14, color: Color(0xFF16A34A)),
          ],
        );
      case "BAKSON'S":
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Dr. Bakshi's",
              style: TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.w600,
                color: Color(0xFF334155),
              ),
            ),
            Text(
              brand.name,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: Color(0xFFBE123C),
              ),
            ),
            const Text(
              'HOMOEOPATHY',
              style: TextStyle(
                fontSize: 6.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF047857),
                letterSpacing: 0.5,
              ),
            ),
          ],
        );
      default:
        return Text(
          brand.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: brand.brandColor,
          ),
        );
    }
  }
}
