import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ResumeApp());
}

class ResumeApp extends StatelessWidget {
  const ResumeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mohau Khakhu - Resume',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _makePhoneCall(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'My Resume',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purple.shade700,
                    Colors.purple.shade900,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'MOHAU KHAKHU',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'FULL-STACK DEVELOPER',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 15,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildContactInfo(
                        Icons.phone,
                        '+27 81 468 8426',
                        () => _makePhoneCall('+27814688426'),
                      ),
                      _buildContactInfo(
                        Icons.email,
                        'khakhumohau@gmail.com',
                        () => _launchEmail('khakhumohau@gmail.com'),
                      ),
                      _buildContactInfo(
                        Icons.location_on,
                        'Johannesburg, Gauteng',
                        null,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Navigation Grid
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildNavigationCard(
                    context,
                    Icons.school,
                    'Education',
                    Colors.purple,
                    _buildEducationContent,
                  ),
                  _buildNavigationCard(
                    context,
                    Icons.work,
                    'Experience',
                    Colors.purple.shade700,
                    _buildExperienceContent,
                  ),
                  _buildNavigationCard(
                    context,
                    Icons.code,
                    'Skills',
                    Colors.purple.shade600,
                    _buildSkillsContent,
                  ),
                  _buildNavigationCard(
                    context,
                    Icons.assignment,
                    'Projects',
                    Colors.purple.shade500,
                    _buildProjectsContent,
                  ),
                  _buildNavigationCard(
                    context,
                    Icons.verified,
                    'Certifications',
                    Colors.purple.shade400,
                    _buildCertificationsContent,
                  ),
                  _buildNavigationCard(
                    context,
                    Icons.contact_page,
                    'Contact',
                    Colors.purple.shade300,
                    _buildContactContent,
                  ),
                ],
              ),
            ),

            // Summary Section
            _buildPurpleCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.purple.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'PROFESSIONAL SUMMARY',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Dedicated and driven Full-Stack Developer with a curious mind and hands-on experience in application development, UI/UX design, and cybersecurity. Skilled in creating user-focused solutions that align with modern design principles and industry standards. Passionate about continuous learning and deeply curious about staying current with emerging technologies, always eager to contribute to innovative, impactful software solutions. Brings a blend of technical expertise, creative thinking, and an inquisitive approach to every project, with a focus on delivering reliable, scalable, and user-friendly applications.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            // Languages Section
            _buildPurpleCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.language, color: Colors.purple.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'LANGUAGES',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: ['English', 'Sepedi', 'Venda', 'Zulu'].map((language) {
                      return Chip(
                        label: Text(
                          language,
                          style: TextStyle(
                            color: Colors.purple.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor: Colors.purple.shade50,
                        side: BorderSide(color: Colors.purple.shade200),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: Colors.white70),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(BuildContext context, IconData icon, String title, Color color, Widget Function() contentBuilder) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.1),
              color.withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _showBottomSheet(context, title, contentBuilder()),
            borderRadius: BorderRadius.circular(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPurpleCard({required Widget child}) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade50,
              Colors.purple.shade100,
              Colors.purple.shade50,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.purple.shade200, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: child,
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String title, Widget content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }

  // Education Content
  Widget _buildEducationContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildEducationItem(
          'Advanced Diploma in ICT (Computer Science)',
          'Tshwane University of Technology',
          'Feb 2024 - Nov 2025',
          'Major in Integrated Software development, distributed programming, data structures and algorithms, Data science, Theory of Computer science and Software Engineering',
        ),
        const SizedBox(height: 16),
        _buildEducationItem(
          'National Diploma in ICT (Software Development)',
          'Tshwane University of Technology',
          'Feb 2018 - June 2021',
          'Major in Development Software, Computing Systems, Technical programming, Information Systems, and Systems Software',
        ),
        const SizedBox(height: 16),
        _buildEducationItem(
          'National Senior Certificate (NSC)',
          'Sefoloko Secondary School',
          '2016',
          '',
        ),
      ],
    );
  }

  Widget _buildEducationItem(String qualification, String institution, String period, String details) {
    return _buildPurpleCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            qualification,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            institution,
            style: TextStyle(
              fontSize: 16,
              color: Colors.purple.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            period,
            style: TextStyle(
              fontSize: 14,
              color: Colors.purple.shade500,
              fontStyle: FontStyle.italic,
            ),
          ),
          if (details.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              details,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ],
        ],
      ),
    );
  }

  // Experience Content
  Widget _buildExperienceContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildExperienceItem(
          'Software Developer',
          'Forge Academy and labs',
          'Oct 2024 - Present',
          [
            'Design, develop, and deploy scalable, secure web applications using modern frameworks',
            'Engineer fast, responsive user interfaces (UI/UX) and robust RESTful APIs',
            'Manage cloud hosting (AWS and Afrinost), databases, and deployment for optimal performance and uptime',
            'Implement technical SEO best practices and optimize performance for superior search rankings',
            'Build and integrate tools to capture leads, support sales funnels, and drive marketing growth',
          ],
        ),
        const SizedBox(height: 16),
        _buildExperienceItem(
          'Web Developer',
          'OL afrika media foundation',
          'Sep 2023 - Mar 2024',
          [
            'Engineer responsive, high-performance web interfaces with HTML5, CSS3, and React',
            'Translate design mockups into clean, maintainable code and contribute to wireframing and prototyping in Figma',
            'Optimize UI performance and resolve bugs through rigorous testing',
          ],
        ),
        const SizedBox(height: 16),
        _buildExperienceItem(
          'Graphic Designer',
          'Mogwape Business Enterprise',
          'Sep 2022 - Aug 2023',
          [
            'Conceptualized and presented visual concepts that translated client briefs into compelling designs',
            'Produced marketing collateral including flyers, posters, and website assets',
            'Developed key brand elements like custom illustrations, logos, and icons',
          ],
        ),
      ],
    );
  }

  Widget _buildExperienceItem(String position, String company, String period, List<String> responsibilities) {
    return _buildPurpleCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            position,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            company,
            style: TextStyle(
              fontSize: 16,
              color: Colors.purple.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            period,
            style: TextStyle(
              fontSize: 14,
              color: Colors.purple.shade500,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: responsibilities.map((responsibility) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, right: 8.0),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: Colors.purple.shade400,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        responsibility,
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Skills Content
  Widget _buildSkillsContent() {
    final skills = {
      'Programming Languages': ['Python', 'Java', 'C#', 'C++', 'JavaScript', 'PHP', 'SQL'],
      'Frameworks & Libraries': ['.NET', 'Spring Boot', 'Node.js', 'React.js', 'Blazor', 'Flutter', '.NET MAUI'],
      'Web Technologies': ['HTML', 'CSS', 'XML', 'Bootstrap', 'Tailwind CSS', 'RESTful APIs', 'SOAP'],
      'Cloud & Virtualization': ['Microsoft Azure', 'VMware', 'AWS (in progress)'],
      'Databases': ['PostgreSQL', 'MongoDB', 'SQL', 'NoSQL'],
    };

    return ListView(
      padding: const EdgeInsets.all(16),
      children: skills.entries.map((entry) {
        return Column(
          children: [
            _buildSkillsCategory(entry.key, entry.value),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSkillsCategory(String category, List<String> skills) {
    return _buildPurpleCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) {
              return Chip(
                label: Text(
                  skill,
                  style: TextStyle(
                    color: Colors.purple.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                backgroundColor: Colors.purple.shade50,
                side: BorderSide(color: Colors.purple.shade200),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Projects Content
  Widget _buildProjectsContent() {
    final projects = {
      'BBBEE Compliance Portals': 'Automated scorecard calculations and document management',
      'Invoicing & Payment Systems': 'With automated reminders and financial reporting',
      'Responsive Websites & PWAs': 'Using Laravel, React, and Vue.js',
      'Scalable Multi-tenant SaaS Platforms': 'Enterprise-level multi-tenant software solutions',
      'End-to-end E-Commerce Systems': 'With inventory management and secure checkout',
      'Business Automation Tools': 'Including custom CRM and analytics dashboards',
    };

    return ListView(
      padding: const EdgeInsets.all(16),
      children: projects.entries.map((entry) {
        return Column(
          children: [
            _buildProjectItem(entry.key, entry.value),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildProjectItem(String title, String description) {
    return _buildPurpleCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14, height: 1.4),
          ),
        ],
      ),
    );
  }

  // Certifications Content
  Widget _buildCertificationsContent() {
    final certifications = {
      'Microsoft': ['Microsoft Certified: Azure Fundamentals'],
      'VMware': [
        'VSP – Foundation',
        'VSP – Business Continuity',
        'VTSP – Business Continuity',
        'VSP – Disaster Recovery',
        'VTSP – Disaster Recovery',
        'VMware Ethics and Compliance'
      ],
      'SUSE': [
        'SUSE Foundation',
        'Technical Sales Specialist – SUSE Linux Enterprise Server'
      ],
      'Nutanix': [
        'Nutanix Certified Sales Representative (NCSR)',
        'NCSR – Unified Storage Exam'
      ],
    };

    return ListView(
      padding: const EdgeInsets.all(16),
      children: certifications.entries.map((entry) {
        return Column(
          children: [
            _buildCertificationItem(entry.key, entry.value),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCertificationItem(String provider, List<String> certifications) {
    return _buildPurpleCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            provider,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: certifications.map((cert) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, right: 8.0),
                      child: Icon(
                        Icons.verified,
                        size: 16,
                        color: Colors.purple.shade400,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        cert,
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Contact Content
  Widget _buildContactContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildContactItem(
          Icons.phone,
          'Phone',
          '+27 81 468 8426',
          () => _makePhoneCall('+27814688426'),
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          Icons.email,
          'Email',
          'khakhumohau@gmail.com',
          () => _launchEmail('khakhumohau@gmail.com'),
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          Icons.location_on,
          'Location',
          'Johannesburg, Gauteng',
          null,
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          Icons.public,
          'Portfolio',
          'mohaukhakhu.github.io/resume2/',
          () => _launchUrl('https://mohaukhakhu.github.io/resume2/'),
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          Icons.code,
          'GitHub',
          'github.com/Mohaukhakhu',
          () => _launchUrl('https://github.com/Mohaukhakhu'),
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          Icons.work,
          'LinkedIn',
          'linkedin.com/in/mohaukhakhu',
          () => _launchUrl('https://linkedin.com/in/mohaukhakhu-482985186'),
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String type, String value, VoidCallback? onTap) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.purple),
        title: Text(type, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade800)),
        subtitle: Text(value),
        trailing: onTap != null ? Icon(Icons.open_in_new, color: Colors.purple.shade600) : null,
        onTap: onTap,
      ),
    );
  }
}