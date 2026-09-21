import 'dart:math';

import 'package:flutter/material.dart';

import '../../widgets/input_field.dart';
import '../../widgets/section_card.dart';

class CreateReferralScreen extends StatefulWidget {
  const CreateReferralScreen({super.key});

  @override
  State<CreateReferralScreen> createState() =>
      _CreateReferralScreenState();
}

class _CreateReferralScreenState
    extends State<CreateReferralScreen> {

  // ----------------------------------------------------------
  // FORM CONTROLLERS
  // ----------------------------------------------------------

  final patientNameController =
      TextEditingController();

  final ageController =
      TextEditingController();

  final villageController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final reasonController =
      TextEditingController();

  // ----------------------------------------------------------
  // HOSPITAL
  // ----------------------------------------------------------

  String selectedHospital =
      'City General Hospital';

  bool isGenerating = false;

  // ----------------------------------------------------------
  // DISPOSE
  // ----------------------------------------------------------

  @override
  void dispose() {
    patientNameController.dispose();
    ageController.dispose();
    villageController.dispose();
    phoneController.dispose();
    reasonController.dispose();

    super.dispose();
  }

  // ----------------------------------------------------------
  // GENERATE TRACKING CODE
  // ----------------------------------------------------------

  String generateTrackingCode() {

    const characters =
        'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

    final random = Random();

    String code = '';

    for (int i = 0; i < 5; i++) {
      code += characters[
          random.nextInt(characters.length)];
    }

    return 'REF-$code';
  }

  // ----------------------------------------------------------
  // VALIDATE FORM
  // ----------------------------------------------------------

  bool validateForm() {

    if (patientNameController.text
            .trim()
            .isEmpty ||
        ageController.text
            .trim()
            .isEmpty ||
        villageController.text
            .trim()
            .isEmpty ||
        phoneController.text
            .trim()
            .isEmpty ||
        reasonController.text
            .trim()
            .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill in all the required details.',
          ),
          backgroundColor:
              Color(0xFFDC2626),
          behavior:
              SnackBarBehavior.floating,
        ),
      );

      return false;
    }

    return true;
  }

  // ----------------------------------------------------------
  // CREATE REFERRAL
  // ----------------------------------------------------------

  Future<void> createReferral() async {

    if (!validateForm()) {
      return;
    }

    setState(() {
      isGenerating = true;
    });

    // Small delay to make the generation
    // feel like a real system action.
    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    final trackingCode =
        generateTrackingCode();

    if (!mounted) return;

    // For Step 2 we simply show the
    // generated tracking code.
    _showSuccessDialog(trackingCode);

    setState(() {
      isGenerating = false;
    });
  }

  // ----------------------------------------------------------
  // SUCCESS DIALOG
  // ----------------------------------------------------------

  void _showSuccessDialog(
    String trackingCode,
  ) {

    showDialog(
      context: context,

      barrierDismissible: false,

      builder: (context) {

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(25),
          ),

          child: Padding(
            padding: const EdgeInsets.all(30),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                // SUCCESS ICON

                Container(
                  width: 72,
                  height: 72,

                  decoration:
                      const BoxDecoration(
                    color:
                        Color(0xFFDCFCE7),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.check_rounded,
                    color:
                        Color(0xFF16A34A),
                    size: 42,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Referral Created',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Your referral tracking code is',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 18),

                // TRACKING CODE

                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 18,
                  ),

                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFEFF5FF),
                    borderRadius:
                        BorderRadius.circular(15),
                  ),

                  child: Center(
                    child: Text(
                      trackingCode,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight:
                            FontWeight.w900,
                        color:
                            Color(0xFF2563EB),
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Share this code with the receiving hospital to track the referral.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF2563EB),
                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                13),
                      ),
                    ),

                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ----------------------------------------------------------
  // BUILD
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F8FC),

      // ======================================================
      // APP BAR
      // ======================================================

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Create Referral',
          style: TextStyle(
            fontWeight:
                FontWeight.w800,
          ),
        ),
      ),

      // ======================================================
      // BODY
      // ======================================================

      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(
            maxWidth: 850,
          ),

          child: SingleChildScrollView(
            padding:
                const EdgeInsets.fromLTRB(
              28,
              20,
              28,
              50,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // ==================================================
                // PAGE HEADING
                // ==================================================

                const Text(
                  'Create New Referral',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Enter the patient details and destination hospital.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 30),

                // ==================================================
                // PATIENT INFORMATION
                // ==================================================

                SectionCard(
                  title: 'Patient Information',
                  icon:
                      Icons.person_outline_rounded,

                  child: Column(
                    children: [

                      InputField(
                        controller:
                            patientNameController,

                        label:
                            'Patient Name',

                        hint:
                            'e.g. Amina Shaikh',

                        icon:
                            Icons.person_outline,
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [

                          Expanded(
                            child: InputField(
                              controller:
                                  ageController,

                              label: 'Age',

                              hint: 'e.g. 42',

                              icon:
                                  Icons.calendar_today_outlined,

                              keyboardType:
                                  TextInputType.number,
                            ),
                          ),

                          const SizedBox(width: 18),

                          Expanded(
                            child: InputField(
                              controller:
                                  villageController,

                              label:
                                  'Village / Location',

                              hint:
                                  'e.g. Bhiwandi',

                              icon:
                                  Icons.location_on_outlined,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      InputField(
                        controller:
                            phoneController,

                        label:
                            'Phone Number',

                        hint:
                            'e.g. 9876543210',

                        icon:
                            Icons.phone_outlined,

                        keyboardType:
                            TextInputType.phone,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // ==================================================
                // REFERRAL DETAILS
                // ==================================================

                SectionCard(
                  title: 'Referral Details',
                  icon:
                      Icons.medical_services_outlined,

                  child: Column(
                    children: [

                      // HOSPITAL DROPDOWN

                      DropdownButtonFormField<String>(
                        value:
                            selectedHospital,

                        decoration:
                            InputDecoration(
                          labelText:
                              'Referred To',

                          prefixIcon:
                              const Icon(
                            Icons
                                .local_hospital_outlined,
                          ),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(14),
                          ),
                        ),

                        items: const [

                          DropdownMenuItem(
                            value:
                                'City General Hospital',

                            child: Text(
                              'City General Hospital',
                            ),
                          ),

                          DropdownMenuItem(
                            value:
                                'District Hospital',

                            child: Text(
                              'District Hospital',
                            ),
                          ),

                          DropdownMenuItem(
                            value:
                                'M.H. Medical Centre',

                            child: Text(
                              'M.H. Medical Centre',
                            ),
                          ),
                        ],

                        onChanged:
                            (value) {

                          if (value == null) {
                            return;
                          }

                          setState(() {
                            selectedHospital =
                                value;
                          });
                        },
                      ),

                      const SizedBox(height: 18),

                      // REASON

                      InputField(
                        controller:
                            reasonController,

                        label:
                            'Reason for Referral',

                        hint:
                            'e.g. Specialist consultation',

                        icon:
                            Icons.notes_outlined,

                        maxLines: 3,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ==================================================
                // GENERATE BUTTON
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 58,

                  child: ElevatedButton.icon(

                    onPressed:
                        isGenerating
                            ? null
                            : createReferral,

                    icon: isGenerating
                        ? const SizedBox(
                            width: 20,
                            height: 20,

                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                              color:
                                  Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons
                                .arrow_forward_rounded,
                          ),

                    label: Text(
                      isGenerating
                          ? 'Creating Referral...'
                          : 'Generate Referral',

                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(
                              0xFF2563EB),

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // INFO

                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFEFF5FF),

                    borderRadius:
                        BorderRadius.circular(15),
                  ),

                  child: const Row(
                    children: [

                      Icon(
                        Icons.info_outline_rounded,
                        color:
                            Color(0xFF2563EB),
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          'A unique tracking code will be generated for this referral.',
                          style: TextStyle(
                            color:
                                Color(0xFF1E40AF),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}