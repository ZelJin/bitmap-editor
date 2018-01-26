# Bitmap is a representation of a bitmap as an M x N matrix of pixels,
# where each element represents a colour
class Bitmap
  # Initialize an empty bitmap of size n, m and fill it with white colour
  # represented by character O
  def initialize(n, m)
    unless n.between?(1, 250) && m.between?(1, 250)
      raise ArgumentError, "Bitmap size is out of range [1, 250]"
    end
    @bitmap = Array.new(m)
    (1..m).each do |i|
      @bitmap[i-1] = Array.new(n, 'O')
    end
  end

  # Return the size of the bitmap
  def size()
    return @bitmap[0].length, @bitmap.length
  end

  # Clear the bitmap by setting all pixels to white (O)
  def clear()
    n, m = self.size
    (1..n).each do |i|
      (1..m).each do |j|
        self.set_colour(i, j, 'O')
      end
    end
  end

  # Get the colour of the pixel
  def get_colour(x, y)
    unless x_valid?(x) && y_valid?(y)
      raise ArgumentError, "Pixel (#{x}, #{y}) is out of range"
    end
    @bitmap[y-1][x-1]
  end

  # Colour the pixel (x, y) with colour c
  def set_colour(x, y, c)
    unless x_valid?(x) && y_valid?(y)
      raise ArgumentError, "Pixel (#{x}, #{y}) is out of range"
    end
    unless colour_valid?(c)
      raise ArgumentError, "Incorrect colour #{c}"
    end
    @bitmap[y-1][x-1] = c
  end

  # Draw a vertical segment of colour c in column x between
  # rows y1 and y2 (inclusive)
  def vertical_segment(x, y1, y2, c)
    unless x_valid?(x) && y_valid?(y1) && y_valid?(y2)
      raise ArgumentError, "Coordinates are out of range"
    end
    unless colour_valid?(c)
      raise ArgumentError, "Incorrect colour #{c}"
    end
    ymin, ymax = [y1, y2].minmax
    (ymin..ymax).each do |j|
      self.set_colour(x, j, c)
    end
  end

  # Draw a horizontal segment of colour c in row y between
  # columns x1 and x2 (inclusive)
  def horizontal_segment(x1, x2, y, c)
    unless x_valid?(x1) && x_valid?(x2) && y_valid?(y)
      raise ArgumentError, "Coordinates are out of range"
    end
    unless colour_valid?(c)
      raise ArgumentError, "Incorrect colour #{c}"
    end
    xmin, xmax = [x1, x2].minmax
    (xmin..xmax).each do |i|
      self.set_colour(i, y, c)
    end
  end

  # Print the current state of a bitmap.
  def to_s
    @bitmap.map {|row| row.join('')}.join("\n")
  end

  private

  def x_valid?(x)
    x.between?(1, @bitmap[0].length)
  end

  def y_valid?(y)
    y.between?(1, @bitmap.length)
  end

  def colour_valid?(c)
    /^[A-Z]$/.match(c.to_s)
  end
end
