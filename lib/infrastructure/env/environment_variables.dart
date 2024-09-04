

import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentVariables {
  //Env Files
  static const String envFileName = '.env';

  //Env variables
  static const String GOOGLE_MAP_API_KEY = 'GOOGLE_MAP_API_KEY';



  static Future<void> initEnvVariables() async {
    await dotenv.load(
      fileName: envFileName,);
  }

  static String setGoogleMapApiKeyValue() {
    String res = dotenv.get(GOOGLE_MAP_API_KEY);

    return res;
  }

}
