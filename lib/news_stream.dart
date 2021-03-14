import 'dart:async';

class NewsStream {
  StreamController<DateTime> controller;
  Timer timer;

  /// Inizializzazione della class [NewsStream].
  NewsStream() {
    this.controller = StreamController(
      /// Funzioni di callback dello stream.
      onListen: startStream,
      onCancel: closeStream,
      onResume: startStream,
      onPause: closeStream,
    );
  }

  Stream<DateTime> getStream() {
    return controller.stream;
  }

  void startStream() {
    print("Start Stream");
    timer = Timer.periodic(Duration(seconds: 1), produce);
  }

  void closeStream() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }

    /// Il [?] davanti a [timer] ci permette di eseguire il metodo [.cancel()]
    /// solo se [timer] è diverso da [null], così da evitare l'errore [NullPointerException].
    ///
    /// timer?.cancel();
    /// timer = null;
  }

  void produce(_) {
    controller.add(DateTime.now());
  }
}
