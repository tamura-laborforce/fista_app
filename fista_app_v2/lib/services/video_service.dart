class VideoService {
  static final VideoService instance = VideoService._();
  VideoService._();

  Future<List<String>> fetchVideos() async {
    // TODO: fetch from Firestore or API
    return ["Video A", "Video B", "Video C"];
  }
}