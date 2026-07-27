import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/app_provider.dart';
import '../data/app_theme.dart';
import '../data/subjects_data.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _parentController = TextEditingController();
  String _country = '';
  String _category = '';

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _parentController.dispose();
    super.dispose();
  }

  void _start() async {
    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text.trim()) ?? 0;
    if (name.isEmpty || age < 5 || age > 18 || _country.isEmpty || _category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields!'), backgroundColor: AppTheme.coral),
      );
      return;
    }
    await context.read<AppProvider>().createUser(
      name: name, age: age, country: _country,
      category: _category, parentName: _parentController.text.trim(),
    );
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Text('🌍', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text('Welcome to UniLearn',
                  style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w700, color: AppTheme.purple)),
              const SizedBox(height: 8),
              Text('Just 15 minutes a day — for every kid, everywhere.',
                  textAlign: TextAlign.center,
                  style: AppTheme.muted.copyWith(fontSize: 15, height: 1.5)),
              const SizedBox(height: 32),

              _buildCard(children: [
                _buildLabel('Your name'),
                _buildInput(_nameController, 'e.g. Amir, Yuki, Priya...'),
                _buildLabel('Your age'),
                _buildInput(_ageController, 'e.g. 11', keyboard: TextInputType.number),
                _buildLabel('Your country'),
                _buildDropdown(
                  value: _country.isEmpty ? null : _country,
                  hint: 'Select country...',
                  items: AppData.countries,
                  onChanged: (v) => setState(() => _country = v ?? ''),
                ),
                const SizedBox(height: 16),
                _buildLabel('Learning path'),
                Row(children: [
                  Expanded(child: _catButton('academic', '🎓', 'Academic')),
                  const SizedBox(width: 10),
                  Expanded(child: _catButton('nonacademic', '🚀', 'Non-Academic')),
                ]),
                const SizedBox(height: 16),
                _buildLabel('Parent / Guardian name (optional)'),
                _buildInput(_parentController, 'e.g. Mum, Dad, Guardian...'),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _start,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    child: const Text('Start my learning journey 🚀'),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _catButton(String cat, String icon, String label) {
    final sel = _category == cat;
    return GestureDetector(
      onTap: () => setState(() => _category = cat),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: sel ? AppTheme.purpleLight : Colors.white,
          border: Border.all(color: sel ? AppTheme.purple : AppTheme.border, width: sel ? 2 : 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 14,
              color: sel ? AppTheme.purple : AppTheme.textMuted,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) => Container(
    padding: const EdgeInsets.all(20),
    decoration: AppTheme.cardDecoration,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6, top: 4),
    child: Text(text.toUpperCase(),
        style: AppTheme.label.copyWith(color: AppTheme.textMuted)),
  );

  Widget _buildInput(TextEditingController c, String hint, {TextInputType? keyboard}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: c,
        keyboardType: keyboard,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: AppTheme.bg,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppTheme.border)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppTheme.border)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.purple)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );

  Widget _buildDropdown({required String? value, required String hint, required List<String> items, required ValueChanged<String?> onChanged}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(hint),
        onChanged: onChanged,
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.bg,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppTheme.border)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppTheme.border)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.purple)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
}
