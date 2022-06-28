import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  bool _playing = false;

  bool get playing => this._playing;

  set playing(bool value) {
    this._playing = value;
    notifyListeners();
  }

  late AnimationController _controller;

  get controller => this._controller;

  set controller(value) {
    this._controller = value;
  }

  Duration _songDuration = Duration(milliseconds: 0);

  Duration get songDuration => this._songDuration;

  set songDuration(Duration value) {
    this._songDuration = value;
    notifyListeners();
  }

  Duration _current = Duration(milliseconds: 0);

  Duration get current => this._current;

  set current(Duration value) {
    this._current = value;
    notifyListeners();
  }

  double get percent => this._songDuration.inSeconds > 0
      ? this._current.inSeconds / this._songDuration.inSeconds
      : 0;

  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    String twoDigitsMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitsSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitsMinutes:$twoDigitsSeconds';
  }

  String get songTotalDuration => this.printDuration(this._songDuration);

  String get currentSecond => this.printDuration(this._current);
}
