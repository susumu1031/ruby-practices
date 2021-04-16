# frozen_string_literal: true

require 'optparse'
opt = ARGV.getopts('l')

def lineno(files)
  File.open(files) do |file|
    while file.gets; end
    file.lineno - 1
  end
end

def size(files)
  File.open(files) do |file|
    while file.gets; end
    file.size
  end
end

def word_counter(files)
  File.open(files) do |file|
    a = file.read
    array = a.split
    array.size
  end
end

if ARGV.size.zero?
  input = $stdin.read
  array = input.split
  puts "#{input.count("\n")} " + "#{array.size} " + "#{input.bytesize} "
else
  x = ARGV[0..-1]
  if opt['l']
    if x.size >= 2
      sum_lineno = 0
      x.each do |files|
        puts "#{lineno(files)} " + files.to_s
        sum_lineno += lineno(files)
      end
      puts "#{sum_lineno} " + 'total'.to_s
    else
      x.each do |files|
        puts "#{lineno(files)} " + files.to_s
      end
    end
  elsif !opt['l']
    if x.size >= 2
      sum_lineno = 0
      sum_word_counter = 0
      sum_size = 0
      x.each do |files|
        puts "#{lineno(files)} " + "#{word_counter(files)} " + "#{size(files)} " + files.to_s
        sum_lineno += lineno(files)
        sum_word_counter += word_counter(files)
        sum_size += size(files)
      end
      puts "#{sum_lineno} " + "#{sum_word_counter} " + "#{sum_size} " + 'total'.to_s
    else
      x.each do |files|
        puts "#{lineno(files)} " + "#{word_counter(files)} " + "#{size(files)} " + files.to_s
      end
    end
  end
end
