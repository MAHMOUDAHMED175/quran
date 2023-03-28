import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ytquran/settings.dart';

import 'constant.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.orange[100],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(

            decoration: const BoxDecoration(

              color: Colors.orange,
            ),
            child: Image.asset(
              'assets/quran.png',
              height: 80,
            ),
          ),SizedBox(
            height: 20,
          ),
          Text(
   " واصبر لحكم ربك فإنك بأعيننا",textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold,fontFamily: 'quran'),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text(
              'Settings',
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.share,
            ),
            title: const Text(
              'Share',
            ),
            onTap: () {
              Share.share('''*Quran app*\n''');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.rate_review,
            ),
            title: const Text(
              'Rate',
            ),
            onTap: () async {
              if (!await launchUrl(quranAppurl,
                  mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $quranAppurl';
              }
            },
          ),
        ],
      ),
    );
  }
}
