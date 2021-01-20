require "date"

head = Date.today.strftime("%B %Y")
year = Date.today.year
mon = Date.today.mon

firstday_wday = Date.new(year, mon, 1).wday # 曜日は0〜1
lastday_day = Date.new(year, mon, -1).day
week = %w(日 月 火 水 木 金 土)

puts head.center(20)
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
