require './lib/bitmap'

class BitmapEditor

  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exists?(file)
    bitmap = nil
    File.readlines(file).each do |line|
      puts line
      args = line.strip.split(' ')
      case args[0]
      when 'I'
        # Init command
        next unless args_correct?(args, 3, 'I N M')
        # Try to create a bitmap. Catch an ArgumentError if it occurs
        begin
          bitmap = Bitmap.new(args[1], args[2])
        rescue ArgumentError => err
          puts 'Argument error: ' + err.message
        end
      when 'C'
        # Clear command
        next unless bitmap_present?(bitmap)
        bitmap.clear
      when 'L'
        # Colour pixel command
        next unless bitmap_present?(bitmap) && args_correct?(args, 4, 'L X Y C')
        # Try to colour a pixel. Catch an ArgumentError if it occurs
        begin
          bitmap.set_colour(args[1], args[2], args[3])
        rescue ArgumentError => err
          puts 'Argument error: ' + err.message
        end
      when 'V'
        # Draw a vertical segment command
        next unless bitmap_present?(bitmap) && args_correct?(args, 5, 'V X Y1 Y2 C')
        # Try to draw a vertical segment. Catch an ArgumentError if it occurs
        begin
          bitmap.vertical_segment(args[1], args[2], args[3], args[4])
        rescue ArgumentError => err
          puts 'Argument error: ' + err.message
        end
      when 'H'
        # Draw a horizontal segment command
        next unless bitmap_present?(bitmap) && args_correct?(args, 5, 'H X1 X2 Y C')
        # Try to draw a horizontal segment. Catch an ArgumentError if it occurs
        begin
          bitmap.horizontal_segment(args[1], args[2], args[3], args[4])
        rescue ArgumentError => err
          puts "Argument error: " + err
        end
      when 'S'
        # Print bitmap command
        next unless bitmap_present?(bitmap)
        puts bitmap.to_s
      else
        puts 'unrecognised command :('
      end
    end
  end

  private

  # Check if bitmap is present
  # Print error message if not
  def bitmap_present?(bitmap)
    puts 'There is no image' if bitmap.nil?
    return bitmap.nil?
  end

  # Check if arguments are correct for particular command
  # Print error message if not
  def args_correct?(args, target_length, usage)
    return args.length < target_length
    puts 'Invalid arguments. Usage: #{usage}' if args.length < target_length
  end
end
