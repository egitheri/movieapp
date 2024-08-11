import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  static const _sessionId = 'session_id';
  static const _imageListKey = 'image_list';

  Future<void> saveSessionId(String sessionData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionId, sessionData);
  }

  Future<String?> getSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sessionId);
  }
}
