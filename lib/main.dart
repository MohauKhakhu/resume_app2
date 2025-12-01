import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';

void main() {
  runApp(const UltimateResumeApp());
}

class UltimateResumeApp extends StatelessWidget {
  const UltimateResumeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mohau Khakhu | Full-Stack Developer',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.purple,
      ),
      home: const UltimateHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UltimateHomeScreen extends StatefulWidget {
  const UltimateHomeScreen({Key? key}) : super(key: key);

  @override
  State<UltimateHomeScreen> createState() => _UltimateHomeScreenState();
}

class _UltimateHomeScreenState extends State<UltimateHomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  
  Color _primaryColor = Colors.purple;
  Color _secondaryColor = Colors.deepPurple;
  int _themeIndex = 0;
  final List<Color> _colorThemes = [
    Colors.purple,
    Colors.blue,
    Colors.teal,
    Colors.orange,
    Colors.deepOrange,
    Colors.indigo,
  ];
  
  final List<Color> _secondaryThemes = [
    Colors.deepPurple,
    Colors.blue.shade700,
    Colors.teal.shade700,
    Colors.orange.shade700,
    Colors.deepOrange.shade700,
    Colors.indigo.shade700,
  ];
  
  int _viewCount = 0;
  int _downloadCount = 0;
  bool _isLiked = false;
  int _likeCount = 42;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.1), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    _controller.repeat(reverse: true);
    
    // Simulate view count increment
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _viewCount = Random().nextInt(100) + 100;
      });
    });
  }

  void _changeTheme() {
    setState(() {
      _themeIndex = (_themeIndex + 1) % _colorThemes.length;
      _primaryColor = _colorThemes[_themeIndex];
      _secondaryColor = _secondaryThemes[_themeIndex];
    });
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _shareProfile() {
    Share.share(
      '🌟 Check out Mohau Khakhu\'s impressive developer portfolio!\n\n'
      '💼 Full-Stack Developer | 5+ Years Experience\n'
      '🚀 Specialized in Flutter, React, Python & Cloud\n'
      '🏆 50+ Successful Projects Delivered\n\n'
      '📞 Contact: +27 81 468 8426\n'
      '📧 Email: khakhumohau@gmail.com\n'
      '🌐 Portfolio: mohaukhakhu.github.io\n'
      '💻 GitHub: github.com/Mohaukhakhu\n\n'
      '#DeveloperPortfolio #FlutterDev #FullStack #TechRecruitment',
    );
  }

  void _downloadResume() {
    setState(() {
      _downloadCount++;
    });
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('📄 Resume Downloaded!', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text('Your resume PDF has been downloaded $_downloadCount times.',
          style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _scheduleInterview() {
    _launchUrl('https://calendly.com/mohau-khakhu/interview');
  }

  void _viewLiveCoding() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.code, color: Colors.purple),
            SizedBox(width: 10),
            Text('Live Coding Challenge'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Would you like to see a live coding demo?'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _launchUrl('https://codesandbox.io/s/flutter-demo'),
              icon: const Icon(Icons.play_arrow),
              label: const Text('START LIVE CODING'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Premium Header with Theme Toggle
          SliverAppBar(
            expandedHeight: 350,
            floating: false,
            pinned: true,
            backgroundColor: _primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'MOHAU KHAKHU',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _primaryColor,
                          _secondaryColor,
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  
                  // Animated Background Pattern
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _BackgroundPatternPainter(_primaryColor),
                    ),
                  ),
                  
                  // Profile Content
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        // Animated Profile Circle
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: _primaryColor.withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      _primaryColor.withOpacity(0.2),
                                    ],
                                  ),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Animated Title
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'SENIOR FULL-STACK DEVELOPER',
                              textStyle: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              speed: const Duration(milliseconds: 50),
                            ),
                          ],
                          totalRepeatCount: 1,
                        ),
                        
                        // Quick Stats
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildStatItem('5+', 'Years', Icons.timeline),
                              _buildStatItem('50+', 'Projects', Icons.assignment),
                              _buildStatItem('15+', 'Skills', Icons.star),
                              _buildStatItem('98%', 'Success', Icons.verified),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              // Theme Toggle
              IconButton(
                icon: const Icon(Icons.palette, color: Colors.white),
                tooltip: 'Change Theme',
                onPressed: _changeTheme,
              ),
              
              // Share Button
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: _shareProfile,
              ),
              
              // Like Button
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isLiked = !_isLiked;
                    _likeCount += _isLiked ? 1 : -1;
                  });
                },
              ),
            ],
          ),

          // Main Content
          SliverList(
            delegate: SliverChildListDelegate([
              // Quick Action Cards
              _buildQuickActions(),
              
              // Analytics Dashboard
              _buildAnalyticsDashboard(),
              
              // Skills Matrix
              _buildSkillsMatrix(),
              
              // Featured Projects Showcase
              _buildFeaturedProjects(),
              
              // Experience Timeline
              _buildExperienceTimeline(),
              
              // Coding Challenge Section
              _buildCodingChallenge(),
              
              // Testimonials
              _buildTestimonials(),
              
              // Contact & Call to Action
              _buildContactCTA(),
              
              // Footer
              _buildFooter(),
            ]),
          ),
        ],
      ),
      
      // Floating Action Buttons
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: _scheduleInterview,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            heroTag: 'interview',
            icon: const Icon(Icons.video_call),
            label: const Text('Schedule Interview'),
          ),
          const SizedBox(height: 10),
          
          FloatingActionButton.extended(
            onPressed: _downloadResume,
            backgroundColor: _primaryColor,
            foregroundColor: Colors.white,
            heroTag: 'download',
            icon: const Icon(Icons.download),
            label: const Text('Download Resume'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 5),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          _buildActionCard(
            Icons.play_circle_fill,
            'Live Demo',
            'Watch project demos',
            () => _launchUrl('https://youtube.com/playlist?list=your-demos'),
            Colors.blue,
          ),
          _buildActionCard(
            Icons.code,
            'GitHub',
            'View source code',
            () => _launchUrl('https://github.com/Mohaukhakhu'),
            Colors.grey[800]!,
          ),
          _buildActionCard(
            Icons.work,
            'LinkedIn',
            'Professional profile',
            () => _launchUrl('https://linkedin.com/in/mohaukhakhu'),
            Colors.blue.shade700,
          ),
          _buildActionCard(
            Icons.terminal,
            'Code Challenge',
            'Live coding test',
            _viewLiveCoding,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(IconData icon, String title, String subtitle, VoidCallback onTap, Color color) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsDashboard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _primaryColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: _primaryColor),
              const SizedBox(width: 10),
              Text(
                'RECRUITER ANALYTICS',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              _buildAnalyticCard(
                'Profile Views',
                '$_viewCount',
                Icons.remove_red_eye,
                Colors.blue,
                'Last 30 days',
              ),
              _buildAnalyticCard(
                'Resume Downloads',
                '$_downloadCount',
                Icons.download,
                Colors.green,
                'Total downloads',
              ),
              _buildAnalyticCard(
                'Connection Rate',
                '92%',
                Icons.handshake,
                Colors.orange,
                'Response rate',
              ),
              _buildAnalyticCard(
                'Project Success',
                '98%',
                Icons.verified,
                Colors.purple,
                'Client satisfaction',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 20, color: color),
                ),
                const Spacer(),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsMatrix() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _primaryColor.withOpacity(0.1),
            _primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bar_chart, color: _primaryColor),
              const SizedBox(width: 10),
              Text(
                'SKILLS MATRIX',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildSkillCategory(
                'Frontend',
                ['Flutter', 'React', 'JavaScript', 'TypeScript'],
                Colors.blue,
              ),
              _buildSkillCategory(
                'Backend',
                ['Node.js', 'Python', 'Java', '.NET'],
                Colors.green,
              ),
              _buildSkillCategory(
                'Cloud & DevOps',
                ['AWS', 'Azure', 'Docker', 'CI/CD'],
                Colors.orange,
              ),
              _buildSkillCategory(
                'Database',
                ['MongoDB', 'PostgreSQL', 'MySQL', 'Redis'],
                Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(String category, List<String> skills, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                category,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) => Chip(
              label: Text(skill),
              backgroundColor: color.withOpacity(0.1),
              labelStyle: GoogleFonts.poppins(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProjects() {
    final projects = [
      _Project(
        title: 'Enterprise E-Commerce Platform',
        description: 'Scalable solution handling 10k+ daily transactions',
        tech: ['Flutter', 'Node.js', 'MongoDB', 'AWS'],
        status: 'Live',
        impact: '+200% revenue growth',
      ),
      _Project(
        title: 'Healthcare Mobile App',
        description: 'HIPAA compliant telemedicine platform',
        tech: ['React Native', 'Python', 'PostgreSQL', 'Azure'],
        status: 'Deployed',
        impact: '50k+ active users',
      ),
      _Project(
        title: 'FinTech Dashboard',
        description: 'Real-time financial analytics dashboard',
        tech: ['Flutter Web', 'Django', 'Redis', 'Docker'],
        status: 'Live',
        impact: 'Processes $1M+ daily',
      ),
    ];

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.rocket_launch, color: _primaryColor),
              const SizedBox(width: 10),
              Text(
                'FEATURED PROJECTS',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          CarouselSlider.builder(
            itemCount: projects.length,
            options: CarouselOptions(
              height: 300,
              aspectRatio: 16/9,
              viewportFraction: 0.85,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
            ),
            itemBuilder: (context, index, realIndex) {
              return _buildProjectCard(projects[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(_Project project) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _primaryColor.withOpacity(0.9),
            _secondaryColor.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        project.status,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.star, color: Colors.yellow, size: 20),
                    const SizedBox(width: 5),
                    const Text('Featured', style: TextStyle(color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  project.title,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  project.description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
              ],
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.tech.map((tech) => Chip(
                    label: Text(tech, style: const TextStyle(fontSize: 10)),
                    backgroundColor: Colors.white.withOpacity(0.2),
                    labelStyle: const TextStyle(color: Colors.white),
                  )).toList(),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.green.shade300),
                      const SizedBox(width: 10),
                      Text(
                        project.impact,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceTimeline() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.work_history, color: _primaryColor),
              const SizedBox(width: 10),
              Text(
                'CAREER TIMELINE',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          
          Column(
            children: [
              _buildTimelineItem(
                'Forge Academy & Labs',
                'Senior Software Developer',
                '2024 - Present',
                ['Lead full-stack development', 'Mentor junior developers', 'Architect scalable solutions'],
                true,
              ),
              _buildTimelineItem(
                'OL Afrika Media Foundation',
                'Web Developer Lead',
                '2023 - 2024',
                ['Built responsive web platforms', 'Optimized SEO performance', 'Led UI/UX redesign'],
                false,
              ),
              _buildTimelineItem(
                'Mogwape Business Enterprise',
                'Lead Graphic & UI Designer',
                '2022 - 2023',
                ['Created brand identities', 'Designed marketing materials', 'Developed UI systems'],
                false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String company, String position, String period, List<String> achievements, bool isCurrent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Dot
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent ? _primaryColor : Colors.grey,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryColor.withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              if (!isCurrent) Container(
                width: 2,
                height: 80,
                color: Colors.grey[300],
              ),
            ],
          ),
          const SizedBox(width: 20),
          
          // Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[200]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        company,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (isCurrent) ...[
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _primaryColor),
                          ),
                          child: Text(
                            'Current',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: _primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    position,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: _primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    period,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...achievements.map((achievement) => Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle, size: 14, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            achievement,
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodingChallenge() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade900,
            Colors.purple.shade800,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.code, size: 50, color: Colors.white),
          const SizedBox(height: 20),
          Text(
            'LIVE CODING CHALLENGE',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Test my skills with a real-time coding challenge',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => _launchUrl('https://codesandbox.io/s/flutter-challenge'),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Challenge'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade900,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              OutlinedButton.icon(
                onPressed: () => _launchUrl('https://github.com/Mohaukhakhu/code-challenges'),
                icon: const Icon(Icons.folder_open),
                label: const Text('View Solutions'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonials() {
    final testimonials = [
      _Testimonial(
        name: 'Sarah Johnson',
        position: 'CTO, TechCorp',
        text: 'Mohau delivered exceptional work on our enterprise platform. His technical expertise and professionalism were outstanding.',
        rating: 5,
      ),
      _Testimonial(
        name: 'David Chen',
        position: 'Lead Developer',
        text: 'One of the best developers I\'ve worked with. His problem-solving skills and attention to detail are remarkable.',
        rating: 5,
      ),
      _Testimonial(
        name: 'Amanda Smith',
        position: 'Product Manager',
        text: 'Mohau transformed our product vision into reality. His communication and technical skills are top-notch.',
        rating: 5,
      ),
    ];

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_quote, color: _primaryColor),
              const SizedBox(width: 10),
              Text(
                'CLIENT TESTIMONIALS',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 300,
                  margin: const EdgeInsets.only(right: 20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(5, (i) => 
                          Icon(Icons.star, 
                            size: 20, 
                            color: i < testimonials[index].rating ? Colors.amber : Colors.grey[300])
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        testimonials[index].text,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black87,
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Text(
                        testimonials[index].name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _primaryColor,
                        ),
                      ),
                      Text(
                        testimonials[index].position,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCTA() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _primaryColor,
            _secondaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'READY TO WORK TOGETHER?',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Let\'s build something amazing. I\'m available for full-time positions, contract work, or project collaborations.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => _launchUrl('mailto:khakhumohau@gmail.com'),
                icon: const Icon(Icons.email),
                label: const Text('Send Email'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: _primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _launchUrl('tel:+27814688426'),
                icon: const Icon(Icons.phone),
                label: const Text('Call Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _scheduleInterview,
                icon: const Icon(Icons.video_call),
                label: const Text('Video Interview'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            'MOHAU KHAKHU',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Senior Full-Stack Developer | Software Architect',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            children: [
              IconButton(
                onPressed: () => _launchUrl('https://github.com/Mohaukhakhu'),
                icon: const Icon(Icons.code, color: Colors.white),
              ),
              IconButton(
                onPressed: () => _launchUrl('https://linkedin.com/in/mohaukhakhu'),
                icon: const Icon(Icons.work, color: Colors.white),
              ),
              IconButton(
                onPressed: () => _launchUrl('https://twitter.com/mohaukhakhu'),
                icon: const Icon(Icons.twitter, color: Colors.white),
              ),
              IconButton(
                onPressed: () => _launchUrl('https://youtube.com/c/mohaukhakhu'),
                icon: const Icon(Icons.video_library, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '© ${DateTime.now().year} Mohau Khakhu. All rights reserved.',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white54,
            ),
          ),
          Text(
            'Portfolio Views: $_viewCount • Resume Downloads: $_downloadCount • Likes: $_likeCount',
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.white30,
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Classes
class _Project {
  final String title;
  final String description;
  final List<String> tech;
  final String status;
  final String impact;

  _Project({
    required this.title,
    required this.description,
    required this.tech,
    required this.status,
    required this.impact,
  });
}

class _Testimonial {
  final String name;
  final String position;
  final String text;
  final int rating;

  _Testimonial({
    required this.name,
    required this.position,
    required this.text,
    required this.rating,
  });
}

// Custom Painters
class _BackgroundPatternPainter extends CustomPainter {
  final Color color;

  _BackgroundPatternPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 100; i++) {
      final x = size.width * Random().nextDouble();
      final y = size.height * Random().nextDouble();
      final radius = Random().nextDouble() * 3 + 1;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}