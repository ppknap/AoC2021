# Input data
data = map(
    digstrs ->
        map(digstr -> map(v -> join(sort(collect(v))), split(digstr, " ")), digstrs),
    map(line -> split(line, " | "), readlines("Day08.input")),
);

# Part 1
basemappings =
    (keys) -> Dict(
        first(filter(v -> length(v) == 2, keys)) => 1,
        first(filter(v -> length(v) == 4, keys)) => 4,
        first(filter(v -> length(v) == 3, keys)) => 7,
        first(filter(v -> length(v) == 7, keys)) => 8,
    )

ans = sum(sum(map(rec -> map(num -> haskey(basemappings(rec[1]), num), rec[2]), data)));
println("Part 1: $ans")

# Part 2
allmappings =
    (keys) -> (
        base = basemappings(keys);
        rev = Dict(v => k for (k, v) in base);
        merge(
            base,
            Dict(
                first(filter(v -> all([length(v) == 6, rev[1] ⊆ v, rev[4] ⊈ v]), keys)) => 0,
                first(filter(v -> all([length(v) == 5, rev[8] ⊆ (rev[4] ∪ v)]), keys)) => 2,
                first(filter(v -> all([length(v) == 5, rev[1] ⊆ v]), keys)) => 3,
                first(
                    filter(
                        v -> all([length(v) == 5, rev[8] ⊈ (rev[4] ∪ v), rev[1] ⊈ v]),
                        keys,
                    ),
                ) => 5,
                first(filter(v -> all([length(v) == 6, rev[1] ⊈ v, rev[4] ⊈ v]), keys)) => 6,
                first(filter(v -> all([length(v) == 6, rev[4] ⊆ v]), keys)) => 9,
            ),
        )
    )

ans = sum(
    map(
        rec -> reduce((acc, v) -> acc * 10 + allmappings(rec[1])[v], rec[2], init = 0),
        data,
    ),
);
println("Part 2: $ans")
