# Input data
data = map(
    x -> (toks = split(x, " ");
    (name, v) = (toks[1], parse(Int64, toks[2]));
    ((name == "up") * v, (name == "down") * v, (name == "forward") * v)),
    readlines("Day02.input"),
);

# Part 1
ans = prod(reduce(.+, map(((u, d, f),) -> (d - u, f), data)));
println("Part 1: $ans")

# Part 2
ans = prod(
    reduce(
        .+,
        map(
            (aim, (_, _, f)) -> (f * aim, f),
            cumsum(map(((u, d, _),) -> d - u, data)),
            data,
        ),
    ),
);
println("Part 2: $ans")
