function add(a, b) {
    return a + b;
  }
  add(1, 2);
  
  hoisted(); // Function hoisting
  function hoisted() {
    return "Hoisted function!";
  }
  