import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ytquran/screen/AppInfoScreen.dart';
import 'package:ytquran/screen/HelpScreen.dart';
import 'package:ytquran/screen/SettingsScreen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuItemBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            // shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => SettingsScreen()),
              ).then((response) => null),
            ),
          ),
          Card(
            // shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () => Share.share(
                  "Masjid Mode - A Silent Scheduler App. Please visit https://play.google.com/store/apps/details?id=com and download this awesome app.",
                  subject: 'Masjid Mode - A Silent Scheduler App.'),
            ),
          ),
          Card(
            // shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.star),
              title: const Text('Rate'),
              onTap: () async => await canLaunch(
                      "https://play.google.com/store/apps/details?id=com.")
                  ? await launch(
                      "https://play.google.com/store/apps/details?id=com.")
                  : throw 'Could not launch',
            ),
          ),
          Card(
            // shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy Policy'),
              onTap: () async => await canLaunch(
                      "https://masjidmode.org/privacy.html")
                  ? await launch(
                      "https://masjidmode.org/privacy.html")
                  : throw 'Could not launch',
            ),
          ),
          Card(
            // shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => HelpScreen()),
              ).then((response) => null),
            ),
          ),
          Card(
            // shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => AppInfoScreen()),
              ).then((response) => null),
            ),
          ),
          Card(
            // shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.apps),
              title: const Text('More Apps'),
              onTap: () async => await canLaunch(
                      "https://play.google.com/store/apps/developer?id=")
                  ? await launch(
                      "https://play.google.com/store/apps/developer?id=")
                  : throw 'Could not launch',
            ),
          ),
        ],
      ),
    );
  }
}
