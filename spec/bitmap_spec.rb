require 'spec_helper'
require_relative '../lib/bitmap'

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
      expect(@bitmap.get_colour(1, 1)).to eq('C')
      @bitmap.set_colour(2, 2, 'D')
      expect(@bitmap.get_colour(2, 2)).to eq('D')
      @bitmap.set_colour(24, 25, 'E')
      expect(@bitmap.get_colour(24, 25)).to eq('E')
      @bitmap.set_colour(25, 12, 'F')
      expect(@bitmap.get_colour(25, 12)).to eq('F')
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

end

RSpec.describe Bitmap, '#to_s' do

end
