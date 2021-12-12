using Graphs

# Input data
data = map(e -> Tuple(split(e, "-")), readlines("Day12.input"));

# Part 1
mappings = Dict(
    map(
        ((k, v),) -> (v, k),
        enumerate(unique(sort(reduce((acc, p) -> append!(acc, [p...]), data, init = [])))),
    ),
);

g = reduce(
    (g, p) -> (add_edge!(g, mappings[p[1]], mappings[p[2]]); g),
    data,
    init = SimpleGraph(length(mappings)),
);

canrepeat = map(
    v -> isuppercase(first(first(keys(filter(((k, v2),) -> v == v2, mappings))))),
    vertices(g),
);

function all_possible_paths(
    g::AbstractGraph{U},
    canrepeat::Vector{Bool},
    start::Int64,
    curr::Int64,
    exit::Int64;
    visited::Vector{Bool} = map(v -> v == curr, 1:nv(g)),
    smallused::Bool = false,
) where {U<:Real}
    curr == exit && return 1

    total = 0
    for v in outneighbors(g, curr)
        newvisited = map(((i, ok),) -> i == v ? true : ok, enumerate(visited))
        if !visited[v] || canrepeat[v]
            total += all_possible_paths(
                g,
                canrepeat,
                start,
                v,
                exit;
                visited = newvisited,
                smallused = smallused,
            )
        end
        if visited[v] && !canrepeat[v] && !smallused && v != exit && v != start
            total += all_possible_paths(
                g,
                canrepeat,
                start,
                v,
                exit;
                visited = newvisited,
                smallused = true,
            )
        end
    end
    total
end

ans = all_possible_paths(
    g,
    canrepeat,
    mappings["start"],
    mappings["start"],
    mappings["end"];
    smallused = true,
);
println("Part 1: $ans")


# Part 2
ans =
    all_possible_paths(g, canrepeat, mappings["start"], mappings["start"], mappings["end"]);
println("Part 2: $ans")
