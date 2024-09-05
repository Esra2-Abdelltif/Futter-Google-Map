
import 'package:share/share.dart';

shareAddressLink({
  required String lng,
  required String lat,
  required String subject,
}) async {
await Share.share('https://www.google.com/maps/place/$lat,$lng', subject: subject);
}