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
  bool isWifiEnabled = false;
  bool isBluetoothEnabled = false;
  String? connectedWifiNetwork;
  String? connectedBluetoothDevice;

  // List of accounts with avatars
  final List<Map<String, String>> accounts = [
    {"name": "Megan Esguerra", "email": "megan@example.com", "avatar": "assets/images/MeganAvatar.jpg"},
    {"name": "Luis Gabrielle Estacio", "email": "luis@example.com", "avatar": "assets/images/LuisAvatar.jpg"},
    {"name": "Adrian Mhaki  Macabali", "email": "adrian@example.com", "avatar": "assets/images/AdrianAvatar.jpg"},
    {"name": "Kristel Culala", "email": "kristel@example.com", "avatar": "assets/images/KristelAvatar.png"},
    {"name": "John Ivan Baligod", "email": "john@example.com", "avatar": "assets/images/JohnnIvanAvatar.jpg"},
  ];

  String selectedAccount = "Megan Esguerra"; // Default selected account

  void _showAccountSelectionModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select Account'),
        message: const Text('Choose an account to switch to'),
        actions: accounts.map((account) {
          return CupertinoActionSheetAction(
            child: Text(account["name"]!),
            onPressed: () {
              setState(() {
                selectedAccount = account["name"]!;
              });
              Navigator.pop(context);
            },
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Cancel',
            style: TextStyle(color: CupertinoColors.destructiveRed),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

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
                _buildAvatar("assets/images/LuisAvatar.jpg", "Luis  "),
                const SizedBox(width: 10),
                _buildAvatar("assets/images/AdrianAvatar.jpg", "Adrian  "),
                const SizedBox(width: 10),
                _buildAvatar("assets/images/KristelAvatar.png", "Kristel "),
                const SizedBox(width: 10),
                _buildAvatar("assets/images/MeganAvatar.jpg", "Megan "),
                const SizedBox(width: 10),
                _buildAvatar("assets/images/JohnnIvanAvatar.jpg", "JohnIvan "),
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

  Widget _buildAvatar(String imagePath, String name) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _toggleAirplaneMode(bool value) {
    setState(() {
      airplaneMode = value;
      if (airplaneMode) {
        isWifiEnabled = false;
        isBluetoothEnabled = false;
        connectedWifiNetwork = null;
        connectedBluetoothDevice = null;
      } else {
        connectedWifiNetwork = null;
        connectedBluetoothDevice = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Find the selected account's avatar
    String selectedAvatar = accounts.firstWhere((account) => account["name"] == selectedAccount)["avatar"]!;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          CupertinoListSection.insetGrouped(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: [
              CupertinoListTile(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: CupertinoColors.systemGrey5,
                  backgroundImage: AssetImage(selectedAvatar),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedAccount,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Apple Account, iCloud, and more",
                      style: TextStyle(
                        fontSize: 13,
                        color: CupertinoColors.inactiveGray,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(
                  CupertinoIcons.forward,
                  color: CupertinoColors.inactiveGray,
                ),
                onTap: () {
                  _showAccountSelectionModal(context);
                },
              ),
            ],
          ),

          CupertinoListSection.insetGrouped(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
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

          CupertinoListSection.insetGrouped(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
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


          CupertinoListSection.insetGrouped(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
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
  bool isWifiLoading = false;
  bool isNetworkLoading = false;
  bool isConnected = false;
  String? connectedNetwork;
  String? loadingNetwork;
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
      isWifiLoading = true;
      isWifiEnabled = value;
      if (!value) {
        isConnected = false;
        connectedNetwork = null;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isWifiLoading = false;
      });
      widget.onWifiChanged(value);
    });
  }

  void _connectToWifi(String network) {
    setState(() {
      isNetworkLoading = true;
      loadingNetwork = network;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isNetworkLoading = false;
        isConnected = true;
        connectedNetwork = network;
        loadingNetwork = null;
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CupertinoListSection.insetGrouped(
                      children: [
                        Container(
                          decoration: BoxDecoration(
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
                              RichText(
                                text: TextSpan(
                                  text: "Connect to Wi-Fi networks, view available networks ",
                                  style: TextStyle(
                                    color: CupertinoColors.white,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "learn more...",
                                      style: TextStyle(
                                        color: CupertinoColors.activeBlue,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        CupertinoListTile(
                          title: const Text("Wi-Fi"),
                          trailing: CupertinoSwitch(
                            value: isWifiEnabled,
                            onChanged: _toggleWifi,
                          ),
                        ),
                      ],
                    ),
                    if (isWifiEnabled)
                      CupertinoListSection.insetGrouped(
                        header: const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "CHOOSE A NETWORK",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        children: availableWifiNetworks.map((network) {
                          return CupertinoListTile(
                            leading: const Icon(CupertinoIcons.wifi),
                            title: Text(network),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (loadingNetwork == network)
                                  const CupertinoActivityIndicator(radius: 10),
                                if (isConnected && connectedNetwork == network)
                                  const Icon(CupertinoIcons.checkmark_alt, color: CupertinoColors.activeGreen),
                              ],
                            ),
                            onTap: () => _connectToWifi(network),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ),
            if (isWifiLoading)
              const Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: CupertinoActivityIndicator(radius: 15),
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
  bool isBluetoothLoading = false;
  bool isDeviceLoading = false;
  bool isConnected = false;
  String? connectedDevice;
  String? loadingDevice;
  List<Map<String, dynamic>> availableBluetoothDevices = [
    {"name": "Kristel's Device", "icon": CupertinoIcons.device_laptop},
    {"name": "Infinix_1", "icon": CupertinoIcons.device_phone_portrait},
    {"name": "Galaxy 7", "icon": CupertinoIcons.device_phone_portrait},
  ];

  @override
  void initState() {
    super.initState();
    isBluetoothEnabled = widget.isBluetoothEnabled;
  }

  void _toggleBluetooth(bool value) {
    setState(() {
      isBluetoothLoading = true;
      isBluetoothEnabled = value;
      if (!value) {
        isConnected = false;
        connectedDevice = null;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isBluetoothLoading = false;
      });
      widget.onBluetoothChanged(value);
    });
  }

  void _connectToDevice(String device) {
    setState(() {
      isDeviceLoading = true;
      loadingDevice = device;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isDeviceLoading = false;
        isConnected = true;
        connectedDevice = device;
        loadingDevice = null;
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CupertinoListSection.insetGrouped(
                      children: [
                        Container(
                          decoration: BoxDecoration(
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
                              RichText(
                                text: TextSpan(
                                  text: "Connect to Bluetooth devices, view available devices ",
                                  style: TextStyle(
                                    color: CupertinoColors.white,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "learn more...",
                                      style: TextStyle(
                                        color: CupertinoColors.activeBlue,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        CupertinoListTile(
                          title: const Text("Bluetooth"),
                          trailing: CupertinoSwitch(
                            value: isBluetoothEnabled,
                            onChanged: _toggleBluetooth,
                          ),
                        ),
                      ],
                    ),
                    if (isBluetoothEnabled)
                      CupertinoListSection.insetGrouped(
                        header: const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "AVAILABLE DEVICES",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        children: availableBluetoothDevices.map((device) {
                          return CupertinoListTile(
                            leading: Icon(device["icon"], color: CupertinoColors.white),
                            title: Text(device["name"]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (loadingDevice == device["name"])
                                  const CupertinoActivityIndicator(radius: 10),
                                if (isConnected && connectedDevice == device["name"])
                                  const Icon(CupertinoIcons.checkmark_alt, color: CupertinoColors.activeGreen),
                              ],
                            ),
                            onTap: () => _connectToDevice(device["name"]),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ),
            if (isBluetoothLoading)
              const Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: CupertinoActivityIndicator(radius: 15),
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
                title: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RichText(
                    text: TextSpan(
                      text: "Find out how much data you're using, set data restriction, manage carrier settings such as esim, and more. ",
                      style: TextStyle(
                        color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "learn more...",
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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