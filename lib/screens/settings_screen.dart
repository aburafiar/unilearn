import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../providers/app_provider.dart';
import '../data/app_theme.dart';
import '../models/user_model.dart';
import 'onboarding_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final user = provider.user;
    if (user == null) return const SizedBox();

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: AppTheme.cardDecoration,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Learning path', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              const SizedBox(height: 4),
              Text('Switch anytime — your progress is kept separately for each.',
                  style: AppTheme.muted),
              const SizedBox(height: 14),
              Row(children: [
                Expanded(
                  child: _pathButton(
                    context, user, 'academic', '🎓', 'Academic',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _pathButton(
                    context, user, 'nonacademic', '🚀', 'Non-Academic',
                  ),
                ),
              ]),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: AppTheme.cardDecoration,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Profile', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              const SizedBox(height: 10),
              _infoRow('Name', user.name),
              _infoRow('Age', '${user.age}'),
              _infoRow('Country', '${user.flagEmoji} ${user.country}'),
              _infoRow('Level', user.level),
              _infoRow('Parent/Guardian', user.parentName),
            ]),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _confirmReset(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.coral,
                side: const BorderSide(color: AppTheme.coral),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Start over / New profile', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pathButton(BuildContext context, UserModel user, String cat, String icon, String label) {
    final sel = user.category == cat;
    return GestureDetector(
      onTap: () async {
        await context.read<AppProvider>().switchCategory(cat);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Switched to $label! 🎉'), backgroundColor: AppTheme.green),
          );
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: sel ? AppTheme.purpleLight : Colors.white,
          border: Border.all(color: sel ? AppTheme.purple : AppTheme.border, width: sel ? 2 : 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          Text(icon, style: const TextStyle(fontSize: 26)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 13,
            color: sel ? AppTheme.purple : AppTheme.textMuted,
          )),
        ]),
      ),
    );
  }

  Widget _infoRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: AppTheme.muted),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
    ]),
  );

  void _confirmReset(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Start over?'),
        content: const Text('This will erase all your progress, stamps, and streaks. This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              await Hive.box<UserModel>('users').clear();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                  (route) => false,
                );
              }
            },
            child: const Text('Yes, start over', style: TextStyle(color: AppTheme.coral)),
          ),
        ],
      ),
    );
  }
}
