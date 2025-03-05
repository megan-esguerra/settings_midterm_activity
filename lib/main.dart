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

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool airplaneMode = false;
  bool isWifiEnabled = true;
  bool isBluetoothEnabled = true;

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

          // User account row
          Container(
            color: CupertinoColors.darkBackgroundGray,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: CupertinoColors.systemGrey5,
                  child: Icon(
                    CupertinoIcons.person,
                    color: CupertinoColors.black,
                  ),
                ),
                const SizedBox(width: 10),
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
          const SizedBox(height: 10),

          // First section
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile(
                leading: Icon(
                  CupertinoIcons.exclamationmark_triangle,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Your iPhone can't be backed up"),
                trailing: const CupertinoListTileChevron(),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Second section
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile(
                leading: Icon(
                  CupertinoIcons.info,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Software Update Available"),
                trailing: const CupertinoListTileChevron(),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Third section with Airplane Mode, Wi‑Fi, and Bluetooth
          CupertinoListSection.insetGrouped(
            children: [
              // Airplane Mode tile
              CupertinoListTile(
                leading: Icon(
                  CupertinoIcons.airplane,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Airplane Mode"),
                trailing: CupertinoSwitch(
                  value: airplaneMode,
                  onChanged: (bool value) {
                    setState(() {
                      airplaneMode = value;
                    });
                  },
                ),
              ),
              // Wi‑Fi tile
              CupertinoListTile(
                leading: const Icon(
                  CupertinoIcons.wifi,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Wi‑Fi"),
                trailing: Text(
                  isWifiEnabled ? "On" : "Off",
                  style: const TextStyle(color: CupertinoColors.inactiveGray),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => WifiSettingsPage(
                        isWifiEnabled: isWifiEnabled,
                        onWifiChanged: (value) {
                          setState(() {
                            isWifiEnabled = value;
                            // No longer forcing Bluetooth off here.
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              // Bluetooth tile
              CupertinoListTile(
                leading: const Icon(
                  CupertinoIcons.bluetooth,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Bluetooth"),
                trailing: Text(
                  isBluetoothEnabled ? "On" : "Off",
                  style: const TextStyle(color: CupertinoColors.inactiveGray),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BluetoothSettingsPage(
                        isBluetoothEnabled: isBluetoothEnabled,
                        isWifiEnabled: isWifiEnabled,
                        onBluetoothChanged: (value) {
                          setState(() {
                            isBluetoothEnabled = value;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              CupertinoListTile(
                leading: const Icon(
                  CupertinoIcons.phone,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Cellular"),
                trailing: const CupertinoListTileChevron(),
              ),
              CupertinoListTile(
                leading: const Icon(
                  CupertinoIcons.personalhotspot,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Personal Hotspot"),
                trailing: const Text(
                  "Off",
                  style: TextStyle(color: CupertinoColors.inactiveGray),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Wi‑Fi Settings Page without a "Done" button; changes are sent back immediately.
class WifiSettingsPage extends StatefulWidget {
  final bool isWifiEnabled;
  final ValueChanged<bool> onWifiChanged;

  const WifiSettingsPage({
    Key? key,
    required this.isWifiEnabled,
    required this.onWifiChanged,
  }) : super(key: key);

  @override
  _WifiSettingsPageState createState() => _WifiSettingsPageState();
}

class _WifiSettingsPageState extends State<WifiSettingsPage> {
  late bool isWifiEnabled;

  @override
  void initState() {
    super.initState();
    isWifiEnabled = widget.isWifiEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // The back arrow will automatically appear in the navigation bar.
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Wi‑Fi Settings"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.wifi, size: 32),
                  title: const Text("Wi‑Fi"),
                  subtitle:
                  const Text("Connect to Wi‑Fi, view available networks..."),
                ),
                CupertinoListTile(
                  title: const Text("Wi‑Fi"),
                  trailing: CupertinoSwitch(
                    value: isWifiEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        isWifiEnabled = value;
                      });
                      widget.onWifiChanged(value);
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

// Bluetooth Settings Page without a "Done" button; changes are sent back immediately.
class BluetoothSettingsPage extends StatefulWidget {
  final bool isBluetoothEnabled;
  final bool isWifiEnabled;
  final ValueChanged<bool> onBluetoothChanged;

  const BluetoothSettingsPage({
    Key? key,
    required this.isBluetoothEnabled,
    required this.isWifiEnabled,
    required this.onBluetoothChanged,
  }) : super(key: key);

  @override
  _BluetoothSettingsPageState createState() => _BluetoothSettingsPageState();
}

class _BluetoothSettingsPageState extends State<BluetoothSettingsPage> {
  late bool isBluetoothEnabled;
  late bool isWifiEnabled;

  @override
  void initState() {
    super.initState();
    isBluetoothEnabled = widget.isBluetoothEnabled;
    isWifiEnabled = widget.isWifiEnabled;
    // Do not force Bluetooth off when Wi‑Fi is off.
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // Back arrow provided automatically.
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Bluetooth Settings"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.bluetooth, size: 32),
                  title: const Text("Bluetooth"),
                  subtitle: const Text(
                      "Connect to Bluetooth devices, view available devices..."),
                ),
                CupertinoListTile(
                  title: const Text("Bluetooth"),
                  trailing: CupertinoSwitch(
                    value: isBluetoothEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        isBluetoothEnabled = value;
                      });
                      widget.onBluetoothChanged(value);
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
