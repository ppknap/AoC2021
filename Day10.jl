using Statistics

# Input data
data = map(line -> map(p -> p[1], split(line, "")), readlines("Day10.input"));

# Part 1
scoreparenthesis =
    (c) -> Int.(c .== ('(', '[', '{', '<')) .- Int.(c .== (')', ']', '}', '>'));

tocallstack =
    (f) -> reduce(
        (acc, v) -> (
            any(scoreparenthesis(v) .< 0) ?
            length(acc) == 0 ? push!(acc, (v, false)) :
            (
                last(acc)[2] &&
                all((scoreparenthesis(v) .+ scoreparenthesis(pop!(acc)[1])) .== 0) ?
                acc : push!(acc, (v, false))
            ) : push!(acc, (v, true))
        ),
        f,
        init = [],
    );

ans = sum(
    reduce(
        (acc, v) -> acc .+ (v .* (3, 57, 1197, 25137)),
        map(
            v -> scoreparenthesis(first(v)[1]) .* -1,
            filter(!isempty, map(d -> filter(t -> !t[2], tocallstack(d)), data)),
        ),
        init = (0, 0, 0, 0),
    ),
);
println("Part 1: $ans")

# Part 2
ans = Int(Statistics.median(
    map(
        v -> sum(
            reduce(
                (acc, p) -> (acc .* 5) .+ (scoreparenthesis(p[1]) .* (1, 2, 3, 4)),
                reverse(v),
                init = (0, 0, 0, 0),
            ),
        ),
        filter(s -> all(map(p -> p[2], s)), map(v -> tocallstack(v), data)),
    ),
));
println("Part 2: $ans")
