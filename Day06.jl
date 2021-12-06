# Input data
data = map(x -> parse(Int64, x), split(readline("Day06.input"), ","));

# Part 1
getans =
    (days, data) -> sum(
        reduce(
            (acc, _) -> (v = circshift(acc, -1); v[7] += v[9]; v),
            1:days,
            init = map(x -> count(==(x - 1), data), 1:9),
        ),
    );

ans = getans(80, data);
println("Part 1: $ans")

# Part 2
ans = getans(256, data);
println("Part 2: $ans")
