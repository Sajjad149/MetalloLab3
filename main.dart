import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MetallographyApp());
}

class MetallographyApp extends StatelessWidget {
  const MetallographyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'متالوگرافی حرفه‌ای',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors:blueGrey,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MainNavigationScreen(),
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    CourseHomeScreen(),
    EtchantDatabaseScreen(),
    GrainSizeCalculatorScreen(),
    QuizScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF1E3A8A),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'آموزش'),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: 'اچانت‌ها'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'محاسبه‌گر ASTM'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'آزمون'),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// ۱. صفحه آموزش جامع متالوگرافی
// -----------------------------------------------------------------------------
class CourseHomeScreen extends StatelessWidget {
  const CourseHomeScreen({super.key});

  final List<Map<String, dynamic>> modules = const [
    {
      'title': '۱. آماده‌سازی نمونه (Sample Prep)',
      'subtitle': 'برش‌کاری، مانتینگ، سنباده‌کاری و پولیش',
      'icon': Icons.precision_manufacturing,
      'details': [
        'برش‌کاری: استفاده از دیسک‌های خنک شونده برای جلوگیری از تغییر ساختار حرارتی.',
        'مانتینگ: مانت گرم (رزین‌های ترموست/ترموپلاستیک) و مانت سرد (اپکسی/آکریلیک).',
        'سنباده‌کاری: استفاده از کاغذ سنباده‌های SiC از گریت ۲۴۰ تا ۲۰۰۰ با جریان آب.',
        'پرداخت‌کاری: استفاده از پودر الماس (۶ تا ۱ میکرون) یا آلومینا روی پارچه نمدی.'
      ]
    },
    {
      'title': '۲. اچینگ و شیمی متالوگرافی (Etching)',
      'subtitle': 'مکانیزم ظهور مرزدانه‌ها و فازها',
      'icon': Icons.science_outlined,
      'details': [
        'مکانیزم: انحلال انتخابی مناطق با انرژی بالاتر (مانند مرزدانه‌ها یا فازهای آندیک).',
        'نکات ایمنی: کار زیر هود آزمایشگاهی و استفاده از تجهیزات حفاظت فردی (PPE).',
        'روش اجرا: غوطه‌وری یا شستشوی سطح نمونه با پنبه آغشته به محلول اچ.'
      ]
    },
    {
      'title': '۳. میکروسکوپی و فازشناسی (Microscopy)',
      'subtitle': 'شناسایی فازهای فولاد و آلیاژهای غیرآهنی',
      'icon': Icons.biotech,
      'details': [
        'فریت (Ferrite): ساختار BCC، نرم و انعطاف‌پذیر، روشن در میکروسکوپ.',
        'پرلیت (Pearlite): ساختار لایه‌ای فریت + سمنتیت.',
        'مارتنزیت (Martensite): ساختار BCT سوزنی شکل حاصل از کوئنچ سریع.',
        'آستنیت (Austenite): ساختار FCC، غیرمغناطیسی با دوقلوی‌های تبلور مجدد.'
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('آموزش جامع متالوگرافی'),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final item = modules[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF1E3A8A),
                child: Icon(item['icon'] as IconData, color: Colors.white),
              ),
              title: Text(
                item['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(item['subtitle'] as String),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (item['details'] as List<String>)
                        .map((detail) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  Expanded(child: Text(detail, style: const TextStyle(height: 1.5))),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// ۲. بانک اطلاعاتی اچانت‌ها
// -----------------------------------------------------------------------------
class EtchantDatabaseScreen extends StatefulWidget {
  const EtchantDatabaseScreen({super.key});

  @override
  State<EtchantDatabaseScreen> createState() => _EtchantDatabaseScreenState();
}

class _EtchantDatabaseScreenState extends State<EtchantDatabaseScreen> {
  String _searchQuery = '';

  final List<Map<String, String>> _etchants = const [
    {
      'name': 'ایتال (Nital)',
      'target': 'فولادهای کربنی و کم‌آلیاژ',
      'composition': '۱ تا ۵ میلی‌لیتر اسید نیتریت + ۱۰۰ میلی‌لیتر اتانول',
      'usage': 'نمایان‌سازی مرزدانه‌های فریت و ساختار پرلیت'
    },
    {
      'name': 'پیکرال (Picral)',
      'target': 'فولادهای ابزار و ساختارهای بازپخت‌شده',
      'composition': '۴ گرم اسید پیکریک + ۱۰۰ میلی‌لیتر اتانول',
      'usage': 'تفکیک پرلیت و کاربیدها بدون اثر روی مرزدانه‌ها'
    },
    {
      'name': 'محلول کرول (Kroll\'s Reagent)',
      'target': 'آلیاژهای تیتانیوم',
      'composition': '۱-۳ میلی‌لیتر HF + ۲-۶ میلی‌لیتر HNO3 + ۱۰۰ میلی‌لیتر آب',
      'usage': 'ظهور ساختار α و β در تیتانیوم'
    },
    {
      'name': 'کلرید آهن (Ferric Chloride)',
      'target': 'مس و آلیاژهای برنج / برنز',
      'composition': '۵ گرم FeCl3 + ۵۰ میلی‌لیتر HCl + ۱۰۰ میلی‌لیتر آب',
      'usage': 'اچ عمومی آلیاژهای پایه مس'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _etchants.where((e) {
      return e['name']!.contains(_searchQuery) ||
          e['target']!.contains(_searchQuery) ||
          e['composition']!.contains(_searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('بانک اطلاعات اچانت‌ها'),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'جستجوی آلیاژ یا محلول...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final e = filtered[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(e['name']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('کاربرد: ${e['target']}'),
                        Text('ترکیب: ${e['composition']}', style: TextStyle(color: Colors.grey[800])),
                        Text('توضیح: ${e['usage']}', style: const TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// ۳. محاسبه‌گر اندازه دانه طبق ASTM E112
// -----------------------------------------------------------------------------
class GrainSizeCalculatorScreen extends StatefulWidget {
  const GrainSizeCalculatorScreen({super.key});

  @override
  State<GrainSizeCalculatorScreen> createState() => _GrainSizeCalculatorScreenState();
}

class _GrainSizeCalculatorScreenState extends State<GrainSizeCalculatorScreen> {
  final TextEditingController _countController = TextEditingController();
  double? _astmNumber;

  void _calculate() {
    final count = double.tryParse(_countController.text);
    if (count != null && count > 0) {
      // فرمول: G = 1 + (log2(N))
      // N: تعداد دانه در ۱ اینچ مربع با بزرگنمایی 100x
      final g = 1 + (log(count) / log(2));
      setState(() {
        _astmNumber = g;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محاسبه‌گر اندازه دانه (ASTM E112)'),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'تعداد دانه‌ها در هر اینچ مربع با بزرگ‌نمایی 100x (مفهوم N) را وارد کنید:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _countController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'تعداد دانه‌ها (N)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.grid_4x4),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _calculate,
              child: const Text('محاسبه عدد ASTM G', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 30),
            if (_astmNumber != null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF1E3A8A)),
                ),
                child: Column(
                  children: [
                    const Text('نتیجه محاسبه:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      'G = ${_astmNumber!.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _astmNumber! >= 5 ? 'دانه ریز (Fine Grain)' : 'دانه درشت (Coarse Grain)',
                      style: TextStyle(
                        fontSize: 16,
                        color: _astmNumber! >= 5 ? Colors.green[700] : Colors.orange[800],
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// ۴. بخش آزمون تعاملی
// -----------------------------------------------------------------------------
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _score = 0;
  int _questionIndex = 0;

  final List<Map<String, dynamic>> _questions = const [
    {
      'question': 'کدام محلول برای اچ کردن عمومی فولادهای کربنی استفاده می‌شود؟',
      'answers': ['کلرید آهن', 'ایتال (Nital)', 'محلول کرول', 'اسید هیدروفلوئوریک'],
      'correct': 1,
    },
    {
      'question': 'ساختار حاصل از سرمایش بسیار سریع (کوئنچ) آستنیت چیست؟',
      'answers': ['پرلیت', 'فریت', 'مارتنزیت', 'سمنتیت'],
      'correct': 2,
    },
    {
      'question': 'مطابق ASTM E112، افزایش عدد G نشان‌دهنده چیست؟',
      'answers': ['درشت‌تر شدن دانه‌ها', 'ریزتر شدن دانه‌ها', 'افزایش ناخالصی‌ها', 'تغییر فاز آستنیت'],
      'correct': 1,
    },
  ];

  void _answerQuestion(int index) {
    if (index == _questions[_questionIndex]['correct']) {
      _score++;
    }
    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _score = 0;
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('آزمون خودارزیابی متالوگرافی'),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
      ),
      body: _questionIndex < _questions.length
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'سوال ${_questionIndex + 1} از ${_questions.length}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _questions[_questionIndex]['question'] as String,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  ...(_questions[_questionIndex]['answers'] as List<String>).asMap().entries.map((entry) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          alignment: Alignment.centerRight,
                        ),
                        onPressed: () => _answerQuestion(entry.key),
                        child: Text(entry.value, style: const TextStyle(fontSize: 16)),
                      ),
                    );
                  }),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
                  const SizedBox(height: 16),
                  Text(
                    'پایان آزمون!\nامتیاز شما: $_score از ${_questions.length}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _resetQuiz,
                    child: const Text('شروع مجدد آزمون'),
                  )
                ],
              ),
            ),
    );
  }
}
