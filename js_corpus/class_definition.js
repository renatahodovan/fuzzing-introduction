function Rectangle(width, height) {
    this.width = width;
    this.height = height;
  }
  Rectangle.prototype.area = function() {
    return this.width * this.height;
  };
  const rect = new Rectangle(2, 3);
  rect.area();
  