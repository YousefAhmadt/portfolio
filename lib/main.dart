import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF060112),
        fontFamily: 'sans-serif',
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 100),
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    padding: EdgeInsets.symmetric(horizontal: width > 600 ? 40 : 20),
                    child: Column(
                      children: [
                        HeroSection(key: _homeKey),
                        const SizedBox(height: 100),
                        const TechStackSection(),
                        const SizedBox(height: 150),
                        AboutSection(key: _aboutKey),
                        const SizedBox(height: 150),
                        const WorkExperienceSection(),
                        const SizedBox(height: 150),
                        FeaturedProjectsSection(key: _projectsKey),
                        const SizedBox(height: 150),
                        ContactSection(key: _contactKey),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF060112).withValues(alpha: 0.9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Navbar(
                onHomeTap: () => _scrollToSection(_homeKey),
                onAboutTap: () => _scrollToSection(_aboutKey),
                onProjectsTap: () => _scrollToSection(_projectsKey),
                onContactTap: () => _scrollToSection(_contactKey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Navbar extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const Navbar({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Σ", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
          if (MediaQuery.of(context).size.width > 700)
            Row(
              children: [
                _navItem("Home", onHomeTap),
                _navItem("About", onAboutTap),
                _navItem("Projects", onProjectsTap),
                _navItem("Contact", onContactTap),
              ],
            )
          else
            const Icon(Icons.menu, color: Colors.white),
        ],
      ),
    );
  }

  Widget _navItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: const Color(0xFF6C35DE).withValues(alpha: 0.3), blurRadius: 150, spreadRadius: 30),
                ],
              ),
            ),
            Column(
              children: [
                const Text("Hello! I Am Yousef Ahmad", style: TextStyle(color: Color(0xFFC084FC), fontSize: 16)),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/me.png',
                  height: 220,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 100, color: Colors.white24);
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40),
        const Text(
          "I'm a Software Engineer.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, height: 1.1, color: Colors.white),
        ),
        const SizedBox(height: 60),
        const Text(
          "Currently, I'm a Software Engineer at Domedia",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        const Text(
          "Flutter Developer & Backend Engineer with 4+ years of experience delivering scalable mobile and backend solutions.\n Specialized in API development and Odoo systems, with a strong emphasis on performance, reliability, and business alignment.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ],
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("About Me", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: isMobile ? 0 : 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("My Journey", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC084FC))),
                  const SizedBox(height: 20),
                  Text(
                    "With over 4 years in the industry, I have developed a deep expertise in Flutter for cross-platform mobile development and Odoo for robust backend systems. My work at Domedia, Trackware, and DCT Technology has allowed me to lead development teams and architect complex API structures.",
                    style: TextStyle(color: Colors.grey[400], fontSize: 18, height: 1.6),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "I am passionate about clean code, performance optimization, and creating intuitive user experiences. My dual background in frontend and backend allows me to bridge the gap between complex system logic and elegant user interfaces.",
                    style: TextStyle(color: Colors.grey[400], fontSize: 18, height: 1.6),
                  ),
                ],
              ),
            ),
            if (!isMobile) const SizedBox(width: 80),
            if (isMobile) const SizedBox(height: 40),
            Expanded(
              flex: isMobile ? 0 : 2,
              child: Container(
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.purple.withValues(alpha: 0.2)),
                  gradient: LinearGradient(
                    colors: [const Color(0xFF6C35DE).withValues(alpha: 0.1), Colors.transparent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(child: Icon(Icons.auto_awesome_outlined, size: 100, color: Color(0xFFC084FC))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "I am currently seeking to join a cross-functional team that is passionate about building scalable digital\n products and improving people's lives through accessible, high-quality technology.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white70),
        ),
        const SizedBox(height: 80),
        SizedBox(
          height: 400,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(size: const Size(double.infinity, 400), painter: LinesPainter()),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF1A0B3C),
                  boxShadow: [BoxShadow(color: const Color(0xFF6C35DE).withValues(alpha: 0.6), blurRadius: 80, spreadRadius: 10)],
                ),
                child: const Center(child: Text("Σ", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold))),
              ),
              _positionedIcon(0, -150, Icons.code, Colors.blue),
              _positionedIcon(120, -100, Icons.terminal, Colors.greenAccent),
              _positionedIcon(-120, -100, Icons.html, Colors.orange),
              _positionedIcon(180, 0, Icons.storage, Colors.blueGrey),
              _positionedIcon(-180, 0, Icons.description, Colors.orangeAccent),
              _positionedIcon(120, 100, Icons.css, Colors.blueAccent),
              _positionedIcon(-120, 100, Icons.javascript, Colors.yellow),
              _positionedIcon(0, 150, Icons.data_array, Colors.green),
            ],
          ),
        ),
      ],
    );
  }

  Widget _positionedIcon(double x, double y, IconData icon, Color color) {
    return Transform.translate(
      offset: Offset(x, y),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white10,
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }
}

class LinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6C35DE).withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    var center = Offset(size.width / 2, size.height / 2);
    for (var i = 0; i < 8; i++) {
      var path = Path();
      path.moveTo(center.dx, center.dy);
      path.lineTo(center.dx + 150 * (i == 0 || i == 4 ? 0 : (i < 4 ? 1 : -1)),
          center.dy + 150 * (i == 2 || i == 6 ? 0 : (i > 0 && i < 4 ? -1 : 1)));
      canvas.drawPath(path, paint);
    }
  }
  @override bool shouldRepaint(covariant CustomPainter old) => false;
}

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Work Experience", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
        const SizedBox(height: 50),
        LayoutBuilder(builder: (context, constraints) {
          int count = constraints.maxWidth > 800 ? 2 : 1;
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: count,
            childAspectRatio: 2.5,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            children: [
              _expCard("Domedia", "Leading Flutter development and building scalable backend solutions.", "https://domedia.jo", const Color(0xFF2E1065)),
              _expCard("Trackware", "Specialized in crafting robust mobile applications and custom Odoo modules.", "https://trackware.com", const Color(0xFF1E1B4B)),
              _expCard("DCT TECHNOLOGY", "Developing high-performance mobile apps and optimized API architectures.", "https://dct-tech.com", const Color(0xFF4C1D95)),
            ],
          );
        }),
      ],
    );
  }

  Widget _expCard(String title, String dec, String url, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.5)]),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white10),
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(dec, style: const TextStyle(color: Colors.white70, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () async {
              final Uri uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
            },
            child: const Text("LEARN MORE", style: TextStyle(fontSize: 11, color: Colors.white)),
          )
        ],
      ),
    );
  }
}

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _projectRow(true, "01", "Ain FM", "Developed the Ain FM mobile application for both Android and iOS platforms, focusing on seamless API integration.", "https://play.google.com/store/apps/details?id=com.domediaJo.radioAin", "https://apps.apple.com/us/app/radio-ain-fm/id6746383493", "https://ainfm.com", "assets/ainfm98.png"),
        const SizedBox(height: 180),
        _projectRow(false, "02", "Aldar News", "Developed the comprehensive admin dashboard and architected the backend API for the news platform.", "", "", "https://aldarnews.net/", "assets/aldar.png"),
        const SizedBox(height: 180),
        _projectRow(true, "03", "Trackware School", "Developed the Trackware School Management mobile application for both Android and iOS platforms.", "https://play.google.com/store/apps/details?id=trackware.schoolparenttrackware.parent", "https://apps.apple.com/app/trackware-school/id1183244199", "", "assets/trackwareB.jpeg"),
        const SizedBox(height: 180),
        _projectRow(false, "04", "Trackware (Odoo)", "Developed and customized specialized Odoo modules for school management and integrated with Firebase.", "", "", "https://trackware.com", "assets/trackwareOdoo.jpeg"),
      ],
    );
  }

  Widget _projectRow(bool left, String num, String title, String dec, String and, String ios, String web, String img) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile = constraints.maxWidth < 900;
      return Stack(
        clipBehavior: Clip.none,
        alignment: left ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          Container(
            width: isMobile ? double.infinity : constraints.maxWidth * 0.7,
            height: 400,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(img, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.image, size: 50)),
            ),
          ),
          Positioned(
            left: left && !isMobile ? 0 : null,
            right: !left && !isMobile ? 0 : null,
            child: Container(
              width: isMobile ? constraints.maxWidth * 0.9 : 520,
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E).withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Featured Project", style: TextStyle(color: Color(0xFFC084FC), fontSize: 14)),
                  Text(title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text(dec, style: const TextStyle(color: Colors.grey, height: 1.6, fontSize: 14)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      if (and.isNotEmpty) IconButton(onPressed: () => _launch(and), icon: const Icon(Icons.android, size: 22)),
                      if (ios.isNotEmpty) IconButton(onPressed: () => _launch(ios), icon: const Icon(Icons.apple, size: 22)),
                      if (web.isNotEmpty) IconButton(onPressed: () => _launch(web), icon: const Icon(Icons.web, size: 22)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
  Future<void> _launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Get In Touch", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
        const SizedBox(height: 25),
        const Text("I’m currently looking for new opportunities or interesting projects to collaborate on. Whether you have a question or just want to discuss Flutter, Odoo, or Backend architecture, my inbox is always open!", style: TextStyle(color: Colors.grey, fontSize: 17, height: 1.5)),
        const SizedBox(height: 40),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _contactCard(Icons.email_outlined, "yousef.ahmad.alfqeh@gmail.com", () async {
              final Uri uri = Uri(scheme: 'mailto', path: 'yousef.ahmad.alfqeh@gmail.com');
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            }),
            _contactCard(Icons.chat_outlined, "WhatsApp Me", () async {
              final Uri uri = Uri.parse("https://wa.me/9627XXXXXXXX"); // استبدل برقمك
              if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
            }),
          ],
        ),
      ],
    );
  }
  Widget _contactCard(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFC084FC).withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFC084FC).withValues(alpha: 0.05),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFFC084FC)),
            const SizedBox(width: 15),
            Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFC084FC))),
          ],
        ),
      ),
    );
  }
}
