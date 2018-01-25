# Bitmap is a representation of a bitmap as an M x N matrix of pixels,
# where each element represents a colour
class Bitmap
  # This is used for testing purposes
  attr_accessor :bitmap

  # Initialize an empty bitmap of size n, m and fill it with white colour
  # represented by character O
  def initialize(n, m)
    unless n.between?(1, 250) && m.between?(1, 250)
      raise ArgumentError, "Bitmap size is out of range. Should be in between 1 and 250"
    end
    @bitmap = Array.new(m, Array.new(n, 'O'))
  end

  # Clear the bitmap by setting all pixels to white (O)
  def clear()

  end

  # Colour the pixel (x, y) with colour c
  def set_colour(x, y, c)

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
end
