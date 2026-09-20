import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../data/pharmacy_data.dart';

class DeliveringCareSection extends StatefulWidget {
  const DeliveringCareSection({super.key});

  @override
  State<DeliveringCareSection> createState() => _DeliveringCareSectionState();
}

class _DeliveringCareSectionState extends State<DeliveringCareSection> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients &&
        _scrollController.position.maxScrollExtent > 0) {
      setState(() {
        _scrollProgress = (_scrollController.position.pixels /
                _scrollController.position.maxScrollExtent)
            .clamp(0.0, 1.0);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stories = PharmacyData.editorialStories;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Delivering care for you',
              style: AppTypography.headline2.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Horizontal scrollable portrait editorial cards
          SizedBox(
            height: 210,
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final story = stories[index];
                return InkWell(
                  onTap: () {},
                  borderRadius: AppDimensions.rounded16,
                  child: Container(
                    width: 145,
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: AppDimensions.rounded16,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: AppDimensions.rounded16,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Background portrait photo
                          CachedNetworkImage(
                            imageUrl: story.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: const Color(0xFFE2E8F0),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: const Color(0xFF64748B),
                              child: const Icon(Icons.image, color: Colors.white),
                            ),
                          ),

                          // Gradient dark overlay at bottom
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.35, 1.0],
                                colors: [
                                  Colors.transparent,
                                  Colors.black87,
                                ],
                              ),
                            ),
                          ),

                          // Text at bottom
                          Positioned(
                            left: 12,
                            right: 12,
                            bottom: 14,
                            child: Text(
                              story.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                height: 1.25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // Indicator bar below
          Center(
            child: Container(
              width: 120,
              height: 3.5,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: _scrollProgress * 80,
                    child: Container(
                      width: 40,
                      height: 3.5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
