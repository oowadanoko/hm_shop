import 'package:hm_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  String _token = "";

  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  Future<void> init() async {
    SharedPreferences instance = await _getInstance();
    _token = instance.getString(GlobalConstants.TOEKN_KEY) ?? "";
  }

  String getToken() {
    return _token;
  }

  Future<void> setToken(String token) async {
    SharedPreferences instance = await _getInstance();
    instance.setString(GlobalConstants.TOEKN_KEY, token);
    _token = token;
  }

  Future<void> removeToken() async {
    SharedPreferences instance = await _getInstance();
    instance.remove(GlobalConstants.TOEKN_KEY);
    _token = "";
  }
}

final TokenManager tokenManager = TokenManager();
