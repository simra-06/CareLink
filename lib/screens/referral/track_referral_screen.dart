import 'package:flutter/material.dart';

import '../../services/referral_storage.dart';

class TrackReferralScreen extends StatefulWidget {
  const TrackReferralScreen({super.key});

  @override
  State<TrackReferralScreen> createState() =>
      _TrackReferralScreenState();
}

class _TrackReferralScreenState
    extends State<TrackReferralScreen> {
  final TextEditingController _referralController =
      TextEditingController();

  Map<String, dynamic>? _referral;
  bool _searched = false;
  bool _loading = false;

  @override
  void dispose() {
    _referralController.dispose();
    super.dispose();
  }

  Future<void> _searchReferral() async {
    final referralId =
        _referralController.text.trim().toUpperCase();

    if (referralId.isEmpty) {
      setState(() {
        _searched = true;
        _referral = null;
      });
      return;
    }

    setState(() {
      _loading = true;
      _searched = false;
    });

    final result =
        await ReferralStorage.findReferral(referralId);

    if (!mounted) return;

    setState(() {
      _referral = result;
      _searched = true;
      _loading = false;
    });
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'arrived':
        return const Color(0xFF16A34A);
      case 'in transit':
        return const Color(0xFFD97706);
      default:
        return const Color(0xFF2563EB);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 900,
            ),

            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  // BACK BUTTON
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Track Referral',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Enter the referral ID to view its current status.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // SEARCH CARD
                  Container(
                    padding: const EdgeInsets.all(24),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE5EAF2),
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        const Text(
                          'Referral ID',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextField(
                          controller: _referralController,
                          textCapitalization:
                              TextCapitalization.characters,

                          onSubmitted: (_) =>
                              _searchReferral(),

                          decoration: InputDecoration(
                            hintText: 'Example: REF-A7K2P',

                            prefixIcon: const Icon(
                              Icons.search_rounded,
                            ),

                            suffixIcon: IconButton(
                              onPressed: _searchReferral,
                              icon: const Icon(
                                Icons.arrow_forward_rounded,
                              ),
                            ),

                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),

                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                              borderSide:
                                  const BorderSide(
                                color: Color(0xFFD9E0EA),
                              ),
                            ),

                            focusedBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                              borderSide:
                                  const BorderSide(
                                color: Color(0xFF2563EB),
                                width: 2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton.icon(
                            onPressed:
                                _loading
                                    ? null
                                    : _searchReferral,

                            icon: _loading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child:
                                        CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(
                                    Icons.search_rounded,
                                  ),

                            label: Text(
                              _loading
                                  ? 'Searching...'
                                  : 'Track Referral',
                            ),

                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF2563EB),
                              foregroundColor:
                                  Colors.white,

                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 16,
                              ),

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // RESULT
                  if (_searched && _referral != null)
                    _buildReferralResult(),

                  if (_searched && _referral == null)
                    _buildNotFound(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReferralResult() {
    final referral = _referral!;

    final status =
        referral['status']?.toString() ?? 'Created';

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(26),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5EAF2),
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FF),
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.route_rounded,
                  color: Color(0xFF2563EB),
                ),
              ),

              const SizedBox(width: 14),

              const Expanded(
                child: Text(
                  'Referral Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),

                decoration: BoxDecoration(
                  color: _statusColor(status)
                      .withOpacity(0.10),
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(
                  status,
                  style: TextStyle(
                    color: _statusColor(status),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          _detailRow(
            'Referral ID',
            referral['referralId'],
            Icons.confirmation_number_outlined,
          ),

          _detailRow(
            'Patient',
            referral['patientName'],
            Icons.person_outline_rounded,
          ),

          _detailRow(
            'Age',
            referral['age'],
            Icons.cake_outlined,
          ),

          _detailRow(
            'Village / Location',
            referral['village'],
            Icons.location_on_outlined,
          ),

          _detailRow(
            'Phone',
            referral['phone'],
            Icons.phone_outlined,
          ),

          _detailRow(
            'Referred To',
            referral['hospital'],
            Icons.local_hospital_outlined,
          ),

          _detailRow(
            'Reason',
            referral['reason'],
            Icons.notes_outlined,
          ),

          _detailRow(
            'Created',
            _formatDate(referral['createdAt']),
            Icons.access_time_outlined,
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    String title,
    dynamic value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Icon(
            icon,
            size: 21,
            color: const Color(0xFF2563EB),
          ),

          const SizedBox(width: 12),

          SizedBox(
            width: 150,

            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value?.toString() ?? '-',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotFound() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),

      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFFED7AA),
        ),
      ),

      child: const Row(
        children: [
          Icon(
            Icons.search_off_rounded,
            color: Color(0xFFD97706),
            size: 28,
          ),

          SizedBox(width: 14),

          Expanded(
            child: Text(
              'No referral was found with this ID. '
              'Please check the referral ID and try again.',
              style: TextStyle(
                color: Color(0xFF9A3412),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(dynamic value) {
    if (value == null) return '-';

    final date = DateTime.tryParse(
      value.toString(),
    );

    if (date == null) return value.toString();

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}