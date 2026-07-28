import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import '../providers/app_provider.dart';
import '../data/app_theme.dart';
import '../data/subjects_data.dart';

class LessonScreen extends StatefulWidget {
  final SubjectData subject;
  final int topicIndex;

  const LessonScreen({super.key, required this.subject, required this.topicIndex});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> with TickerProviderStateMixin {
  bool _readComplete = false;
  String? _ahaResponse;
  late ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  void _markRead() {
    setState(() => _readComplete = true);
    context.read<AppProvider>().completeVideo(widget.subject.name);
  }

  void _ahaAnswer(String type) async {
    setState(() => _ahaResponse = type);
    if (type == 'yes') {
      _confetti.play();
      await context.read<AppProvider>().completeTopic(widget.subject.name, widget.topicIndex);
    }
    if (mounted) {
      final messages = {
        'yes': '🎉 Brilliant! Stamp earned! Moving to next topic!',
        'sort': '👍 That\'s totally fine! Read it once more or try tomorrow.',
        'no': '💛 No worries! Let\'s try a simpler way — you\'ve got this!',
      };
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(messages[type]!),
        backgroundColor: type == 'yes' ? AppTheme.green : type == 'sort' ? AppTheme.amber : AppTheme.purple,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.subject;
    final topic = s.topics[widget.topicIndex];
    final lessonText = s.content[widget.topicIndex];
    final experiment = s.experiments[widget.topicIndex];
    final disclaimer = s.disclaimers[widget.topicIndex % s.disclaimers.length];

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: Text(s.name, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Reading card (replaces video)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                    colors: [Color(s.color), Color(s.color).withOpacity(0.75)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(20)),
                      child: Text('${s.icon} ${s.name}',
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                    ),
                    const Spacer(),
                    const Icon(Icons.menu_book_rounded, color: Colors.white70, size: 20),
                    const SizedBox(width: 4),
                    const Text('~3 min read', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
                  ]),
                  const SizedBox(height: 16),
                  Text(topic, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 12),
                  Text(lessonText, style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.6)),
                ]),
              ),
              const SizedBox(height: 16),
              Wrap(spacing: 8, runSpacing: 6, children: [
                _tag(context.read<AppProvider>().user?.level ?? 'Level 3', AppTheme.purple, AppTheme.purpleLight),
                _tag('📖 Reading', AppTheme.teal, AppTheme.tealLight),
                _tag(s.name, Color(s.color), Color(s.lightColor)),
              ]),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.amberLight,
                  borderRadius: BorderRadius.circular(10),
                  border: const Border(left: BorderSide(color: AppTheme.amber, width: 3)),
                ),
                child: Text(disclaimer,
                    style: const TextStyle(fontSize: 13, color: Color(0xFF7a5200), height: 1.5)),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.tealLight,
                  borderRadius: BorderRadius.circular(10),
                  border: const Border(left: BorderSide(color: AppTheme.teal, width: 3)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('🧪 Try this experiment!',
                      style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF065f46), fontSize: 14)),
                  const SizedBox(height: 6),
                  Text(experiment, style: const TextStyle(color: Color(0xFF047857), fontSize: 13, height: 1.5)),
                ]),
              ),
              const SizedBox(height: 20),
              if (!_readComplete)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _markRead,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(s.color),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('✅ I read this!', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  ),
                ),
              if (_readComplete) ...[
                const Text('Did that make sense?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(child: _ahaBtn('yes', '✅ Yes!\nGot it!', AppTheme.green, AppTheme.greenLight)),
                  const SizedBox(width: 8),
                  Expanded(child: _ahaBtn('sort', '🤔 Sort\nof...', AppTheme.amber, AppTheme.amberLight)),
                  const SizedBox(width: 8),
                  Expanded(child: _ahaBtn('no', '😕 Not\nyet', AppTheme.coral, AppTheme.coralLight)),
                ]),
              ],
              const SizedBox(height: 80),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              colors: const [AppTheme.purple, AppTheme.teal, AppTheme.amber, AppTheme.coral, AppTheme.pink],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String text, Color textColor, Color bgColor) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
    child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: textColor)),
  );

  Widget _ahaBtn(String type, String label, Color textColor, Color bgColor) {
    final selected = _ahaResponse == type;
    return GestureDetector(
      onTap: _ahaResponse == null ? () => _ahaAnswer(type) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: selected ? bgColor : Colors.white,
          border: Border.all(color: selected ? textColor : AppTheme.border, width: selected ? 2 : 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                color: selected ? textColor : AppTheme.textMuted)),
      ),
    );
  }
}
