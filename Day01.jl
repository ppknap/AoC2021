data = map(x -> parse(Int64, x), readlines("Day01.input"));

# Part 1
countdecreased =
    (offset) ->
        count(map(((i, v),) -> (i > offset && v - data[i-offset] > 0), enumerate(data)));

ans = countdecreased(1);
println("Part 1: $ans")

# Part 2
ans = countdecreased(3);
println("Part 2: $ans")
