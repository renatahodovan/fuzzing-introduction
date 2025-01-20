function* generator() {
    yield 1;
    yield 2;
  }
  [...generator()];
  