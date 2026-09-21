import 'package:flutter/material.dart';

import '../widgets/stat_card.dart';
import '../widgets/action_button.dart';
import 'referral/create_referral_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _comingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature will be added next.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1200,
            ),

            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  // ==================================================
                  // TOP BAR
                  // ==================================================

                  Row(
                    children: [

                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB),
                          borderRadius:
                              BorderRadius.circular(14),
                        ),

                        child: const Icon(
                          Icons.local_hospital_rounded,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            'CARELINK',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                            ),
                          ),

                          Text(
                            'Digital Referral Tracker',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // ONLINE STATUS

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 9,
                        ),

                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F8EF),
                          borderRadius:
                              BorderRadius.circular(30),
                        ),

                        child: const Row(
                          children: [

                            Icon(
                              Icons.circle,
                              color: Color(0xFF16A34A),
                              size: 9,
                            ),

                            SizedBox(width: 7),

                            Text(
                              'Online',
                              style: TextStyle(
                                color: Color(0xFF15803D),
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 55),

                  // ==================================================
                  // HERO
                  // ==================================================

                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(38),

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF2563EB),
                          Color(0xFF3B82F6),
                        ],
                      ),

                      borderRadius:
                          BorderRadius.circular(28),

                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.blue.withOpacity(0.18),
                          blurRadius: 30,
                          offset:
                              const Offset(0, 15),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              const Text(
                                'Referral Care,\nwithout the gaps.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 42,
                                  height: 1.08,
                                  fontWeight:
                                      FontWeight.w800,
                                ),
                              ),

                              const SizedBox(height: 18),

                              Text(
                                'Track every patient referral from PHC '
                                'to hospital — even when connectivity is limited.',
                                style: TextStyle(
                                  color: Colors.white
                                      .withOpacity(0.88),
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),

                              const SizedBox(height: 30),

                              Row(
                                children: [

                                  // CREATE REFERRAL

                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const CreateReferralScreen(),
                                        ),
                                      );
                                    },

                                    icon: const Icon(
                                      Icons.add_rounded,
                                      size: 20,
                                    ),

                                    label: const Text(
                                      'Create Referral',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.w700,
                                      ),
                                    ),

                                    style:
                                        ElevatedButton
                                            .styleFrom(
                                      backgroundColor:
                                          Colors.white,
                                      foregroundColor:
                                          const Color(
                                              0xFF2563EB),

                                      padding:
                                          const EdgeInsets
                                              .symmetric(
                                        horizontal: 22,
                                        vertical: 16,
                                      ),

                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius
                                                .circular(14),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 14),

                                  // TRACK REFERRAL

                                  OutlinedButton.icon(
                                    onPressed: () {
                                      _comingSoon(
                                        context,
                                        'Track Referral',
                                      );
                                    },

                                    icon: const Icon(
                                      Icons.search_rounded,
                                      size: 20,
                                    ),

                                    label: const Text(
                                      'Track Referral',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.w700,
                                      ),
                                    ),

                                    style:
                                        OutlinedButton
                                            .styleFrom(
                                      foregroundColor:
                                          Colors.white,

                                      side:
                                          const BorderSide(
                                        color:
                                            Colors.white70,
                                      ),

                                      padding:
                                          const EdgeInsets
                                              .symmetric(
                                        horizontal: 22,
                                        vertical: 16,
                                      ),

                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius
                                                .circular(14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // HERO ICON

                        Container(
                          width: 180,
                          height: 180,

                          decoration: BoxDecoration(
                            color:
                                Colors.white.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),

                          child: const Icon(
                            Icons.route_rounded,
                            color: Colors.white,
                            size: 90,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ==================================================
                  // REFERRAL OVERVIEW
                  // ==================================================

                  const Text(
                    'Referral Overview',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: const [

                      StatCard(
                        number: '24',
                        title: 'Referrals Created',
                        icon:
                            Icons.description_outlined,
                      ),

                      SizedBox(width: 16),

                      StatCard(
                        number: '08',
                        title: 'In Transit',
                        icon:
                            Icons.local_shipping_outlined,
                      ),

                      SizedBox(width: 16),

                      StatCard(
                        number: '13',
                        title: 'Arrived',
                        icon:
                            Icons.check_circle_outline_rounded,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ==================================================
                  // QUICK ACTIONS
                  // ==================================================

                  Container(
                    padding: const EdgeInsets.all(25),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(22),

                      border: Border.all(
                        color: const Color(0xFFE5EAF2),
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        const Text(
                          'Quick Actions',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight:
                                FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 18),

                        Row(
                          children: [

                            ActionButton(
                              icon: Icons
                                  .add_circle_outline_rounded,
                              title: 'New Referral',
                              onTap: () {
                                _comingSoon(
                                  context,
                                  'New Referral',
                                );
                              },
                            ),

                            const SizedBox(width: 14),

                            ActionButton(
                              icon:
                                  Icons.qr_code_rounded,
                              title: 'Find Referral',
                              onTap: () {
                                _comingSoon(
                                  context,
                                  'Find Referral',
                                );
                              },
                            ),

                            const SizedBox(width: 14),

                            ActionButton(
                              icon: Icons
                                  .local_hospital_outlined,
                              title: 'Hospital Mode',
                              onTap: () {
                                _comingSoon(
                                  context,
                                  'Hospital Mode',
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}