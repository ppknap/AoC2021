# Input data
data = hcat(map(v -> map(x->parse(Int64, x), v), map(line->split(line, ""), readlines("Day09.input")))...)';

# TODO

# Part 1
# ans = mindistance((x, data) -> sum(map(v -> abs(v - x), data)), data);
# println("Part 1: $ans")



cols = size(data, 1)
rows = size(data, 2)

countrows = (x, y) -> begin
  #  @show ((x, y), data[x, y])
    if x < 1 || y < 1 || x > cols || y > rows || data[x, y] == 9
        return 0
    end
    #println("OK", x, y, " ", data[x, y])

    data[x, y] = 9

    return 1 + countrows(x-1, y) + countrows(x+1, y) + countrows(x, y-1) + countrows(x, y+1)
end

v = []
for i in 1:cols
    for j in 1:rows
        push!(v, countrows(i, j))
    end
end

h = prod(reverse(sort(filter(>(0), v)))[1:3])

# Part 2
println("Part 2: $h")
