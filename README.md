# Bitmap editor

Simple bitmap editor that can edit a N x M bitmap image by reading commands from a text file.
Bitmap is represented as a matrix, where each element represents a pixel.
The colour of the pixel is defined by a single character (e.g. O for white).

Supported commands:

* I N M - Create a new M x N image with all pixels coloured white (O).
* C - Clear the image by setting all pixels to white (O).
* L X Y C - Colour the pixel (X,Y) with colour C.
* V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
* H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
* S - Show the contents of the current bitmap

# Installation

* Install Ruby 2.4.2 using your preferred method
* `gem install bundler`
* `bundle install`

# Running

`>bin/bitmap_editor examples/show.txt`
