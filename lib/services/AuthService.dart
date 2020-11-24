import 'package:my_authen_jsonfeed/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static final String IS_LOGIN = 'is_login';
  static final String USERNAME = 'usename';

  Future login({User user}) async {
    if (user.Username == 'panich@gmail.com' && user.Password == '12345678') {

      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString(USERNAME, user.Username);
      _prefs.setBool(IS_LOGIN, true);
      return true;
    }
    return false;
  }

  Future<bool> isLogin() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(IS_LOGIN) ?? false;
  }
  Future logout() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(IS_LOGIN);
    
    return await Future<void>.delayed(Duration(seconds: 1));
  }
}
