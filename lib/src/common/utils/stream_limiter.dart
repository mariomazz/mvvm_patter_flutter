import 'dart:async';
import 'package:rxdart/rxdart.dart';

class StreamLimiter<T, D> {
  final Future<T> Function(D newValue) fetch;
  final _searchSubject = BehaviorSubject<D>();
  final _searchResults = BehaviorSubject<T>();

  Timer? _timer;
  final Duration debounce;

  StreamLimiter({
    required this.fetch,
    this.debounce = const Duration(milliseconds: 500),
  }) {
    _searchSubject
        .debounceTime(debounce)
        .distinct()
        /* .where((query) => query.isNotEmpty) */
        .switchMap((query) async* {
      yield await fetch(query);
    }).listen((items) => _searchResults.add(items));
  }

  void search(D query) {
    _timer?.cancel();
    _timer = Timer(debounce, () {
      _searchSubject.add(query);
    });
  }

  void dispose() {
    _searchSubject.close();
    _searchResults.close();
  }

  Stream<T> get results => _searchResults.stream;
}
