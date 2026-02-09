//22k-4156,22k-4574, 22k-4431,22k-4494
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Layout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AdaptiveHomePage(),
    );
  }
}

class AdaptiveHomePage extends StatefulWidget {
  const AdaptiveHomePage({super.key});

  @override
  State<AdaptiveHomePage> createState() => _AdaptiveHomePageState();
}

class _AdaptiveHomePageState extends State<AdaptiveHomePage> {
  int _selectedIndex = 0;
  
  final List<Map<String, dynamic>> _navigationItems = [
    {'title': 'Dashboard', 'icon': Icons.dashboard},
    {'title': 'Messages', 'icon': Icons.message},
    {'title': 'Profile', 'icon': Icons.person},
    {'title': 'Settings', 'icon': Icons.settings},
  ];
  
  final List<Map<String, String>> _contentItems = [
    {'title': 'Main Item 1', 'subtitle': 'Subtext goes here'},
    {'title': 'Main Item 2', 'subtitle': 'Subtext goes here'},
    {'title': 'Main Item 3', 'subtitle': 'Subtext goes here'},
    {'title': 'Main Item 4', 'subtitle': 'Subtext goes here'},
    {'title': 'Main Item 5', 'subtitle': 'Subtext goes here'},
    {'title': 'Main Item 6', 'subtitle': 'Subtext goes here'},
    {'title': 'Main Item 7', 'subtitle': 'Subtext goes here'},
    {'title': 'Main Item 8', 'subtitle': 'Subtext goes here'},
    {'title': 'Main Item 9', 'subtitle': 'Subtext goes here'},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWideScreen = constraints.maxWidth > 600;
        
        return isWideScreen 
            ? _buildDesktopLayout()
            : _buildMobileLayout();
      },
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text('Adaptive Layout'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Navigation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              ..._navigationItems.asMap().entries.map((entry) {
                final int index = entry.key;
                final item = entry.value;
                
                return ListTile(
                  leading: Icon(item['icon']),
                  title: Text(item['title']),
                  selected: _selectedIndex == index,
                  selectedTileColor: Colors.blue[100],
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
      body: _buildMainContent(),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaptive Layout'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          Container(
            width: 250,
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Navigation',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                ..._navigationItems.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final item = entry.value;
                  
                  return ListTile(
                    leading: Icon(item['icon']),
                    title: Text(item['title']),
                    selected: _selectedIndex == index,
                    selectedTileColor: Colors.blue[100],
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  );
                }).toList(),
              ],
            ),
          ),
          const VerticalDivider(
            width: 1,
            thickness: 1,
          ),
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final bool isWideScreen = constraints.maxWidth > 600;
            
            final double headerHeight = isWideScreen ? 250 : 150;
            final double logoSize = isWideScreen ? 80 : 50;
            final double textSize = isWideScreen ? 40 : 24;
            final double spacing = isWideScreen ? 30 : 15;
            
            return Container(
              width: double.infinity,
              height: headerHeight,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlutterLogo(
                      size: logoSize,
                    ),
                    SizedBox(width: spacing),
                    Text(
                      'Header Content',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _contentItems.length,
            itemBuilder: (context, index) {
              final item = _contentItems[index];
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  title: Text(
                    item['title']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    item['subtitle']!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}