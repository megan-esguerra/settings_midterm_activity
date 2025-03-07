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

  void _showDevOpsModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('DevOps Teams'),
        message: Column(
          mainAxisSize: MainAxisSize.min, // Avoids excessive spacing
          children: [
            const Text('Information about DevOps Teams.'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/images/LuisAvatar.jpg",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 5), // Space between images
                ClipOval(
                  child: Image.asset(
                    "assets/images/AdrianAvatar.jpg",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 5),
                ClipOval(
                  child: Image.asset(
                    "assets/images/KristelAvatar.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 5),
                ClipOval(
                  child: Image.asset(
                    "assets/images/MeganAvatar.jpg",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 5),
                ClipOval(
                  child: Image.asset(
                    "assets/images/JohnnIvanAvatar.jpg",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: const Text("Settings"),
        middle: const SizedBox.shrink(), // Remove the default middle text
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _showDevOpsModal(context),
          child: const Icon(CupertinoIcons.info_circle),
        ),
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
            color: CupertinoColors.darkBackgroundGray,
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

          // Third section
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile(
                leading: Icon(
                  CupertinoIcons.airplane,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Airplane Mode"),
                trailing: CupertinoSwitch(
                  value: false,
                  onChanged: (bool value) {},
                ),
              ),
              CupertinoListTile(
                leading: const Icon(
                  CupertinoIcons.wifi,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Wi-Fi"),
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
              CupertinoListTile(
                leading: const Icon(
                  CupertinoIcons.bluetooth,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Bluetooth"),
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
              CupertinoListTile(
                leading: const Icon(
                  CupertinoIcons.phone,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Cellular"),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const CellularSettingsPage(),
                    ),
                  );
                },
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
class WifiSettingsPage extends StatefulWidget {
  const WifiSettingsPage({super.key});

  @override
  _WifiSettingsPageState createState() => _WifiSettingsPageState();
}

class _WifiSettingsPageState extends State<WifiSettingsPage> {
  bool isWifiEnabled = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Settings"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text("Edit",
              style: TextStyle(color: CupertinoColors.activeBlue)),
          onPressed: () {
            // Handle Edit action
          },
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                CupertinoListSection.insetGrouped(
                  children: [
                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.wifi, size: 32),
                      title: Text("Wi-Fi"),
                      subtitle: Text(
                          "Connect to Wi-Fi, view available networks..."),
                    ),
                    CupertinoListTile(
                      title: Text("Wi-Fi"),
                      trailing: CupertinoSwitch(
                        value: isWifiEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            isLoading = true; // Start loading when the switch changes
                            isWifiEnabled = value;
                          });
                          // Simulate a delay for demonstration purposes
                          Future.delayed(Duration(seconds: 2), () {
                            setState(() {
                              isLoading = false; // Stop loading after the delay
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (isLoading) // Show the indicator only when isLoading is true
              Center(
                child: CupertinoActivityIndicator(
                  radius: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}


class BluetoothSettingsPage extends StatefulWidget {
  const BluetoothSettingsPage({super.key});

  @override
  _BluetoothSettingsPageState createState() => _BluetoothSettingsPageState();
}

class _BluetoothSettingsPageState extends State<BluetoothSettingsPage> {
  bool isBluetoothEnabled = true;
  bool bluetoothState = true;
  bool activityIndicator = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Bluetooth Settings"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            "Edit",
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
          onPressed: () {
            // Handle Edit action
          },
        ),
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
                    "Connect to Bluetooth devices, view available devices...",
                  ),
                ),
                CupertinoListTile(
                  title: const Text("Bluetooth"),
                  trailing: CupertinoSwitch(
                    value: isBluetoothEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        isBluetoothEnabled = value;
                        activityIndicator = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            if (activityIndicator)
              const Center(
                child: CupertinoActivityIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

class CellularSettingsPage extends StatefulWidget {
  const CellularSettingsPage({Key? key}) : super(key: key);

  @override
  _CellularSettingsPageState createState() => _CellularSettingsPageState();
}

class _CellularSettingsPageState extends State<CellularSettingsPage> {
  bool isCellularDataEnabled = true;
  bool isDataRoamingEnabled = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = CupertinoTheme.brightnessOf(context) == Brightness.dark;
    return CupertinoPageScaffold(
      backgroundColor: isDarkMode
          ? CupertinoColors.black
          : CupertinoColors.systemGrey6,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: isDarkMode
            ? CupertinoColors.black
            : CupertinoColors.systemGrey6,
        middle: Text("Cellular Data Settings"),
      ),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          CupertinoListSection.insetGrouped(
            backgroundColor: isDarkMode
                ? CupertinoColors.black
                : CupertinoColors.systemGrey6,
            children: [
              CupertinoListTile(
                leading: Icon(CupertinoIcons.antenna_radiowaves_left_right, size: 32),
                title: Text("Cellular"),
                subtitle: Text("Find out how much data you're using, set data restriction, manage carrier settings such as esim, and more. learn more..."),
              ),
              CupertinoListTile(
                leading: Icon(CupertinoIcons.phone, size: 32),
                title: Text("Cellular Data"),
                trailing: CupertinoSwitch(
                  value: isCellularDataEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      isCellularDataEnabled = value;
                    });
                  },
                ),
              ),
              CupertinoListTile(
                title: Text("Data Usage"),
                trailing: Text(
                  "2.5 GB",
                  style: TextStyle(color: CupertinoColors.inactiveGray),
                ),
              ),
              CupertinoListTile(
                title: Text("Data Roaming"),
                trailing: CupertinoSwitch(
                  value: isDataRoamingEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      isDataRoamingEnabled = value;
                    });
                  },
                ),
              ),
              CupertinoListTile(
                title: Text("Network Selection"),
                trailing: Text(
                  "Automatic",
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




