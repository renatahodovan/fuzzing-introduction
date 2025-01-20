const person = {
    name: 'Alice',
    greet: function() {
      return `Hi, I'm ${this.name}`;
    }
  };
  person.greet();
  