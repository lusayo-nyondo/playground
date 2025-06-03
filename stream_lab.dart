void main() {
  print(List.of(getInts()));
  _getInts().listen((i) => print(i));
}

Stream<int> _getInts() async* {
  for (var i = 0; i < 2; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 3));
  }
}

Iterable<int> getInts() sync* {
  yield 1;
  yield 2;
  yield 3;
  yield 4;
}
