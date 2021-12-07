using LinearAlgebra, StatsBase

# Input data
data = map(
    x -> map(
        rawpoint -> (raw = split(rawpoint, ","); Tuple(map(v -> parse(Int64, v), raw))),
        split(x, " -> "),
    ),
    readlines("Day05.input"),
);

# Part 1
allpoints =
    (line) -> (filter(
        p -> (norm(line[1] .- p) + norm(line[2] .- p) ≈ norm(line[1] .- line[2])),
        vec(
            collect(
                Iterators.product(
                    range(extrema(first.(line))...),
                    range(extrema(last.(line))...),
                ),
            ),
        ),
    ));

getans = (data) -> count(>(1), values(countmap(Iterators.flatten(map(allpoints, data)))));

ans = getans(filter((line) -> any(line[1] .== line[2]), data));
println("Part 1: $ans")

# Part 2
ans = getans(data);
println("Part 2: $ans")