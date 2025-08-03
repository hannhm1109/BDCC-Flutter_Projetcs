import 'package:flutter/material.dart';
import 'package:demo_app_2/widgets/mydrawer.widget.dart';

class ContactsPage extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {
      'name': 'Hanane Nahim',
      'email': 'hanane.nahim@bdcc.edu',
      'phone': '+212 612-345-678'
    },
    {
      'name': 'Emma Rodriguez',
      'email': 'emma.rodriguez@techcorp.com',
      'phone': '+1 555-0123'
    },
    {
      'name': 'Marcus Thompson',
      'email': 'm.thompson@innovate.io',
      'phone': '+1 555-0124'
    },
    {
      'name': 'Sofia Chen',
      'email': 's.chen@dataflow.net',
      'phone': '+1 555-0125'
    },
    {
      'name': 'Alex Mitchell',
      'email': 'a.mitchell@cloudtech.com',
      'phone': '+1 555-0126'
    },
    {
      'name': 'Luna Patel',
      'email': 'l.patel@nexusdev.org',
      'phone': '+1 555-0127'
    },
    {
      'name': 'Jordan Williams',
      'email': 'j.williams@bytecode.co',
      'phone': '+1 555-0128'
    },
    {
      'name': 'Maya Johnson',
      'email': 'm.johnson@pixelwork.dev',
      'phone': '+1 555-0129'
    },
    {
      'name': 'Ryan Foster',
      'email': 'r.foster@appstudio.tech',
      'phone': '+1 555-0130'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: const Text("Contacts")),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          final initials = contact['name']!.split(' ').map((e) => e[0]).join();

          // Beautiful gradient colors for avatars
          final List<List<Color>> gradientColors = [
            [Color(0xFF667eea), Color(0xFF764ba2)], // Purple-Blue
            [Color(0xFFf093fb), Color(0xFFf5576c)], // Pink-Red
            [Color(0xFF4facfe), Color(0xFF00f2fe)], // Blue-Cyan
            [Color(0xFF43e97b), Color(0xFF38f9d7)], // Green-Mint
            [Color(0xFFfa709a), Color(0xFFfee140)], // Pink-Yellow
            [Color(0xFF30cfd0), Color(0xFF91a7ff)], // Teal-Lavender
            [Color(0xFFa8edea), Color(0xFFfed6e3)], // Mint-Pink
            [Color(0xFFffecd2), Color(0xFFfcb69f)], // Peach-Orange
            [Color(0xFF89f7fe), Color(0xFF66a6ff)], // Light Blue-Blue
          ];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: gradientColors[index % gradientColors.length],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[index % gradientColors.length][0].withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              title: Text(
                contact['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "${contact['email']}\n${contact['phone']}",
                style: TextStyle(
                  color: Colors.grey[600],
                  height: 1.3,
                ),
              ),
              isThreeLine: true,
              trailing: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey,
                ),
              ),
              onTap: () {
              },
            ),
          );
        },
      ),
    );
  }
}