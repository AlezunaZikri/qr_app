import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Heyy , You",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Welcome Text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore Your',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                Text(
                  'QR Code World',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Buttons Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  BuildButton(
                    icon: Icons.qr_code,
                    label: 'Create',
                    iconColor: Colors.blue,
                    backgroundColor: const Color(0xFFE3F2FD),
                    onTap: () {
                      Navigator.pushNamed(context, '/create');
                    },
                  ),
                  BuildButton(
                    icon: Icons.qr_code_scanner,
                    label: 'Scan',
                    iconColor: Colors.red,
                    backgroundColor: const Color(0xFFFFEBEE),
                    onTap: () {
                      Navigator.pushNamed(context, "/scan");
                    },
                  ),
                  BuildButton(
                    icon: Icons.send,
                    label: 'Send',
                    iconColor: const Color(0xFF4CAF50),
                    backgroundColor: const Color(0xFFE8F5E9),
                    onTap: () {},
                  ),
                  BuildButton(
                    icon: Icons.print,
                    label: 'Print',
                    iconColor: Colors.purple,
                    backgroundColor: const Color(0xFFF3E5F5),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildButton extends StatelessWidget {
  const BuildButton({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.backgroundColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 32,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
