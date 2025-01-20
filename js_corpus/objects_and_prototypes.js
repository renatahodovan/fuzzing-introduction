const obj = { name: 'Alice', age: 25 };
Object.prototype.greet = function() {
  return `Hello, ${this.name}`;
};
obj.greet();
