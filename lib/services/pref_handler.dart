import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static const String _id = 'idUser';
  static const String _lookWelcoming = 'lookWelcoming';

  // For saving user id
  static void saveId(String id) {
    print('id: $id');
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_id, id);
    });
  }

  static void saveLookWelcoming(bool look) {
    print('look: $look');
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(_lookWelcoming, look);
    });
  }

  //For getting user id
  static Future getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(_id) ?? '';
    return id;
  }

  //For getting look welcoming
  static Future getLookWelcoming() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool look = prefs.getBool(_lookWelcoming) ?? false;
    return look;
  }

  // For removing user id
  static void removeId() {
    SharedPreferences.getInstance().then((prefs) {
      // prefs.remove(_id);
      prefs.clear();
    });
  }
}
