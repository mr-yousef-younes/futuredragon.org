import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../video.dart';
import '../theme.dart';

class CoursePage extends ConsumerWidget {
  const CoursePage({super.key});

  static const String jsonUrl = 'https://raw.githubusercontent.com/mr-yousef-younes/futurehub-videos/main/courses.json';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final titleColor = isDark ? Colors.orange.shade200 : ATheme.phoenixStart;

    final service = YouTubeJsonService(jsonUrl: jsonUrl);

    return Scaffold(
      appBar: AppBar(
        title:  Text('الدورات',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: isDark ? Colors.white : Colors.black87,
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),

        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<VideoItem>>(
        future: service.fetchVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'حدث خطأ أثناء جلب الفيديوهات:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
          final videos = snapshot.data ?? [];

          if (videos.isEmpty) {
            return Center(
              child: Text(
                'لا توجد فيديوهات حالياً',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 18,
                ),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final item = videos[index];
                    return VideoCard(item: item, titleColor: titleColor);
                  },
                ),
              ),
            ],
          );

        },
      ),
    );
  }
}

class YouTubeJsonService {
  final String jsonUrl;
  final Duration timeoutDuration;

  YouTubeJsonService({
    required this.jsonUrl,
    this.timeoutDuration = const Duration(seconds: 30),
  });

  Future<List<VideoItem>> fetchVideos() async {
    try {
      final uri = Uri.parse(jsonUrl);
      final res = await http.get(uri).timeout(timeoutDuration);

      if (res.statusCode != 200) {
        throw Exception('فشل جلب الملف: ${res.statusCode}');
      }

      final bodyString = utf8.decode(res.bodyBytes);
      final data = jsonDecode(bodyString);

      if (data is! List) throw Exception('تنسيق JSON غير صحيح — متوقع Array');

      return data
          .map<VideoItem>((e) => VideoItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('فشل في الاتصال بالخادم: ${e.message}');
      }
      if (e is FormatException) throw Exception('تنسيق JSON غير صحيح');
      throw Exception('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }
}
