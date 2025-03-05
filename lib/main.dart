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
          // Search bar at the top
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              placeholder: 'Search',
            ),
          ),

          // User account row (name, avatar, forward arrow)
          Container(
            color: CupertinoColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Circle avatar (placeholder)
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: CupertinoColors.systemGrey5,
                  child: Icon(
                    CupertinoIcons.person,
                    color: CupertinoColors.black,
                  ),
                ),
                const SizedBox(width: 10),
                // User name and subtext
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Megan Esguerra",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Apple Account, iCloud, and more",
                        style: TextStyle(
                          fontSize: 13,
                          color: CupertinoColors.inactiveGray,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  CupertinoIcons.forward,
                  color: CupertinoColors.inactiveGray,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSettingsSection([
            _buildTile(Icons.warning ,
            "Your iPhone cant be back up"
    )
          ]),
          const SizedBox(height: 20),
          _buildSettingsSection([
            _buildTile(Icons.warning ,
                "Software Update Available"
            )
          ]),
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
class WifiSettingsPage extends StatefulWidget {
  const WifiSettingsPage({super.key});

  @override
  _WifiSettingsPageState createState() => _WifiSettingsPageState();
}

class _WifiSettingsPageState extends State<WifiSettingsPage> {
  bool isWifiEnabled = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Settings"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text("Edit", style: TextStyle(color: CupertinoColors.activeBlue)),
          onPressed: () {
            // Handle Edit action
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.wifi, size: 32),
                  title: Text("Wi-Fi"),
                  subtitle: Text("Connect to Wi-Fi, view available networks..."),
                ),
                CupertinoListTile(
                  title: Text("Wi-Fi"),
                  trailing: CupertinoSwitch(
                    value: isWifiEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        isWifiEnabled = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Updated page for Bluetooth settings.
class BluetoothSettingsPage extends StatefulWidget {
  const BluetoothSettingsPage({super.key});

  @override
  _BluetoothSettingsPageState createState() => _BluetoothSettingsPageState();
}

class _BluetoothSettingsPageState extends State<BluetoothSettingsPage> {
  bool isBluetoothEnabled = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Bluetooth Settings"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text("Edit", style: TextStyle(color: CupertinoColors.activeBlue)),
          onPressed: () {
            // Handle Edit action
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.bluetooth, size: 32),
                  title: Text("Bluetooth"),
                  subtitle: Text("Connect to Bluetooth devices, view available devices..."),
                ),
                CupertinoListTile(
                  title: Text("Bluetooth"),
                  trailing: CupertinoSwitch(
                    value: isBluetoothEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        isBluetoothEnabled = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}