require "date"
require 'optparse' 
day = Date.today 
options = ARGV.getopts("y:", "m:") 

if options["y"] 
  year = options["y"].to_i 
else
  year = day.year 
end

if options["m"] 
  mon = options["m"].to_i 
else
  mon = day.mon 
end

year = Date.new(year, mon, 1).year
mon = Date.new(year, mon, 1).mon

firstday_wday = Date.new(year, mon, 1).wday 
lastday_day = Date.new(year, mon, -1).day
week = %w(日 月 火 水 木 金 土)

puts "#{mon}月#{year}年".center(20)
puts week.join(" ")
print "   " * firstday_wday

wday = firstday_wday
(1..lastday_day).each do |date|
  print date.to_s.rjust(2) + " "
  wday = wday + 1
  if wday%7 == 0
    print "\n"
  end
end
if wday%7!=0
  print "\n"
end
