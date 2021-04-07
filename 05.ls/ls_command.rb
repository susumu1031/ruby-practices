# frozen_string_literal: true

require 'optparse'
require 'etc'

opt = ARGV.getopts('a', 'l', 'r')

def filetype(ftype)
  {
    'file' => '-',
    'directory' => 'd',
    'characterSpecial' => 'c',
    'blockSpecial' => 'b',
    'fifo' => 'f',
    'link' => 'l',
    'socket' => 's'
  }[ftype]
end

def permission(mode)
  {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }[mode]
end

def l_option(file)
  stat = File::Stat.new(file)
  mode = stat.mode.to_s(8)
  data = []
  data << filetype(stat.ftype) + permission(mode[-3]) + permission(mode[-2]) + permission(mode[-1])
  data << stat.nlink
  data << Etc.getpwuid(stat.uid).name
  data << Etc.getgrgid(stat.gid).name
  data << stat.size
  data << stat.mtime.strftime('%-m %e %k:%M')
  data << file
end

if opt['a']
  def file_names
    Dir.glob('*', File::FNM_DOTMATCH).sort
  end
  if opt ['r']
    def file_names
      Dir.glob('*', File::FNM_DOTMATCH).sort.reverse
    end
  end
  if opt['l']
    file_names.each do |file|
      puts l_option(file)[0] + ' ' + l_option(file)[1].to_s + ' ' + l_option(file)[2] + ' ' + l_option(file)[3] + ' ' + l_option(file)[4].to_s + ' ' + l_option(file)[5] + ' ' + l_option(file)[6]
    end
  else
    A = file_names
    B = file_names.size
    if B % 3 != 0
      (3 - (B % 3)).times do
        A.push(' ')
      end
      X = A.each_slice(B.div(3) + 1).to_a # あまりがでるなら割った数＋1
    elsif (b % 3).zero?
      X = A.each_slice(B.div(3)).to_a
    end
    Y = X.transpose
    blanc_number = A.max_by(&:length)
    Y.each do |array|
      print array[0] + ' ' * (blanc_number.size + 10 - array[0].size)
      print array[1] + ' ' * (blanc_number.size + 10 - array[1].size)
      print array[2] + ' ' * (blanc_number.size + 10 - array[2].size)
      puts "\n"
    end
  end
elsif !opt['a']
  def file_names
    Dir.glob('*').sort
  end
  if opt ['r']
    def file_names
      Dir.glob('*').sort.reverse
    end
  end
  if opt['l']
    file_names.each do |file|
      puts l_option(file)[0] + ' ' + l_option(file)[1].to_s + ' ' + l_option(file)[2] + ' ' + l_option(file)[3] + ' ' + l_option(file)[4].to_s + ' ' + l_option(file)[5] + ' ' + l_option(file)[6]
    end
  else
    A = file_names
    B = A.size
    if B % 3 != 0
      (3 - (B % 3)).times do
        A.push(' ')
      end
      X = A.each_slice(B.div(3) + 1).to_a # あまりがでるなら割った数＋1
    elsif (b % 3).zero?
      X = A.each_slice(B.div(3)).to_a
    end
    Y = X.transpose
    blanc_number = A.max_by(&:length)
    Y.each do |array|
      print array[0] + ' ' * (blanc_number.size + 10 - array[0].size)
      print array[1] + ' ' * (blanc_number.size + 10 - array[1].size)
      print array[2] + ' ' * (blanc_number.size + 10 - array[2].size)
      puts "\n"
    end
  end
end
