# Bitmap is a representation of a bitmap as an M x N matrix of pixels,
# where each element represents a colour
class Bitmap
  # Initialize an empty bitmap of size n, m and fill it with white colour
  # represented by character O
  def initialize(n, m)
    unless n.between?(1, 250) && m.between?(1, 250)
      raise ArgumentError, "Bitmap size is out of range [1, 250]"
    end
    @bitmap = Array.new(n, Array.new(m, 'O'))
  end

  # Return the size of the bitmap
  def size()
    return @bitmap.length, @bitmap[0].length
  end

  # Clear the bitmap by setting all pixels to white (O)
  def clear()

  end

  # Get the colour of the pixel
  def get_colour(x, y)
    unless row_valid?(x) && column_valid?(y)
      raise ArgumentError, "Pixel (#{x}, #{y}) is out of range"
    end
    @bitmap[x-1][y-1]
  end

  # Colour the pixel (x, y) with colour c
  def set_colour(x, y, c)
    unless row_valid?(x) && column_valid?(y)
      raise ArgumentError, "Pixel (#{x}, #{y}) is out of range"
    end
    unless colour_valid?(c)
      raise ArgumentError, "Incorrect colour #{c}"
    end
    @bitmap[x-1][y-1] = c
  end

  # Draw a vertical segment of colour c in column x between
  # rows y1 and y2 (inclusive)
  def vertical_segment(x, y1, y2, c)

  end

  # Draw a horizontal segment of colour c in row y between
  # columns x1 and x2 (inclusive)
  def horizontal_segment(x1, x2, y, c)

  end

  # Print the current state of a bitmap.
  def to_s()

  end

  private

  def row_valid?(x)
    x.between?(1, @bitmap.length)
  end

  def column_valid?(y)
    y.between?(1, @bitmap[0].length)
  end

  def colour_valid?(c)
    /^[A-Z]$/.match(c.to_s)
  end
end
