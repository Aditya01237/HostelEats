import 'package:url_launcher/url_launcher.dart';

void openWhatsApp(String phoneNumber, String message) async {
  launchUrl(Uri.parse('https://wa.me/$phoneNumber?text=${message}'),
      mode: LaunchMode.externalApplication);
}