import 'package:flutter/material.dart';

void main() => runApp(const MetalloLabApp());

class MetalloLabApp extends StatelessWidget {
  const MetalloLabApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MetalloLab',
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0B1020),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF36C5F0),
        brightness: Brightness.dark,
      ),
    ),
    home: const HomeShell(),
  );
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override State<HomeShell> createState() => _HomeShellState();
}
class _HomeShellState extends State<HomeShell> {
  int tab = 0;
  final pages = const [HomePage(), CoursesPage(), LabPage(), LibraryPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: pages[tab]),
    bottomNavigationBar: NavigationBar(
      selectedIndex: tab,
      onDestinationSelected: (v) => setState(() => tab = v),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'خانه'),
        NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'آموزش'),
        NavigationDestination(icon: Icon(Icons.science_outlined), selectedIcon: Icon(Icons.science), label: 'آزمایشگاه'),
        NavigationDestination(icon: Icon(Icons.photo_library_outlined), selectedIcon: Icon(Icons.photo_library), label: 'تصاویر'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'پروفایل'),
      ],
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const SizedBox(height: 10),
      const Text('MetalloLab', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      Text('از آماده‌سازی نمونه تا تحلیل ریزساختار', style: TextStyle(color: Colors.grey.shade400)),
      const SizedBox(height: 24),
      Card(
        color: const Color(0xFF12243A),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.science, size: 44, color: Color(0xFF36C5F0)),
            const SizedBox(height: 12),
            const Text('آزمایشگاه مجازی متالوگرافی', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('تصمیم بگیر، نمونه را آماده کن و نتیجه را یاد بگیر.', style: TextStyle(height: 1.6)),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VirtualLabPage())),
              icon: const Icon(Icons.play_arrow), label: const Text('شروع آزمایش'),
            ),
          ]),
        ),
      ),
      const SizedBox(height: 22),
      const Text('مسیر یادگیری', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      ...[
        ('مبانی متالوگرافی', 'از صفر تا شناخت ریزساختار', Icons.menu_book),
        ('آماده‌سازی نمونه', 'برش، مانت، سنباده و پولیش', Icons.build_circle),
        ('حکاکی و میکروسکوپی', 'انتخاب اچنت و مشاهده صحیح', Icons.biotech),
      ].map((e) => Card(child: ListTile(
        leading: CircleAvatar(child: Icon(e.$3)), title: Text(e.$1), subtitle: Text(e.$2),
        trailing: const Icon(Icons.chevron_left),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LessonPage(title: e.$1))),
      ))),
    ],
  );
}

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final items = [
      'فصل ۱: مبانی متالوگرافی','فصل ۲: برش و نمونه‌برداری','فصل ۳: مانت',
      'فصل ۴: سنگ‌زنی و پولیش','فصل ۵: اچ','فصل ۶: میکروسکوپی',
      'فصل ۷: ریزساختار فولادها','فصل ۸: عملیات حرارتی','فصل ۹: دیاگرام آهن-کربن','فصل ۱۰: آزمون و تحلیل'
    ];
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('دوره‌های آموزشی', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      const SizedBox(height: 18),
      ...items.map((x) => Card(child: ListTile(
        leading: const Icon(Icons.play_circle_outline), title: Text(x),
        trailing: const Icon(Icons.chevron_left),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LessonPage(title: x))),
      ))),
    ]);
  }
}

class LessonPage extends StatelessWidget {
  final String title;
  const LessonPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('مفهوم اصلی', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      const Text(
        'در متالوگرافی، کیفیت آماده‌سازی نمونه مستقیماً روی نتیجه مشاهده میکروسکوپی اثر می‌گذارد. مسیر یادگیری از ترکیب شیمیایی و فرآیند ساخت به ریزساختار و سپس خواص می‌رسد.',
        style: TextStyle(fontSize: 16, height: 1.8),
      ),
      const SizedBox(height: 20),
      Card(child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Composition → Processing → Microstructure → Properties',
          style: TextStyle(color: Colors.cyan.shade200, fontSize: 17, fontWeight: FontWeight.bold)),
      )),
      const SizedBox(height: 20),
      FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.check), label: const Text('درس را تکمیل کردم')),
    ]),
  );
}

class LabPage extends StatelessWidget {
  const LabPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text('آزمایشگاه', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      const SizedBox(height: 18),
      ...[
        ('برش نمونه', 'انتخاب جهت و روش برش', Icons.cut),
        ('مانت', 'انتخاب مانت گرم یا سرد', Icons.layers),
        ('سنگ‌زنی', 'کاهش تدریجی زبری سطح', Icons.blur_on),
        ('پولیش', 'رسیدن به سطح مناسب مشاهده', Icons.circle_outlined),
        ('اچ', 'انتخاب محلول و زمان مناسب', Icons.water_drop),
        ('میکروسکوپی', 'بزرگنمایی و ثبت تصویر', Icons.camera),
      ].map((e) => Card(child: ListTile(
        leading: CircleAvatar(child: Icon(e.$3)), title: Text(e.$1), subtitle: Text(e.$2),
        trailing: const Icon(Icons.chevron_left),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VirtualLabPage())),
      ))),
    ],
  );
}

class VirtualLabPage extends StatefulWidget {
  const VirtualLabPage({super.key});
  @override State<VirtualLabPage> createState() => _VirtualLabPageState();
}
class _VirtualLabPageState extends State<VirtualLabPage> {
  int step = 0;
  final steps = ['انتخاب نمونه','برش','مانت','سنگ‌زنی','پولیش','اچ','مشاهده'];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('آزمایشگاه مجازی')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      Text('مرحله ${step + 1} از ${steps.length}', style: TextStyle(color: Colors.cyan.shade200)),
      const SizedBox(height: 10),
      LinearProgressIndicator(value: (step + 1) / steps.length),
      const SizedBox(height: 28),
      Text(steps[step], style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      const SizedBox(height: 14),
      const Text('برای ادامه یک گزینه را انتخاب کنید. در نسخه کامل، هر انتخاب پیامد و امتیاز آموزشی خواهد داشت.',
        style: TextStyle(fontSize: 16, height: 1.7)),
      const SizedBox(height: 24),
      ...['گزینه استاندارد','گزینه سریع','بررسی شرایط نمونه'].map((x) => Card(child: ListTile(
        title: Text(x), trailing: const Icon(Icons.chevron_left),
        onTap: () {
          if (step < steps.length - 1) setState(() => step++);
          else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('آزمایش تکمیل شد.')));
        },
      ))),
    ]),
  );
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});
  @override
  Widget build(BuildContext context) {
    final data = [
      ('فریت','ساختار نسبتاً نرم و کم‌کربن در فولادها'),
      ('پرلیت','ساختار لایه‌ای فریت و سمنتیت'),
      ('مارتنزیت','محصول تبدیل سریع پس از کوئنچ'),
      ('بینیت','ساختار حاصل از تبدیل در محدوده دمایی میانی'),
      ('اسفروئیدیت','سمنتیت کروی در زمینه فریتی'),
      ('آستنیت','فاز FCC آهن در دماهای بالاتر'),
    ];
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('کتابخانه ریزساختار', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      const SizedBox(height: 18),
      ...data.map((e) => Card(child: ListTile(
        leading: const Icon(Icons.bubble_chart), title: Text(e.$1), subtitle: Text(e.$2),
        trailing: const Icon(Icons.chevron_left),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StructurePage(name: e.$1, description: e.$2))),
      ))),
    ]);
  }
}

class StructurePage extends StatelessWidget {
  final String name, description;
  const StructurePage({super.key, required this.name, required this.description});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(name)),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      Container(height: 220, decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [Color(0xFF16213E), Color(0xFF243B55)]),
      ), child: const Center(child: Icon(Icons.biotech, size: 90, color: Color(0xFF36C5F0)))),
      const SizedBox(height: 20),
      Text(name, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Text(description, style: const TextStyle(fontSize: 17, height: 1.7)),
    ]),
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const Text('پروفایل', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
    const SizedBox(height: 20),
    const CircleAvatar(radius: 42, child: Icon(Icons.person, size: 42)),
    const SizedBox(height: 12),
    const Center(child: Text('کاربر MetalloLab', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
    const SizedBox(height: 28),
    const Card(child: ListTile(leading: Icon(Icons.school), title: Text('پیشرفت آموزشی'), trailing: Text('0%'))),
    const Card(child: ListTile(leading: Icon(Icons.emoji_events), title: Text('آزمون‌ها'), trailing: Text('0'))),
  ]);
}
