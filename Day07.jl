# Input data
data = map(x -> parse(Int64, x), split(readline("Day07.input"), ","));

# Part 1
mindistance =
    (F, data) ->
        reduce((acc, v) -> min(acc, v), map(x -> F(x, data), range(extrema(data)...)))

ans = mindistance((x, data) -> sum(map(v -> abs(v - x), data)), data);
println("Part 1: $ans")

# Part 2
ans = mindistance(
    (x, data) -> sum(map(v -> (n = abs(v - x); (n * (n + 1)) >> 1), data)),
    data,
);
println("Part 2: $ans")
