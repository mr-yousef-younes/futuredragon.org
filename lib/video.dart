import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoItem {
  final String title;
  final String? url;
  final String? thumbnail;

  VideoItem({required this.title, this.url, this.thumbnail});

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      title: json['title'] ?? 'بدون عنوان',
      url: (json['url'] is String && (json['url'] as String).isNotEmpty)
          ? json['url'] as String
          : null,
      thumbnail: json['thumbnail'] as String?,
    );
  }
}

class VideoCard extends StatefulWidget {
  final VideoItem item;
  final Color titleColor;

  const VideoCard({super.key, required this.item, required this.titleColor});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> with WidgetsBindingObserver {
  YoutubePlayerController? _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializePlayer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.close();
    super.dispose();
  }

  void _initializePlayer() {
    final videoId = _extractVideoId(widget.item.url);
    if (videoId == null) return;

    _controller = YoutubePlayerController(
      params: YoutubePlayerParams(
        strictRelatedVideos: true,
        enableCaption: true,
        showControls: true,
        showFullscreenButton: false,
        mute: false,
        showVideoAnnotations: false,
        enableKeyboard: false,
        loop: false,
      ),
    );

    _controller?.cueVideoById(videoId: videoId);
    _controller?.listen((event) {
      setState(() => _isPlaying = event.playerState == PlayerState.playing);
    });
  }

  void _startVideo() => _controller?.playVideo();
  void _stopVideo() => _controller?.pauseVideo();

  String? _extractVideoId(String? url) {
    if (url == null || url.isEmpty) return null;
    try {
      final uri = Uri.parse(url);
      if (uri.host.contains('youtu.be')) return uri.pathSegments.first;
      if (uri.queryParameters.containsKey('v')) return uri.queryParameters['v'];
      final regExp = RegExp(r'(?:v=|watch\?v=|youtu\.be/|embed/)([0-9A-Za-z_-]{11})');
      return regExp.firstMatch(url)?.group(1);
    } catch (e) {
      return null;
    }
  }

Widget _buildVideoPlayer() {
  if (_controller != null) {
    return Column(
      children: [
        YoutubePlayer(
            controller: _controller!,
            aspectRatio: 16 / 9),
        const SizedBox(height: 12),
        _buildManualControls(),
      ],
    );
  } else if (widget.item.url == null || widget.item.url!.isEmpty) {
    return _buildPlaceholder('لم يتم إضافة رابط الفيديو');
  } else {
    return _buildLoadingIndicator();
  }
}

  Widget _buildManualControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
          label: Text(_isPlaying ? 'إيقاف' : 'تشغيل'),
          onPressed: () => _isPlaying ? _stopVideo() : _startVideo(),
        ),
        const SizedBox(width: 5),
        ElevatedButton(
          onPressed: () {
            final videoId = _extractVideoId(widget.item.url);
            if (videoId != null) {
              context.push('/video_fullscreen/$videoId');
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12),
          ),
          child: const Icon(Icons.fullscreen),
        ),
      ],
    );
  }


  Widget _buildPlaceholder(String message) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Center(
        child: Text(
          message,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('جاري تحميل الفيديو...'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: widget.titleColor.withAlpha(77),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.title,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: widget.titleColor),
            ),
            const SizedBox(height: 16),
            _buildVideoPlayer(),
          ],
        ),
      ),
    );
  }
}