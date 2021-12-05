# Input data
data = map(x -> parse(Int64, x), readlines("Day01.input"));

# Part 1
getans =
    (offset) ->
        count(map(((i, v),) -> (i > offset && v - data[i-offset] > 0), enumerate(data)));

ans = getans(1);
println("Part 1: $ans")

# Part 2
ans = getans(3);
println("Part 2: $ans")
