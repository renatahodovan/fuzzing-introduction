function makeAdder(x) {
    return function(y) {
      return x + y;
    };
  }
  const add5 = makeAdder(5);
  add5(10);
  