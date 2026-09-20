import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_typography.dart';
import '../../home/widgets/location_header.dart';
import '../../home/widgets/service_tab_bar.dart';

class ConsultsScreen extends StatefulWidget {
  const ConsultsScreen({super.key});

  @override
  State<ConsultsScreen> createState() => _ConsultsScreenState();
}

class _ConsultsScreenState extends State<ConsultsScreen> {
  final List<String> _symptoms = [
    'Pet-related Concern',
    'Adult Vaccination',
    'Obesity/Weight Management',
    'Covid',
    'Fever',
    'Cough',
    'Headache',
    'Stomach Pain',
    'Loose Motions',
    'Dark Patches on Skin',
    'Acne/Pimples',
    'Hairfall',
    'Missed Period',
    'Heavy Menstrual Bleeding',
    'Unprotected Sex',
    'Premature Ejaculation',
    'Mood',
    'Low Mood',
    'Anxiety',
    'Depression',
    'Worry',
    'Panic',
    'Insomnia',
    'Nightmares',
    'Emotional Distress',
    'Fertility Concerns',
    'Migraine',
    'Dizziness',
  ];

  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'When will I get an answer to my query? What happens if I don\'t get a response?',
      'answer': 'A doctor typically accepts and connects with you within 15-30 minutes. If no doctor connects within 45 minutes, 100% of your consultation fee is automatically refunded.',
      'isExpanded': false,
    },
    {
      'question': 'Who are the consulting doctors?',
      'answer': 'All doctors on JeevanCare are MCI/NMC verified medical practitioners with active clinical registrations and verified degrees (MBBS, MD, MS, DNB).',
      'isExpanded': false,
    },
    {
      'question': 'Will the doctor be able to resolve my issue?',
      'answer': 'Our doctors can diagnose, advise lab investigations, and provide valid digitally signed medical prescriptions for more than 85% of primary outpatient health conditions.',
      'isExpanded': false,
    },
    {
      'question': 'Is my consultation private with my doctor?',
      'answer': 'Yes, completely. All text, voice, and video consultations are end-to-end encrypted in strict adherence to HIPAA and telemedicine guidelines.',
      'isExpanded': false,
    },
    {
      'question': 'For how long is the consultation valid?',
      'answer': 'Each consultation session includes free unlimited follow-up messaging with your doctor for the next 3 days.',
      'isExpanded': false,
    },
    {
      'question': 'I am not satisfied with my consultation. What can I do?',
      'answer': 'If you are unsatisfied, contact JeevanCare support within 24 hours. We provide a complimentary secondary specialist consultation or a full wallet refund.',
      'isExpanded': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
          },
          color: AppColors.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // Top Location Header
              const SliverToBoxAdapter(
                child: LocationHeader(),
              ),

              // Service Tab Bar with "Consults" Active (Black underline)
              const SliverToBoxAdapter(
                child: ServiceTabBar(activeTabId: 'consults'),
              ),

              const SliverToBoxAdapter(
                child: Divider(height: 1, thickness: 1, color: AppColors.divider),
              ),

              // COVID / Fever Symptoms Hero Banner (Screenshot 4)
              SliverToBoxAdapter(
                child: _buildSymptomsHeroBanner(),
              ),

              // Online Doctor Consultation 3-Pillars Card (Screenshot 4)
              SliverToBoxAdapter(
                child: _buildConsultationHighlights(),
              ),

              // OR divider
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: const [
                      Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                    ],
                  ),
                ),
              ),

              // Consult Doctor in 1 Click - Symptom Chips (Screenshot 4)
              SliverToBoxAdapter(
                child: _buildSymptomChipsSection(),
              ),

              // Care Plan Membership Strip (Screenshot 2)
              SliverToBoxAdapter(
                child: _buildCarePlanStrip(),
              ),

              // Why Consult on JeevanCare? (Screenshot 2)
              SliverToBoxAdapter(
                child: _buildWhyConsultSection(),
              ),

              // Meet Our Doctors (Screenshot 2)
              SliverToBoxAdapter(
                child: _buildMeetDoctorsSection(),
              ),

              // User Reviews / Testimonials (Screenshot 2)
              SliverToBoxAdapter(
                child: _buildUserReviewsSection(),
              ),

              // Frequently Asked Questions Accordions (Screenshot 2)
              SliverToBoxAdapter(
                child: _buildFaqSection(),
              ),

              // Bottom safety spacing
              const SliverToBoxAdapter(
                child: SizedBox(height: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSymptomsHeroBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      height: 165,
      decoration: BoxDecoration(
        color: const Color(0xFFE2F1F3),
        borderRadius: AppDimensions.rounded16,
        border: Border.all(color: const Color(0xFFCCE4E7)),
      ),
      child: Stack(
        children: [
          // Doctor / Patient photo on right
          Positioned(
            right: 0,
            top: 0,
            bottom: 30,
            width: 140,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&w=400&q=80',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const SizedBox.shrink(),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 135, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fever, cough, or other\nCOVID symptoms?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E3A42),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Consult a qualified doctor online',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF475569),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C5963),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Consult Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Care Plan Bottom Banner Strip
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Color(0xFFC7E5E9),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  const Text(
                    'Get free consultation with ',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3A42),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color(0xFF881337),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text(
                      'Care Plan',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
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

  Widget _buildConsultationHighlights() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppDimensions.rounded16,
        border: Border.all(color: AppColors.borderMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Online doctor consultation with\nqualified doctors',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
                height: 1.25,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 3 Feature Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFeatureItem(
                icon: Icons.timer_outlined,
                title: 'Talk within\n30 mins',
              ),
              _buildFeatureItem(
                icon: Icons.chat_bubble_outline_rounded,
                title: '3 day FREE\nfollow up',
              ),
              _buildFeatureItem(
                icon: Icons.description_outlined,
                title: 'Get a valid\nprescription',
              ),
            ],
          ),
          const SizedBox(height: 14),

          const Text(
            'Starting at ₹199',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),

          // Consult Now Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Get.snackbar(
                  'Starting Doctor Consultation',
                  'Matching you with an online physician...',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(16),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5B4D),
                shape: RoundedRectangleBorder(borderRadius: AppDimensions.rounded8),
                elevation: 0,
              ),
              child: const Text(
                'Consult now',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String title}) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFFFECE9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildSymptomChipsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Consult Doctor in 1 click',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Select a symptom to book in 1 step · Starting at ₹199/-',
            style: TextStyle(
              fontSize: 11.5,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),

          // Symptoms chips in wrap
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _symptoms.map((symptom) {
              return InkWell(
                onTap: () {
                  Get.snackbar(
                    symptom,
                    'Connecting with specialist for $symptom',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.textPrimary,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(16),
                  );
                },
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Text(
                    symptom,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF334155),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCarePlanStrip() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F5),
        borderRadius: AppDimensions.rounded12,
        border: Border.all(color: const Color(0xFFFFEDD5)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFE4E6),
            ),
            child: const Icon(Icons.medical_services_rounded, color: Color(0xFFBE123C)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Free consultation and more benefits with Care Plan membership.',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF881337),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        'Care Plan',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Join now!  Know more >',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE11D48),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyConsultSection() {
    final reasons = [
      {'title': '250+', 'sub': 'Qualified Doctors', 'icon': Icons.health_and_safety_rounded},
      {'title': '300k+', 'sub': 'Satisfied Customers', 'icon': Icons.people_alt_rounded},
      {'title': '23+', 'sub': 'Specialties', 'icon': Icons.domain_add_rounded},
      {'title': '100%', 'sub': 'Secure and Private', 'icon': Icons.lock_outline_rounded},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Why consult on JeevanCare?',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reasons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.2,
            ),
            itemBuilder: (context, index) {
              final r = reasons[index];
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: AppDimensions.rounded12,
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(r['icon'] as IconData, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            r['title'] as String,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            r['sub'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMeetDoctorsSection() {
    final doctors = [
      {
        'name': 'Dr. Prashant Kumar Yadav',
        'degrees': 'MBBS, MD (General Medicine)',
        'reg': 'Reg. No. 60638',
        'rating': '4.7',
        'reviews': '170',
        'exp': '15 years of experience',
        'image': 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=400&q=80',
      },
      {
        'name': 'Dr. Himanshu Narang',
        'degrees': 'MBBS, Diploma in Cardiology',
        'reg': 'Reg. No. 22752',
        'rating': '4.1',
        'reviews': '58',
        'exp': '28 years of experience',
        'image': 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=400&q=80',
      },
      {
        'name': 'Dr. Shweta Bansal',
        'degrees': 'MBBS, DGO (Gynecology)',
        'reg': 'Reg. No. 41908',
        'rating': '4.9',
        'reviews': '240',
        'exp': '12 years of experience',
        'image': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=400&q=80',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Meet our doctors',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 12),

          SizedBox(
            height: 255,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: doctors.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final doc = doctors[index];
                return Container(
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppDimensions.rounded12,
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor Photo
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: SizedBox(
                          height: 120,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: doc['image']!,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Container(
                              color: const Color(0xFFF1F5F9),
                              child: const Icon(Icons.person, size: 40, color: Color(0xFF94A3B8)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc['name']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              doc['degrees']!,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            Text(
                              doc['reg']!,
                              style: const TextStyle(
                                fontSize: 9.5,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.star, size: 12, color: Color(0xFF16A34A)),
                                const SizedBox(width: 2),
                                Text(
                                  '${doc['rating']} (${doc['reviews']})',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF16A34A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              doc['exp']!,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF475569),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserReviewsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: AppDimensions.rounded16,
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'See what our users are saying about their experience',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFF881337),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'M',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Madhu',
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                  ),
                  Text(
                    '35 yrs',
                    style: TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8)),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '“Doctor connected within 10 minutes and asked detailed questions about my fever. The digital prescription worked instantly for home medicine delivery!”',
            style: TextStyle(
              fontSize: 11.5,
              color: Color(0xFF475569),
              fontStyle: FontStyle.italic,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          // Dots indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 16, height: 3, decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 4),
              Container(width: 6, height: 3, decoration: BoxDecoration(color: const Color(0xFFCBD5E1), borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 4),
              Container(width: 6, height: 3, decoration: BoxDecoration(color: const Color(0xFFCBD5E1), borderRadius: BorderRadius.circular(2))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFaqSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Frequently asked questions',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _faqs.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFE2E8F0)),
            itemBuilder: (context, index) {
              final faq = _faqs[index];
              final isExpanded = faq['isExpanded'] as bool;

              return Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.only(bottom: 12),
                  title: Text(
                    faq['question'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  trailing: Icon(
                    isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    color: const Color(0xFF64748B),
                  ),
                  onExpansionChanged: (expanded) {
                    setState(() {
                      faq['isExpanded'] = expanded;
                    });
                  },
                  children: [
                    Text(
                      faq['answer'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF475569),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
