import 'package:convert_unit_currency/features/settings/screen/about_screen.dart';
import 'package:convert_unit_currency/features/settings/screen/constants/constant_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screen_ex/flutter_settings_screen_ex.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool darkSwitch= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.all(24),
        children: [
          SettingsGroup(title: "General", children: [
            const SizedBox(
              height: 8,
            ),
            buildDarkMode(context),
            buildLanguage(context),
            buildFontSize(context)
          ]),
          const SizedBox(
            height: 20,
          ),
          SettingsGroup(title: "Send Feedback", children: [
            const SizedBox(
              height: 8,
            ),
            buildReportBug(context),
            buildSendFeedBack(context),
            buildRateUs(context)
          ]),
          SettingsGroup(

              title: "others",
              children: [const SizedBox(
                height: 35,
              ),
                buildCheckForUpdates(context),
                AboutScreen()]),

        ],
      )),
    );
  }

  Widget buildDarkMode(BuildContext context) {
    return  SwitchSettingsTile(
      leading: darkSwitch ?Icon(Icons.dark_mode) : Icon(Icons.light_mode),
      settingKey: ConstantKeys.keyDarkMode,
      title: 'USB Debugging',
      onChange: (value) {
        setState(() {
          darkSwitch=value;
        });
        debugPrint(' key-is-usb-debugging: $value');
      },
    );
  }

  Widget buildLanguage(BuildContext context) {
    return DropDownSettingsTile(
      title: "Language",
      settingKey: ConstantKeys.keyLanguage,
      selected: 1,
      values: <int, String>{
        1: 'English',
        2: "Arabic",
        3: "French",
        4: 'Chinese'
      },
      onChange: (language) {},
    );
  }

  Widget buildFontSize(BuildContext context) {
    return RadioSettingsTile<int>(
      title: 'Preferred Font Size ',
      settingKey: ConstantKeys.keyFontSize,
      values: const <int, String>{
        10: '10 sp',
        15: '15 sp',
        20: '20 sp',
        25: '25 sp',
        30: '30 sp',
      },
      selected: 10,
      onChange: (value) {
        debugPrint('key-radio-sync-period: $value days');
      },
    );
  }

  Widget buildReportBug(BuildContext context) {
    return SimpleSettingsTile(
      title: "Report A Bug",
      subtitle: '',
      leading: Icon(Icons.bug_report),
      onTap: () {},
    );
  }

  Widget buildSendFeedBack(BuildContext context) {
    return SimpleSettingsTile(
      title: "Send FeedBack",
      subtitle: '',
      leading: Icon(Icons.thumb_up),
      onTap: () {},
    );
  }

  Widget buildRateUs(BuildContext context) {
    return SimpleSettingsTile(
      title: "Rate Us",
      subtitle: '',
      leading: Icon(Icons.star),
      onTap: () {},
    );
  }

  Widget buildCheckForUpdates(BuildContext context) {
    return SimpleSettingsTile(
      title: "Check For Updates",
      subtitle: '',
      leading: Icon(Icons.loop),
      onTap: () {},
    );
  }
}
