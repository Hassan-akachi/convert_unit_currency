import 'package:flutter/material.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: "Information & Privacy",
      subtitle: 'information & privacy policy in this app',
      leading: Icon(Icons.info),
      child: SettingsScreen(
        title: "Information & Privacy ",
        children: [
          buildInfo(context),
          buildFAQs(context),
          buildPrivacyPolicy(context),
          buildShareApp(context),
          buildSocialIcons(context)
        ],
      ),
    );
  }

  Widget buildInfo(BuildContext context) {
    return SimpleSettingsTile(
      title: "Info about this App",
      subtitle: 'ultimate converter v.1.1',
      leading: Icon(Icons.info),
      onTap: () {},
    );
  }

  Widget buildFAQs(BuildContext context) {
    return SimpleSettingsTile(
      title: "FAQs",
      subtitle: '',
      leading: Icon(Icons.question_answer),
      onTap: () {},
    );
  }

  Widget buildPrivacyPolicy(BuildContext context) {
    return SimpleSettingsTile(
      title: "Privacy Policy",
      subtitle: '',
      leading: Icon(Icons.privacy_tip),
      onTap: () {},
    );
  }

  Widget buildShareApp(BuildContext context) {
    return SimpleSettingsTile(
      title: "Share App",
      subtitle: 'Tell everyone about this app',
      leading: Icon(Icons.share),
      onTap: () {},
    );
  }

  Widget buildSocialIcons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.meta)),
        IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.twitter)),
        IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.github))
      ],
    );
  }
}
