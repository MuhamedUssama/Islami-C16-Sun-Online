import 'package:islami_app_online_sun/core/resources/strings_manager.dart';
import 'package:islami_app_online_sun/models/sura_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveSuraIndexs(String suraIndex) async {
    List<String> mostRecentSuraIndexs =
        _prefs.getStringList(StringsManager.surasPrefsKey) ?? [];

    if (mostRecentSuraIndexs.length >= 5) {
      mostRecentSuraIndexs.remove(mostRecentSuraIndexs.first);
    }

    if (mostRecentSuraIndexs.contains(suraIndex)) {
      mostRecentSuraIndexs.remove(suraIndex);
    }

    mostRecentSuraIndexs.add(suraIndex);

    await _prefs.setStringList(
      StringsManager.surasPrefsKey,
      mostRecentSuraIndexs,
    );
  }

  static Future<List<SuraModel>> getMostRecentSuras() async {
    List<String> mostRecentSuraIndexs =
        _prefs.getStringList(StringsManager.surasPrefsKey) ?? [];

    List<SuraModel> mostRecentSuras = [];

    for (int i = 0; i < mostRecentSuraIndexs.length; i++) {
      int index = int.parse(mostRecentSuraIndexs[i]);
      SuraModel sura = SuraModel.suras[index - 1];
      mostRecentSuras.add(sura);
    }

    return mostRecentSuras.reversed.toList();
  }

  static Future<void> setOnboardingSeen() async {
    await _prefs.setBool(StringsManager.onboardingSeenKey, true);
  }

  static bool getOnboardingSeen() {
    return _prefs.getBool(StringsManager.onboardingSeenKey) ?? false;
  }
}
