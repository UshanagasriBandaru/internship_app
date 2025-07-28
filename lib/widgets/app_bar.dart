import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class LTAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const LTAppBar({Key? key, required this.title, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      backgroundColor: Colors.blue[900],
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/company_logo.png'),
            radius: 16,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          tooltip: 'Toggle Theme',
          onPressed: () => themeProvider.toggleTheme(),
        ),
        ...(actions ?? [
          IconButton(
            icon: Icon(Icons.help_outline),
            tooltip: 'Help',
            onPressed: () => Navigator.pushNamed(context, '/help'),
          ),
        ]),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}