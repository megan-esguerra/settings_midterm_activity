import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Settings"),
      ),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          _buildSettingsSection([
            _buildTile(Icons.airplanemode_active, "Airplane Mode", trailing: CupertinoSwitch(value: false, onChanged: (bool value) {})),
            _buildTile(CupertinoIcons.wifi, "Wi-Fi", trailing: Text("WiFi", style: TextStyle(color: CupertinoColors.inactiveGray))),
            _buildTile(CupertinoIcons.bluetooth, "Bluetooth", trailing: Text("On", style: TextStyle(color: CupertinoColors.inactiveGray))),
            _buildTile(CupertinoIcons.phone, "Cellular"),
            _buildTile(CupertinoIcons.personalhotspot, "Personal Hotspot", trailing: Text("Off", style: TextStyle(color: CupertinoColors.inactiveGray))),
          ]),
          const SizedBox(height: 20),
          _buildSettingsSection([
            _buildTile(CupertinoIcons.bell, "Notifications"),
            _buildTile(CupertinoIcons.speaker_3, "Sounds & Haptics"),
            _buildTile(CupertinoIcons.moon, "Focus"),
            _buildTile(CupertinoIcons.hourglass, "Screen Time"),
          ]),
          const SizedBox(height: 20),
          _buildSettingsSection([
            _buildTile(CupertinoIcons.gear, "General"),
            _buildTile(CupertinoIcons.control, "Control Center"),
            _buildTile(CupertinoIcons.brightness, "Display & Brightness"),
            _buildTile(CupertinoIcons.home, "Home Screen & App Library"),
            _buildTile(CupertinoIcons.person_alt_circle, "Accessibility"),
            _buildTile(CupertinoIcons.photo, "Wallpaper"),
          ]),
        ],
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, {Widget? trailing}) {
    return CupertinoListTile(
      leading: Icon(icon, color: CupertinoColors.activeBlue),
      title: Text(title),
      trailing: trailing ?? const CupertinoListTileChevron(),
    );
  }

  Widget _buildSettingsSection(List<Widget> tiles) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: tiles),
    );
  }
}