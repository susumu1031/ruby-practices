score = ARGV[0]
# frozen_string_literal: true
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' # ストライク
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
# 点数計算
frames.each_with_index do |frame, i|
  if i <= 9
    if frame[0] == 10 # ストライク
      frames_throw = frames[i + 1]
      if frames_throw[0] == 10 # 連続ストライク
        if shots[18] == 10 && shots[20] == 10 # 10,11フレーム目がストライク
          point += 10 + shots[22]
        elsif  shots[18] == 10 && shots[20] < 10
          point += 10 + shots[20] + shots[21]
        else
          frames[i + 2]
          frames_throw2 = frames[i + 2]
          point += 10 + frames_throw2[0]
        end
      elsif frames_throw[0] < 10 # 単発ストライク：i+1フレーム目の1、２投目を加算
        frames_throw[0]
        frames_throw[1]
        point += frames_throw[0] + frames_throw[1]
      end
    elsif frame.sum == 10
      # スペア：n+1フレーム目の１投目を加算
      frames[i + 1]
      frames_throw = frames[i + 1]
      frames_throw[0]
      point += frames_throw[0]
    end
  end
end
puts point + shots[0..19].sum
