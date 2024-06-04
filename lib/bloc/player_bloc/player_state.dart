


import 'package:equatable/equatable.dart';
import 'package:spotify/model/audio_file_model.dart';

enum SongStatus { playing, pause, stopped }

class PlayerStateNew extends Equatable {
  final bool isPlaying;
  final double progress;
  final bool isFavourite;
  final AudioFile? file;
  final SongStatus status;

  const PlayerStateNew(
      {this.isPlaying = true,
      this.isFavourite = false,
      this.progress = 0.0,
      this.status = SongStatus.stopped,
      this.file});

  PlayerStateNew copyWith(
      {bool? isPlaying,
      double? progress,
      bool? isFavourite,
      SongStatus? status,
      AudioFile? file}) {
    return PlayerStateNew(
        isFavourite: isFavourite ?? this.isFavourite,
        isPlaying: isPlaying ?? this.isPlaying,
        progress: progress ?? this.progress,
        status: status ?? this.status,
        file: file ?? this.file);
  }

  @override
  List<Object> get props =>
      [isPlaying, progress, isFavourite, status, file ?? ''];
}
