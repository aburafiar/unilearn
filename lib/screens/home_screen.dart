import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../data/app_theme.dart';
import 'tabs/all_tabs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  final _tabs = const [
    HomeTab(),
    ScheduleTab(),
    LearnTab(),
    PerformanceTab(),
    PassportTab(),
  ];

  final _tabItems = const [
    BottomNavigationBarItem(icon: Text('🏠', style: TextStyle(fontSize: 22)), label: 'Home'),
    BottomNavigationBarItem(icon: Text('📅', style: TextStyle(fontSize: 22)), label: 'Schedule'),
    BottomNavigationBarItem(icon: Text('🎬', style: TextStyle(fontSize: 22)), label: 'Learn'),
    BottomNavigationBarItem(icon: Text('📊', style: TextStyle(fontSize: 22)), label: 'Progress'),
    BottomNavigationBarItem(icon: Text('🌍', style: TextStyle(fontSize: 22)), label: 'Passport'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _tab, children: _tabs),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.read<AppProvider>().markTired();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('😴 Rest noted! See you tomorrow — no worries! 💛'),
                backgroundColor: AppTheme.amber,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        backgroundColor: AppTheme.amber,
        foregroundColor: Colors.white,
        label: const Text('😴 Tired today', style: TextStyle(fontWeight: FontWeight.w700)),
        elevation: 4,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.purple,
        unselectedItemColor: AppTheme.textMuted,
        backgroundColor: Colors.white,
        elevation: 16,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
        items: _tabItems,
      ),
    );
  }
}
