import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvirontment() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiURl = dotenv.env['API_URL'] ?? 'URL not found';
}
