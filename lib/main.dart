import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const SpotifyStyleLyricsApp());
}

class SpotifyStyleLyricsApp extends StatelessWidget {
  const SpotifyStyleLyricsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Spotify Style Lyrics",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SongDetailScreen(),
    );
  }
}

class SongDetailScreen extends StatelessWidget {
  const SongDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background dengan gambar pisang dan efek blur hitam
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1603833665858-e61d17a86224?w=800',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay hitam blur
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Konten
          SafeArea(
            child: Column(
              children: [
                // AppBar custom
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          // Sudah di halaman detail, tidak perlu navigasi
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const OptionsBottomSheet(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Album Art / Cover
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1603833665858-e61d17a86224?w=400',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Judul Lagu
                const Text(
                  "Ampar-Ampar Pisang",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Penyanyi
                const Text(
                  "Lagu Daerah Kalimantan Selatan",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                // Penulis Lirik
                const Text(
                  "Penulis: Hamiedan AC",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                // Tombol Lirik
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LyricsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.lyrics),
                    label: const Text("Lihat Lirik"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LyricsScreen extends StatefulWidget {
  const LyricsScreen({Key? key}) : super(key: key);

  @override
  State<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentLineIndex = 0;

  final List<String> lyrics = [
    "Ampar-ampar pisang",
    "Pisangnya kusumbi",
    "Masak sebiji dihurung bari-bari",
    "",
    "Masak sebiji dihurung bari-bari",
    "Masak sebiji dihurung bari-bari",
    "",
    "Ampar-ampar pisang",
    "Pisangnya kusumbi",
    "Masak sebiji dihurung bari-bari",
    "",
    "Masak sebiji dihurung bari-bari",
    "Masak sebiji dihurung bari-bari",
    "",
    "Manggalepak manggalepok",
    "Patah kayu bengkok",
    "Bengkok dimakan api",
    "Apinya cang curupan",
    "",
    "Manggalepak manggalepok",
    "Patah kayu bengkok",
    "Bengkok dimakan api",
    "Apinya cang curupan",
    "",
    "Hey hey...",
    "Hey hey...",
    "Hey hey...",
    "Hey hey...",
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final scrollOffset = _scrollController.offset;
      final lineHeight = 60.0;
      final newIndex = (scrollOffset / lineHeight).round();
      
      if (newIndex != _currentLineIndex && newIndex >= 0 && newIndex < lyrics.length) {
        setState(() {
          _currentLineIndex = newIndex;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background ungu muda blur
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple.shade200.withOpacity(0.3),
                  Colors.purple.shade100.withOpacity(0.2),
                  Colors.pink.shade100.withOpacity(0.2),
                ],
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          // Konten
          SafeArea(
            child: Column(
              children: [
                // AppBar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        "Ampar-Ampar Pisang",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const OptionsBottomSheet(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Lirik
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                    itemCount: lyrics.length,
                    itemBuilder: (context, index) {
                      final text = lyrics[index];
                      final isActive = index == _currentLineIndex;
                      final isPassed = index < _currentLineIndex;
                      
                      return _buildLyricLine(text, isActive, isPassed);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLyricLine(String text, bool isActive, bool isPassed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 300),
        style: TextStyle(
          color: isActive
              ? Colors.deepPurple.shade900
              : isPassed
                  ? Colors.purple.shade300
                  : Colors.purple.shade200,
          fontSize: isActive ? 32 : 24,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          height: 1.3,
        ),
        child: Text(
          text.isEmpty ? " " : text,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}

class OptionsBottomSheet extends StatelessWidget {
  const OptionsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: const Text("Laporkan"),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Laporkan"),
                  content: const Text("Fitur laporan akan segera tersedia."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: const Text("Download Lirik"),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Lirik berhasil didownload!"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outlined),
            title: const Text("Detail"),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Detail Lagu"),
                  content: const SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Asal Daerah:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Kalimantan Selatan\n"),
                        Text(
                          "Makna Lagu:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Lagu ini menceritakan tentang kegiatan menjemur pisang. Pisang adalah salah satu komoditas penting di Kalimantan Selatan. Lagu ini menggambarkan kegembiraan masyarakat setempat dalam kehidupan sehari-hari.\n",
                        ),
                        Text(
                          "Biasa Dinyanyikan Untuk:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "• Acara adat Kalimantan Selatan\n"
                          "• Penyambutan tamu\n"
                          "• Perayaan panen\n"
                          "• Pembelajaran budaya di sekolah\n"
                          "• Upacara pernikahan tradisional",
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Tutup"),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}