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
            _buildTile(
              Icons.airplanemode_active,
              "Airplane Mode",
              trailing: CupertinoSwitch(
                value: false,
                onChanged: (bool value) {},
              ),
            ),
            _buildTile(
              CupertinoIcons.wifi,
              "Wi-Fi",
              trailing: const Text(
                "WiFi",
                style: TextStyle(color: CupertinoColors.inactiveGray),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const WifiSettingsPage(),
                  ),
                );
              },
            ),
            _buildTile(
              CupertinoIcons.bluetooth,
              "Bluetooth",
              trailing: const Text(
                "On",
                style: TextStyle(color: CupertinoColors.inactiveGray),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const BluetoothSettingsPage(),
                  ),
                );
              },
            ),
            _buildTile(CupertinoIcons.phone, "Cellular"),
            _buildTile(
              CupertinoIcons.personalhotspot,
              "Personal Hotspot",
              trailing: const Text(
                "Off",
                style: TextStyle(color: CupertinoColors.inactiveGray),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  // Updated _buildTile method to accept an onTap callback.
  Widget _buildTile(IconData icon, String title,
      {Widget? trailing, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CupertinoListTile(
        leading: Icon(icon, color: CupertinoColors.activeBlue),
        title: Text(title),
        trailing: trailing ?? const CupertinoListTileChevron(),
      ),
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

// Dummy page for Wi-Fi settings.
class WifiSettingsPage extends StatelessWidget {
  const WifiSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Wi-Fi Settings"),
      ),
      child: const Center(
        child: Text("Wi-Fi Settings Details"),
      ),
    );
  }
}

// Dummy page for Bluetooth settings.
class BluetoothSettingsPage extends StatelessWidget {
  const BluetoothSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Bluetooth Settings"),
      ),
      child: const Center(
        child: Text("Bluetooth Settings Details"),
      ),
    );
  }
}
