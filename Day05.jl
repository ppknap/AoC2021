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
    (line) -> (
        mincoord = min.(line[1], line[2]);
        maxcoord = max.(line[1], line[2]);
        filter(
            p -> (norm(line[1] .- p) + norm(line[2] .- p) ≈ norm(line[1] .- line[2])),
            vec(
                collect(
                    Iterators.product(mincoord[1]:maxcoord[1], mincoord[2]:maxcoord[2]),
                ),
            ),
        )
    );

getans = (data) -> count(>(1), values(countmap(Iterators.flatten(map(allpoints, data)))));

ans = getans(filter((line) -> any(line[1] .== line[2]), data));
println("Part 1: $ans")

# Part 2
ans = getans(data);
println("Part 2: $ans")