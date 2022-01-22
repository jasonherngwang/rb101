p ([[[1, 2], [3, 4]], [5, 6]].map do |arr|
  arr.map do |el|
    if el.to_s.size > 1
      el.map do |e|
        e + 1
      end
    else
      el + 1
    end
  end
end)