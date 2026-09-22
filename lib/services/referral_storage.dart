import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ReferralStorage {
  static const String _storageKey = 'carelink_referrals';

  /// Save a referral locally.
  static Future<void> saveReferral(Map<String, dynamic> referral) async {
    final prefs = await SharedPreferences.getInstance();

    final existingData = prefs.getStringList(_storageKey) ?? [];

    existingData.add(jsonEncode(referral));

    await prefs.setStringList(_storageKey, existingData);
  }

  /// Get all saved referrals.
  static Future<List<Map<String, dynamic>>> getReferrals() async {
    final prefs = await SharedPreferences.getInstance();

    final existingData = prefs.getStringList(_storageKey) ?? [];

    return existingData
        .map((item) => Map<String, dynamic>.from(jsonDecode(item)))
        .toList();
  }

  /// Find a referral using its referral ID.
  static Future<Map<String, dynamic>?> findReferral(
    String referralId,
  ) async {
    final referrals = await getReferrals();

    for (final referral in referrals) {
      if (referral['referralId'] == referralId) {
        return referral;
      }
    }

    return null;
  }
}