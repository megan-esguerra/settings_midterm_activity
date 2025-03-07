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
  bool isWifiEnabled = false; // Initially off
  bool isBluetoothEnabled = false; // Initially off
  String? connectedWifiNetwork;
  String? connectedBluetoothDevice;

  void _showDevOpsModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('DevOps Teams'),
        message: Column(
          mainAxisSize: MainAxisSize.min,
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
                const SizedBox(width: 5),
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

  void _toggleAirplaneMode(bool value) {
    setState(() {
      airplaneMode = value;
      if (airplaneMode) {
        // Turn off Wi-Fi and Bluetooth when Airplane Mode is turned on
        isWifiEnabled = false;
        isBluetoothEnabled = false;
        connectedWifiNetwork = null;
        connectedBluetoothDevice = null;
      } else {
        // When Airplane Mode is turned off, set Wi-Fi and Bluetooth to "Not Connected"
        connectedWifiNetwork = null;
        connectedBluetoothDevice = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: const Text("Settings"),
        middle: const SizedBox.shrink(),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _showDevOpsModal(context),
          child: const Icon(CupertinoIcons.info_circle),
        ),
      ),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              placeholder: 'Search',
            ),
          ),
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
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile(
                leading: Icon(
                  CupertinoIcons.airplane,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Airplane Mode"),
                trailing: CupertinoSwitch(
                  value: airplaneMode,
                  onChanged: _toggleAirplaneMode,
                ),
              ),
              CupertinoListTile(
                leading: const Icon(
                  CupertinoIcons.wifi,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Wi-Fi"),
                trailing: Text(
                  connectedWifiNetwork ?? "Not Connected",
                  style: const TextStyle(color: CupertinoColors.inactiveGray),
                ),
                onTap: () {
                  if (!airplaneMode) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => WifiSettingsPage(
                          isWifiEnabled: isWifiEnabled,
                          onWifiChanged: (value) {
                            setState(() {
                              isWifiEnabled = value;
                              if (!value) {
                                connectedWifiNetwork = null;
                              }
                            });
                          },
                          onConnected: (network) {
                            setState(() {
                              connectedWifiNetwork = network;
                            });
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
              CupertinoListTile(
                leading: const Icon(
                  CupertinoIcons.bluetooth,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Bluetooth"),
                trailing: Text(
                  connectedBluetoothDevice ?? "Not Connected",
                  style: const TextStyle(color: CupertinoColors.inactiveGray),
                ),
                onTap: () {
                  if (!airplaneMode) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => BluetoothSettingsPage(
                          isBluetoothEnabled: isBluetoothEnabled,
                          onBluetoothChanged: (value) {
                            setState(() {
                              isBluetoothEnabled = value;
                              if (!value) {
                                connectedBluetoothDevice = null;
                              }
                            });
                          },
                          onConnected: (device) {
                            setState(() {
                              connectedBluetoothDevice = device;
                            });
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
              CupertinoListTile(
                leading: const Icon(
                  CupertinoIcons.phone,
                  color: CupertinoColors.activeBlue,
                ),
                title: const Text("Cellular"),
                trailing: const CupertinoListTileChevron(),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const CellularSettingsPage(),
                    ),
                  );
                },
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
  final bool isWifiEnabled;
  final ValueChanged<bool> onWifiChanged;
  final ValueChanged<String> onConnected;

  const WifiSettingsPage({
    Key? key,
    required this.isWifiEnabled,
    required this.onWifiChanged,
    required this.onConnected,
  }) : super(key: key);

  @override
  _WifiSettingsPageState createState() => _WifiSettingsPageState();
}

class _WifiSettingsPageState extends State<WifiSettingsPage> {
  late bool isWifiEnabled;
  bool isLoading = false;
  bool isConnected = false;
  String? connectedNetwork;
  List<String> availableWifiNetworks = [
    "HCC_ICSlab",
    "HCC_CpELab",
    "HCC_NETLab",
    "HCC_CELab"
  ];

  @override
  void initState() {
    super.initState();
    isWifiEnabled = widget.isWifiEnabled;
  }

  void _toggleWifi(bool value) {
    setState(() {
      isLoading = true;
      isWifiEnabled = value;
      if (!value) {
        isConnected = false;
        connectedNetwork = null;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
      widget.onWifiChanged(value);
    });
  }

  void _connectToWifi(String network) {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        isConnected = true;
        connectedNetwork = network;
      });
      widget.onConnected(network);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Wi-Fi Settings"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoListSection.insetGrouped(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [CupertinoColors.systemBlue, CupertinoColors.systemTeal],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(CupertinoIcons.wifi, size: 32, color: CupertinoColors.white),
                      const SizedBox(height: 10),
                      const Text(
                        "Wi-Fi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Connect to Wi-Fi networks, view available networks...",
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                CupertinoListTile(
                  title: const Text("Wi-Fi"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLoading)
                        const CupertinoActivityIndicator(
                          radius: 10,
                        ),
                      const SizedBox(width: 8),
                      CupertinoSwitch(
                        value: isWifiEnabled,
                        onChanged: _toggleWifi,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isWifiEnabled)
              CupertinoListSection.insetGrouped(
                header: const Text("Choose a Network"),
                children: availableWifiNetworks.map((network) {
                  return CupertinoListTile(
                    leading: const Icon(CupertinoIcons.wifi),
                    title: Text(network),
                    trailing: isConnected && connectedNetwork == network
                        ? const Icon(CupertinoIcons.checkmark_alt,
                        color: CupertinoColors.activeGreen)
                        : null,
                    onTap: () => _connectToWifi(network),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class BluetoothSettingsPage extends StatefulWidget {
  final bool isBluetoothEnabled;
  final ValueChanged<bool> onBluetoothChanged;
  final ValueChanged<String> onConnected;

  const BluetoothSettingsPage({
    Key? key,
    required this.isBluetoothEnabled,
    required this.onBluetoothChanged,
    required this.onConnected,
  }) : super(key: key);

  @override
  _BluetoothSettingsPageState createState() => _BluetoothSettingsPageState();
}

class _BluetoothSettingsPageState extends State<BluetoothSettingsPage> {
  late bool isBluetoothEnabled;
  bool isLoading = false;
  bool isConnected = false;
  String? connectedDevice;
  List<String> availableDevices = [
    "Kristel's Device",
    "Infinix_1",
    "Galaxy Watch",
  ];

  @override
  void initState() {
    super.initState();
    isBluetoothEnabled = widget.isBluetoothEnabled;
  }

  void _toggleBluetooth(bool value) {
    setState(() {
      isLoading = true;
      isBluetoothEnabled = value;
      if (!value) {
        isConnected = false;
        connectedDevice = null;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
      widget.onBluetoothChanged(value);
    });
  }

  void _connectToDevice(String device) {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        isConnected = true;
        connectedDevice = device;
      });
      widget.onConnected(device);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Bluetooth Settings"),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoListSection.insetGrouped(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [CupertinoColors.systemPurple, CupertinoColors.systemPink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(CupertinoIcons.bluetooth, size: 32, color: CupertinoColors.white),
                      const SizedBox(height: 10),
                      const Text(
                        "Bluetooth",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Connect to Bluetooth devices, view available devices...",
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                CupertinoListTile(
                  title: const Text("Bluetooth"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLoading)
                        const CupertinoActivityIndicator(
                          radius: 10,
                        ),
                      const SizedBox(width: 8),
                      CupertinoSwitch(
                        value: isBluetoothEnabled,
                        onChanged: _toggleBluetooth,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isBluetoothEnabled)
              CupertinoListSection.insetGrouped(
                header: const Text("My Devices"),
                children: availableDevices.map((device) {
                  return CupertinoListTile(
                    leading: const Icon(CupertinoIcons.bluetooth),
                    title: Text(device),
                    trailing: isConnected && connectedDevice == device
                        ? const Icon(CupertinoIcons.checkmark_alt,
                        color: CupertinoColors.activeGreen)
                        : null,
                    onTap: () => _connectToDevice(device),
                  );
                }).toList(),
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




