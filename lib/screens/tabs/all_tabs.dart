import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/app_provider.dart';
import '../../data/app_theme.dart';
import '../../data/subjects_data.dart';
import '../lesson_screen.dart';

List<SubjectData> _subjectsFor(String cat) =>
    cat == 'academic' ? AppData.academicSubjects : AppData.nonAcademicSubjects;

// ─── HOME TAB ───────────────────────────────────────────────────
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppProvider>().user;
    if (user == null) return const SizedBox();
    final subjects = _subjectsFor(user.category);
    final wasAbsent = context.read<AppProvider>().wasAbsentYesterday;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: Row(children: [
          Text('Uni', style: GoogleFonts.poppins(color: AppTheme.purple, fontWeight: FontWeight.w800, fontSize: 22)),
          Text('Learn', style: GoogleFonts.poppins(color: AppTheme.textMuted, fontWeight: FontWeight.w600, fontSize: 22)),
        ]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(child: Text('🔥 ${user.streak}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.gradientDecoration,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${_greeting()}, ${user.name}! 👋',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(user.streak > 1 ? "You're on a ${user.streak}-day streak! 🔥" : "Ready for today's 15 minutes? 🌟",
                  style: const TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 12),
              Wrap(spacing: 8, children: [
                _badge(user.level),
                _badge('${user.flagEmoji} ${user.country.split(' ').first}'),
                _badge(user.category == 'academic' ? '🎓 Academic' : '🚀 Non-Academic'),
              ]),
            ]),
          ),
          const SizedBox(height: 16),
          if (wasAbsent && user.parentName.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.tealLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.teal),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('💬 Message from ${user.parentName}',
                    style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF065f46), fontSize: 14)),
                const SizedBox(height: 6),
                Text('Hey ${user.name}! I noticed you missed a day on UniLearn. No worries — just 15 minutes today? I\'m proud of you no matter what. 💛',
                    style: const TextStyle(color: Color(0xFF047857), fontSize: 13, height: 1.5)),
              ]),
            ),
          _sectionTitle("Today's plan"),
          ...subjects.take(2).map((s) {
            final topicIdx = (user.topicProgress[s.name] ?? 0) % s.topics.length;
            return _todayCard(context, s, topicIdx);
          }),
          const SizedBox(height: 8),
          _sectionTitle('Your subjects'),
          ...subjects.map((s) {
            final done = user.topicProgress[s.name] ?? 0;
            final pct = done / s.topics.length;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.cardDecoration,
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('${s.icon} ${s.name}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  Text('$done/${s.topics.length}',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(s.color))),
                ]),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: pct, minHeight: 8,
                  backgroundColor: AppTheme.bg,
                  valueColor: AlwaysStoppedAnimation(Color(s.color)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ]),
            );
          }),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _badge(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
  );

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(children: [
      Container(width: 10, height: 10, decoration: const BoxDecoration(color: AppTheme.purple, shape: BoxShape.circle)),
      const SizedBox(width: 8),
      Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
    ]),
  );

  Widget _todayCard(BuildContext context, SubjectData s, int topicIdx) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => LessonScreen(subject: s, topicIndex: topicIdx),
      )),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.cardDecoration,
        child: Row(children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(color: Color(s.lightColor), borderRadius: BorderRadius.circular(14)),
            child: Center(child: Text(s.icon, style: const TextStyle(fontSize: 26))),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s.name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800,
                color: Color(s.color), letterSpacing: 0.5)),
            const SizedBox(height: 2),
            Text(s.topics[topicIdx], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Row(children: [
              const Text('⏱ 15 min', style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Color(s.lightColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Video', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(s.color))),
              ),
            ]),
          ])),
          const Icon(Icons.chevron_right, color: AppTheme.textMuted),
        ]),
      ),
    );
  }
}

// ─── SCHEDULE TAB ───────────────────────────────────────────────
class ScheduleTab extends StatelessWidget {
  const ScheduleTab({super.key});

  static const _schedTypes = AppData.scheduleTypes;
  static const _schedLabels = AppData.scheduleLabels;
  static const _schedColors = [
    AppTheme.purple, AppTheme.blue, AppTheme.purple,
    AppTheme.blue, AppTheme.amber, AppTheme.teal, AppTheme.pink,
  ];

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppProvider>().user;
    if (user == null) return const SizedBox();
    final subjects = _subjectsFor(user.category);
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(title: const Text('My Schedule')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final d = today.subtract(Duration(days: today.weekday % 7 - i));
                final isToday = i == today.weekday % 7;
                final att = user.attendance[d.toLocal().toString().split(' ')[0]];
                Color bg = Colors.white;
                Color txt = AppTheme.textMuted;
                Color brd = AppTheme.border;
                if (isToday) { bg = AppTheme.purple; txt = Colors.white; brd = AppTheme.purple; }
                else if (att == 'present') { bg = AppTheme.greenLight; txt = AppTheme.green; brd = AppTheme.green; }
                else if (att == 'absent') { bg = AppTheme.coralLight; txt = AppTheme.coral; brd = AppTheme.coral; }
                else if (att == 'tired') { bg = AppTheme.amberLight; txt = AppTheme.amber; brd = AppTheme.amber; }
                return Container(
                  width: 56,
                  decoration: BoxDecoration(color: bg, border: Border.all(color: brd, width: 1.5), borderRadius: BorderRadius.circular(12)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(days[i], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: txt)),
                    const SizedBox(height: 2),
                    Text('${d.day}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: txt)),
                  ]),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text('This week\'s plan', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          ...List.generate(7, (i) {
            final s = subjects[i % subjects.length];
            final topicIdx = (user.topicProgress[s.name] ?? 0) % s.topics.length;
            final col = _schedColors[i % _schedColors.length];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.cardDecoration,
              child: Row(children: [
                Container(width: 44, height: 44,
                    decoration: BoxDecoration(color: Color(s.lightColor), borderRadius: BorderRadius.circular(12)),
                    child: Center(child: Text(s.icon, style: const TextStyle(fontSize: 22)))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(s.name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(s.color))),
                  Text(s.topics[topicIdx], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  Text(_schedLabels[i], style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: col.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: Text(_schedTypes[i], style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: col)),
                ),
              ]),
            );
          }),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// ─── LEARN TAB ───────────────────────────────────────────────────
class LearnTab extends StatelessWidget {
  const LearnTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppProvider>().user;
    if (user == null) return const SizedBox();
    final subjects = _subjectsFor(user.category);

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(title: const Text('Learn')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: subjects.map((s) {
          final topicIdx = (user.topicProgress[s.name] ?? 0) % s.topics.length;
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (_) => LessonScreen(subject: s, topicIndex: topicIdx),
            )),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: AppTheme.cardDecoration,
              child: Column(children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(s.lightColor),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Center(child: Text(s.icon, style: const TextStyle(fontSize: 52))),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(s.name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800,
                        color: Color(s.color), letterSpacing: 0.5)),
                    const SizedBox(height: 4),
                    Text(s.topics[topicIdx], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Row(children: [
                      const Text('⏱ 15 min', style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                      const SizedBox(width: 12),
                      const Text('🧪 Experiment', style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(color: Color(s.color), borderRadius: BorderRadius.circular(20)),
                        child: const Text('Start', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                      ),
                    ]),
                  ]),
                ),
              ]),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─── PERFORMANCE TAB ─────────────────────────────────────────────
class PerformanceTab extends StatelessWidget {
  const PerformanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppProvider>().user;
    final provider = context.read<AppProvider>();
    if (user == null) return const SizedBox();
    final subjects = _subjectsFor(user.category);
    final attendRate = (provider.attendanceRate * 100).round();

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(title: const Text('My Progress')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _statCard('${user.streak}', '🔥 Day streak', AppTheme.purple),
              _statCard('${user.videosWatched}', '🎬 Videos watched', AppTheme.teal),
              _statCard('$attendRate%', '📅 Attendance', AppTheme.coral),
              _statCard('${user.stamps.length}', '🌍 Stamps earned', AppTheme.amber),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Attendance log (last 28 days)',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: AppTheme.cardDecoration,
            child: Column(children: [
              Row(children: [
                _legend(AppTheme.green, 'Present'),
                const SizedBox(width: 12),
                _legend(AppTheme.coral, 'Absent'),
                const SizedBox(width: 12),
                _legend(AppTheme.amber, 'Tired'),
                const SizedBox(width: 12),
                _legend(AppTheme.border, 'Future'),
              ]),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: List.generate(28, (i) {
                  final d = DateTime.now().subtract(Duration(days: 27 - i));
                  final key = d.toLocal().toString().split(' ')[0];
                  final att = user.attendance[key];
                  final isFuture = d.isAfter(DateTime.now());
                  final days = ['S','M','T','W','T','F','S'];
                  Color bg = AppTheme.bg;
                  Color txt = AppTheme.textMuted;
                  if (!isFuture) {
                    if (att == 'present') { bg = AppTheme.greenLight; txt = AppTheme.green; }
                    else if (att == 'absent') { bg = AppTheme.coralLight; txt = AppTheme.coral; }
                    else if (att == 'tired') { bg = AppTheme.amberLight; txt = AppTheme.amber; }
                  }
                  return Container(
                    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(days[d.weekday % 7], style: TextStyle(fontSize: 8, color: txt, fontWeight: FontWeight.w700)),
                      Text('${d.day}', style: TextStyle(fontSize: 10, color: txt, fontWeight: FontWeight.w700)),
                    ]),
                  );
                }),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          const Text('Subject progress', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          ...subjects.map((s) {
            final done = user.topicProgress[s.name] ?? 0;
            final pct = done / s.topics.length;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.cardDecoration,
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('${s.icon} ${s.name}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  Text('${(pct * 100).round()}%', style: TextStyle(fontWeight: FontWeight.w700, color: Color(s.color))),
                ]),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: pct, minHeight: 10,
                  backgroundColor: AppTheme.bg,
                  valueColor: AlwaysStoppedAnimation(Color(s.color)),
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('$done of ${s.topics.length} topics complete',
                      style: const TextStyle(fontSize: 12, color: AppTheme.textMuted)),
                ),
              ]),
            );
          }),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _statCard(String num, String label, Color color) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.border, width: 1.5)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(num, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: color)),
      Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted, fontWeight: FontWeight.w600)),
    ]),
  );

  Widget _legend(Color color, String label) => Row(children: [
    Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    const SizedBox(width: 4),
    Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.w600)),
  ]);
}

// ─── PASSPORT TAB ────────────────────────────────────────────────
class PassportTab extends StatelessWidget {
  const PassportTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppProvider>().user;
    if (user == null) return const SizedBox();
    final subjects = _subjectsFor(user.category);

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(title: const Text('My Passport')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF1A1040), Color(0xFF3B0EA6)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('UNILEARN SUBJECT PASSPORT',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800,
                      color: Colors.white60, letterSpacing: 1.2)),
              const SizedBox(height: 6),
              Text('${user.name}\'s Learning Journey',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text('${user.level} · ${user.category == 'academic' ? 'Academic' : 'Non-Academic'} · ${user.country}',
                  style: const TextStyle(color: Colors.white60, fontSize: 13)),
              const SizedBox(height: 12),
              Row(children: [
                _passportBadge('${user.stamps.length} Stamps'),
                const SizedBox(width: 8),
                _passportBadge('🔥 ${user.streak} Day streak'),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          const Text('Topic stamps', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          ...subjects.map((s) {
            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('${s.icon} ${s.name}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(s.color))),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.9,
                children: List.generate(s.topics.length, (i) {
                  final earned = user.stamps.contains('${s.name}_$i');
                  return Container(
                    decoration: BoxDecoration(
                      color: earned ? Color(s.lightColor) : AppTheme.bg,
                      border: Border.all(
                          color: earned ? Color(s.color) : AppTheme.border, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(earned ? s.icon : '🔒', style: const TextStyle(fontSize: 24)),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          s.topics[i].split(' ').take(2).join(' '),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9, fontWeight: FontWeight.w700,
                            color: earned ? Color(s.color) : AppTheme.textMuted,
                          ),
                        ),
                      ),
                    ]),
                  );
                }),
              ),
              const SizedBox(height: 8),
            ]);
          }),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _passportBadge(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
    child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
  );
}
