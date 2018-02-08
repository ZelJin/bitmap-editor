require 'spec_helper'
require './lib/bitmap'

RSpec.describe Bitmap, '#initialize' do
  context 'when n or m is negative' do
    it 'should raise an error' do
      expect { Bitmap.new(-1, 1) }.to raise_error ArgumentError
      expect { Bitmap.new(2, -3) }.to raise_error ArgumentError
      expect { Bitmap.new(-4, -5) }.to raise_error ArgumentError
    end
  end

  context 'when n or m is zero' do
    it 'should raise an error' do
      expect { Bitmap.new(0, 1) }.to raise_error ArgumentError
      expect { Bitmap.new(2, 0) }.to raise_error ArgumentError
      expect { Bitmap.new(0, 0) }.to raise_error ArgumentError
    end
  end

  context 'when n or m is out of bounds' do
    it 'should raise an error' do
      expect { Bitmap.new(251, 24) }.to raise_error ArgumentError
      expect { Bitmap.new(250, 251) }.to raise_error ArgumentError
      expect { Bitmap.new(1234, 5678) }.to raise_error ArgumentError
    end
  end

  context 'when n or m are correct' do
    n, m = 10, 20
    bitmap = Bitmap.new(n, m)
    rows, columns = bitmap.size
    it 'should have correct row length' do
      expect(rows).to be(n)
    end
    it 'should have correct column length' do
      expect(columns).to be(m)
    end
    it 'should have correct pixel color' do
      (1..n).each do |i|
        (1..m).each do |j|
          expect(bitmap.get_colour(i, j)).to eq('O')
        end
      end
    end
  end
end

RSpec.describe Bitmap, '#set_colour' do
  before (:each) do
    @bitmap = Bitmap.new(25, 25)
  end

  context 'when n or m are out of bounds' do
    it 'should raise an error' do
      expect { @bitmap.set_colour(26, 1, 'C') }.to raise_error ArgumentError
      expect { @bitmap.set_colour(4, -1, 'C') }.to raise_error ArgumentError
      expect { @bitmap.set_colour(-5, 100500, 'C') }.to raise_error ArgumentError
      expect { @bitmap.set_colour(0, 49, 'C') }.to raise_error ArgumentError
    end
  end

  context 'when colour string is incorrect' do
    it 'should raise an error' do
      expect { @bitmap.set_colour(1, 1, 'Ж') }.to raise_error ArgumentError
      expect { @bitmap.set_colour(1, 1, 'CS') }.to raise_error ArgumentError
      expect { @bitmap.set_colour(1, 1, 42) }.to raise_error ArgumentError
      expect { @bitmap.set_colour(1, 1, nil) }.to raise_error ArgumentError
      expect { @bitmap.set_colour(1, 1, 'k') }.to raise_error ArgumentError
      expect { @bitmap.set_colour(1, 1, '9') }.to raise_error ArgumentError
      expect { @bitmap.set_colour(1, 1, '@') }.to raise_error ArgumentError
      expect { @bitmap.set_colour(1, 1, ';') }.to raise_error ArgumentError
      expect { @bitmap.set_colour(1, 1, ' ') }.to raise_error ArgumentError
      expect { @bitmap.set_colour(1, 1, '🤷') }.to raise_error ArgumentError
    end
  end

  context 'when parameters are correct' do
    it 'should paint the correct pixel' do
      @bitmap.set_colour(1, 1, 'C')
      @bitmap.set_colour(2, 1, 'D')
      @bitmap.set_colour(1, 2, 'E')
      @bitmap.set_colour(24, 25, 'F')
      @bitmap.set_colour(25, 12, 'G')
      expect(@bitmap.get_colour(1, 1)).to eq('C')
      expect(@bitmap.get_colour(2, 1)).to eq('D')
      expect(@bitmap.get_colour(1, 2)).to eq('E')
      expect(@bitmap.get_colour(24, 25)).to eq('F')
      expect(@bitmap.get_colour(25, 12)).to eq('G')
    end
  end
end

RSpec.describe Bitmap, '#clear' do
  before (:each) do
    @bitmap = Bitmap.new(25, 25)
  end

  context 'when the bitmap is clean' do
    it 'should not change the bitmap' do
      @bitmap.clear
      n, m = @bitmap.size
      (1..n).each do |i|
        (1..m).each do |j|
          expect(@bitmap.get_colour(i, j)).to eq('O')
        end
      end
    end
  end

  context 'when the bitmap is not clean' do
    it 'should clear all pixels' do
      # Let's paint something on the bitmap first
      n, m = @bitmap.size
      (1..20).each do
        x = 1 + Random.rand(n)
        y = 1 + Random.rand(m)
        @bitmap.set_colour(x, y, 'C')
      end

      @bitmap.clear
      (1..n).each do |i|
        (1..m).each do |j|
          expect(@bitmap.get_colour(i, j)).to eq('O')
        end
      end
    end
  end
end

RSpec.describe Bitmap, '#vertical_segment' do
  before (:each) do
    @bitmap = Bitmap.new(25, 25)
  end

  context 'when coordinates are out of bounds' do
    it 'should raise an error' do
      expect { @bitmap.vertical_segment(26, 1, 1, 'C') }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(-2, 1, 1, 'C') }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(2, 0, 24, 'C') }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(3, -5, 0, 'C') }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(4, 26, 20, 'C') }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(5, 30, 40, 'C') }.to raise_error ArgumentError
    end
  end

  context 'when colour string is incorrect' do
    it 'should raise an error' do
      expect { @bitmap.vertical_segment(1, 1, 1, 'Ж') }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(1, 1, 1, 'CS') }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(1, 1, 1, 42) }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(1, 1, 1, nil) }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(1, 1, 1, 'k') }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(1, 1, 1, '9') }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(1, 1, 1, '@') }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(1, 1, 1, ';') }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(1, 1, 1, ' ') }.to raise_error ArgumentError
      expect { @bitmap.vertical_segment(1, 1, 1, '🤷') }.to raise_error ArgumentError
    end
  end

  context 'when y1 <= y2' do
    it 'should paint a correct vertical segment' do
      x, y1, y2 = 5, 1, 20
      n, m = @bitmap.size
      @bitmap.vertical_segment(x, y1, y2, 'C')
      (1..n).each do |i|
        (1..m).each do |j|
          if i == x && j.between?(y1, y2)
            expect(@bitmap.get_colour(i, j)).to eq('C')
          else
            expect(@bitmap.get_colour(i, j)).to eq('O')
          end
        end
      end
    end
  end

  context 'when y1 > y2' do
    it 'should still paint a correct vertical segment' do
      x, y1, y2 = 5, 20, 10
      n, m = @bitmap.size
      @bitmap.vertical_segment(x, y1, y2, 'C')
      (1..n).each do |i|
        (1..m).each do |j|
          if i == x && j.between?(y2, y1)
            expect(@bitmap.get_colour(i, j)).to eq('C')
          else
            expect(@bitmap.get_colour(i, j)).to eq('O')
          end
        end
      end
    end
  end
end

RSpec.describe Bitmap, '#horizontal_segment' do
  before (:each) do
    @bitmap = Bitmap.new(25, 25)
  end

  context 'when coordinates are out of bounds' do
    it 'should raise an error' do
      expect { @bitmap.horizontal_segment(1, 1, 26, 'C') }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(1, 1, -2, 'C') }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(0, 24, 2, 'C') }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(-5, 0, 3, 'C') }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(26, 20, 4, 'C') }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(30, 40, 5, 'C') }.to raise_error ArgumentError
    end
  end

  context 'when colour string is incorrect' do
    it 'should raise an error' do
      expect { @bitmap.horizontal_segment(1, 1, 1, 'Ж') }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(1, 1, 1, 'CS') }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(1, 1, 1, 42) }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(1, 1, 1, nil) }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(1, 1, 1, 'k') }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(1, 1, 1, '9') }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(1, 1, 1, '@') }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(1, 1, 1, ';') }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(1, 1, 1, ' ') }.to raise_error ArgumentError
      expect { @bitmap.horizontal_segment(1, 1, 1, '🤷') }.to raise_error ArgumentError
    end
  end

  context 'when x1 <= x2' do
    it 'should paint a correct horizontal segment' do
      x1, x2, y = 1, 20, 5
      n, m = @bitmap.size
      @bitmap.horizontal_segment(x1, x2, y, 'C')
      (1..n).each do |i|
        (1..m).each do |j|
          if i.between?(x1, x2) && j == y
            expect(@bitmap.get_colour(i, j)).to eq('C')
          else
            expect(@bitmap.get_colour(i, j)).to eq('O')
          end
        end
      end
    end
  end

  context 'when x1 > x2' do
    it 'should still paint a correct horizontal segment' do
      x1, x2, y = 20, 10, 5
      n, m = @bitmap.size
      @bitmap.horizontal_segment(x1, x2, y, 'C')
      (1..n).each do |i|
        (1..m).each do |j|
          if i.between?(x2, x1) && j == y
            expect(@bitmap.get_colour(i, j)).to eq('C')
          else
            expect(@bitmap.get_colour(i, j)).to eq('O')
          end
        end
      end
    end
  end
end

RSpec.describe Bitmap, '#to_s' do
  before (:each) do
    @bitmap = Bitmap.new(3, 5)
  end

  context 'when the bitmap is empty' do
    it 'shold display the bitmap correctly' do
      expected_bitmap = "OOO\nOOO\nOOO\nOOO\nOOO\n"
      expect(@bitmap.to_s).to eq(expected_bitmap)
    end
  end

  context 'when the bitmap is painted with set_colour' do
    it 'should still display the bitmap correctly' do
      @bitmap.set_colour(1, 1, 'A')
      @bitmap.set_colour(2, 2, 'B')
      @bitmap.set_colour(3, 3, 'C')
      @bitmap.set_colour(1, 4, 'D')
      @bitmap.set_colour(2, 5, 'E')
      expected_bitmap = "AOO\nOBO\nOOC\nDOO\nOEO\n"
      expect(@bitmap.to_s).to eq(expected_bitmap)
    end
  end

  context 'when the bitmap is painted with horizontal_segment' do
    it 'should still display the bitmap correctly' do
      @bitmap.horizontal_segment(1, 2, 1, 'A')
      @bitmap.horizontal_segment(2, 3, 2, 'B')
      @bitmap.horizontal_segment(3, 1, 4, 'C')
      expected_bitmap = "AAO\nOBB\nOOO\nCCC\nOOO\n"
      expect(@bitmap.to_s).to eq(expected_bitmap)
    end
  end

  context 'when the bitmap is painted with vertical_segment' do
    it 'should still display the bitmap correctly' do
      @bitmap.vertical_segment(1, 1, 5, 'A')
      @bitmap.vertical_segment(2, 3, 3, 'B')
      @bitmap.vertical_segment(3, 4, 5, 'C')
      expected_bitmap = "AOO\nAOO\nABO\nAOC\nAOC\n"
      expect(@bitmap.to_s).to eq(expected_bitmap)
    end
  end

  context 'when the bitmap is painted with a compination of methods' do
    it 'should still display the bitmap correctly' do
      @bitmap.set_colour(1, 1, 'A')
      @bitmap.set_colour(2, 2, 'B')
      @bitmap.set_colour(3, 3, 'C')
      @bitmap.vertical_segment(2, 1, 4, 'D')
      @bitmap.horizontal_segment(3, 1, 4, 'E')
      expected_bitmap = "ADO\nODO\nODC\nEEE\nOOO\n"
      expect(@bitmap.to_s).to eq(expected_bitmap)
    end
  end
end

RSpec.describe Bitmap, '#fill_bucket' do
  before (:each) do
    @bitmap = Bitmap.new(5, 5)
  end

  context 'when the bitmap is empty' do
    it 'should fill the whole bitmap' do
      @bitmap.fill_bucket(3, 3, 'K')
      expected_bitmap = "KKKKK\nKKKKK\nKKKKK\nKKKKK\nKKKKK\n"
      expect(@bitmap.to_s).to eq(expected_bitmap)
    end
  end

  context 'when there is a closed contour and initial point is inside the contour' do
    it 'should only fill space inside a contour' do
      @bitmap.set_colour(3, 2, 'A')
      @bitmap.set_colour(2, 3, 'A')
      @bitmap.set_colour(4, 3, 'A')
      @bitmap.set_colour(3, 4, 'A')
      @bitmap.fill_bucket(3, 3, 'K')
      expected_bitmap = "OOOOO\nOOAOO\nOAKAO\nOOAOO\nOOOOO\n"
      expect(@bitmap.to_s).to eq(expected_bitmap)
    end
  end

  context 'when there is a closed contour and initial point is outside the contour' do
    it 'should only fill space outside a contour' do
      @bitmap.set_colour(3, 2, 'A')
      @bitmap.set_colour(2, 3, 'A')
      @bitmap.set_colour(4, 3, 'A')
      @bitmap.set_colour(3, 4, 'A')
      @bitmap.fill_bucket(1, 1, 'K')
      expected_bitmap = "KKKKK\nKKAKK\nKAOAK\nKKAKK\nKKKKK\n"
      expect(@bitmap.to_s).to eq(expected_bitmap)
    end
  end

  context 'when the contour is not closed' do
    it 'should fill everything except for the contour' do
      @bitmap.set_colour(3, 2, 'A')
      @bitmap.set_colour(2, 3, 'A')
      @bitmap.set_colour(3, 4, 'A')
      @bitmap.fill_bucket(3, 3, 'K')
      expected_bitmap = "KKKKK\nKKAKK\nKAKKK\nKKAKK\nKKKKK\n"
      expect(@bitmap.to_s).to eq(expected_bitmap)
    end
  end

  context 'when the line splits the picture in half and the initial point is outside the line' do
    it 'should only fill one half of the image' do
      @bitmap.set_colour(3, 1, 'A')
      @bitmap.set_colour(3, 2, 'A')
      @bitmap.set_colour(2, 3, 'A')
      @bitmap.set_colour(3, 4, 'A')
      @bitmap.set_colour(3, 5, 'A')
      @bitmap.fill_bucket(4, 2, 'K')
      expected_bitmap = "OOAKK\nOOAKK\nOAKKK\nOOAKK\nOOAKK\n"
      expect(@bitmap.to_s).to eq(expected_bitmap)
    end
  end

  context 'when the line splits picture in half and the initial point is on the line' do
    it 'should only fill the line' do
      @bitmap.set_colour(2, 1, 'A')
      @bitmap.set_colour(2, 2, 'A')
      @bitmap.set_colour(2, 3, 'A')
      @bitmap.set_colour(2, 4, 'A')
      @bitmap.set_colour(2, 5, 'A')
      @bitmap.fill_bucket(2, 2, 'K')
      expected_bitmap = "OKOOO\nOKOOO\nOKOOO\nOKOOO\nOKOOO\n"
      expect(@bitmap.to_s).to eq(expected_bitmap)
    end
  end
end
