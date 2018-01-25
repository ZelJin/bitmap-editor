require 'spec_helper'
require_relative '../lib/bitmap'

RSpec.describe Bitmap, '#initialize' do
  context 'when n or m is negative' do
    it 'should raise an error' do
      expect { Bitmap.new(-1, 1) }.to raise_error
    end
    it 'should raise an error' do
      expect { Bitmap.new(2, -3) }.to raise_error
    end
    it 'should raise an error' do
      expect { Bitmap.new(-4, -5) }.to raise_error
    end
  end

  context 'when n or m is zero' do
    it 'should raise an error' do
      expect { Bitmap.new(0, 1) }.to raise_error
    end
    it 'should raise an error' do
      expect { Bitmap.new(2, 0) }.to raise_error
    end
    it 'should raise an error' do
      expect { Bitmap.new(0, 0) }.to raise_error
    end
  end

  context 'when n or m is out of bounds' do
    it 'should raise an error' do
      expect { Bitmap.new(251, 24) }.to raise_error
    end
    it 'should raise an error' do
      expect { Bitmap.new(250, 251) }.to raise_error
    end
    it 'should raise an error' do
      expect { Bitmap.new(1234, 5678) }.to raise_error
    end
  end

  context 'when n or m are correct' do
    n, m = 24, 25
    bitmap = Bitmap.new(n, m)
    bm = bitmap.bitmap
    it 'should have correct row length' do
      expect(bm.length).to be(m)
    end
    it 'should have correct column length' do
      (1..m).each do |i|
        expect(bm[i-1].length).to be(n)
      end
    end
    it 'should have correct pixel color' do
      (1..m).each do |i|
        (1..n).each do |j|
          expect(bm[i-1][j-1]).to eq('O')
        end
      end
    end
  end
end

RSpec.describe Bitmap, '#clear' do

end

RSpec.describe Bitmap, '#set_colour' do

end

RSpec.describe Bitmap, '#vertical_segment' do

end

RSpec.describe Bitmap, '#horizontal_segment' do

end

RSpec.describe Bitmap, '#to_s' do

end
