import 'package:youtube_extractor/internal/parsers/muxed_stream_info_parser.dart';

class VideoInfoParser {
  Map<String, String> _root;

  VideoInfoParser(this._root);

  String parsePreviewVideoId() => _root['ypc_vid'];

  String parseHlsPlaylistUrl() => _root["hlsvp"];

  List<MuxedStreamInfoParser> getMuxedStreamInfos() {
    var streamInfosEncoded = _root['url_encoded_fmt_stream_map'];

    if (streamInfosEncoded == null) {
      return List<MuxedStreamInfoParser>();
    }

    // List that we will full
    var builtList = List<MuxedStreamInfoParser>();

    // Extract the streams and return a list
    var streams = streamInfosEncoded.split(',');
    streams.forEach((stream) {
      builtList.add(MuxedStreamInfoParser(Uri.splitQueryString(stream)));
    });

    return builtList;
  }

  static VideoInfoParser initialize(String raw) {
    var root = Uri.splitQueryString(raw);
    return VideoInfoParser(root);
  }
}