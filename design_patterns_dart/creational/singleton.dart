class Singleton {
  Singleton._();
  static final instance = Singleton._();
  factory Singleton() {
    return instance;
  }
}

void main() {
  final first = Singleton();
  final second = Singleton();

  print(identical(first, second));
  print(first == second);
}
