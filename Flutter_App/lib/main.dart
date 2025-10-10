import 'package:flutter/material.dart';
import 'dart:async';
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
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
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
                const Text(
                  "Selalu Ada di Nadimu",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Bunga Citra Lestari",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "OST Jumbo (Kartun Indonesia)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Pencipta lagu \"Selalu Ada di Nadimu\" untuk film animasi Jumbo adalah Laleilmanino.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
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
  Timer? _timer;
  bool _isPlaying = false;

  final List<String> lyrics = [
    "Kala nanti badai 'kan datang",
    "Angin akan buat kau goyah",
    "Maafkan, hidup memang",
    "Ingin kau lebih kuat",
    "",
    "Andaikan saat itu datang",
    "Kami tak ada menemani",
    "Aku ingin kau mendengar",
    "Nyanyianku di sini",
    "",
    "Sedikit demi sedikit",
    "Engkau akan berteman pahit",
    "Luapkanlah saja bila harus menangis",
    "Anakku, ingatlah semua",
    "Lelah tak akan tersia",
    "Usah kau takut pada keras dunia",
    "",
    "Akhirnya takkan ada akhir",
    "Doaku agar kau selalu",
    "Arungi hidup berbalut",
    "Senyuman di hati",
    "Doaku agar kau selalu",
    "Ingat bahagia",
    "Meski kadang hidup tak baik saja",
    "",
    "Nyanyian ini bukan sekedar nada",
    "Aku ingin kau mendengarnya",
    "Dengan hatimu bukan telinga",
    "",
    "Ingatlah ini bukan sekedar kata",
    "Maksudnya kelak akan menjadi makna",
    "Ungkapan cintaku dari hati",
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_isPlaying && _currentLineIndex < lyrics.length - 1) {
        setState(() {
          _currentLineIndex++;
        });
        _scrollController.animateTo(
          _currentLineIndex * 60.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel();
      }
    });
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

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _startTimer();
      } else {
        _timer?.cancel();
      }
    });
  }

  void _nextLyric() {
    if (_currentLineIndex < lyrics.length - 1) {
      setState(() {
        _currentLineIndex++;
      });
      _scrollController.animateTo(
        _currentLineIndex * 60.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousLyric() {
    if (_currentLineIndex > 0) {
      setState(() {
        _currentLineIndex--;
      });
      _scrollController.animateTo(
        _currentLineIndex * 60.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        "Selalu Ada di Nadimu",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.black),
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
                _buildMusicControlBar(),
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
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          if (isActive)
            Container(
              width: double.infinity,
              height: 60.0,
              color: Colors.black.withOpacity(0.3),
            ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              color: isActive
                  ? Colors.blue
                  : isPassed
                      ? Colors.blue[300]
                      : Colors.blue[200],
              fontSize: isActive ? 32 : 24,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              height: 1.3,
            ),
            child: Text(
              text.isEmpty ? " " : text,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMusicControlBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.skip_previous),
            onPressed: _previousLyric,
          ),
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: _togglePlayPause,
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: _nextLyric,
          ),
        ],
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
                        Text("Indonesia\n"),
                        Text(
                          "Makna Lagu:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Lagu ini menggambarkan cinta kasih seorang ibu kepada anaknya, "
                          "yang penuh dengan doa dan harapan untuk masa depan anak.",
                        ),
                        Text(
                          "Biasa Dinyanyikan Untuk:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "• Momen spesial\n"
                          "• Perayaan keluarga\n"
                          "• Acara formal",
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