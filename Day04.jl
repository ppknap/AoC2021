# Input data
data = readlines("Day04.input");
steps = map(v -> parse(Int64, v), split(data[1], ","));
boards = map(
    rows -> hcat(
        map(
            row -> map(v -> parse(Int64, v), filter(!isempty, split(row, " "))),
            rows[2:end],
        )...,
    ),
    Iterators.partition(data[2:end], 6),
);

# Part 1
stepboard = collect(Iterators.flatten(map(step -> map(v -> (step, v), boards), steps)));
applystep = (A, num) -> map(x -> x == num ? -1 : x, A);
isbingo =
    (A) -> any(
        vcat(map(col -> all(col .< 0), eachcol(A)), map(row -> all(row .< 0), eachrow(A))),
    );

candidates = filter(
    x -> (isbingo(x[2]) != isbingo(applystep(x[2], x[1]))),
    map(
        ((i, _),) -> (
            len = size(boards, 1);
            stepboard[i] = (
                stepboard[i][1],
                i > len ? applystep(stepboard[i-len][2], stepboard[i-len][1]) :
                stepboard[i][2],
            )
        ),
        enumerate(stepboard),
    ),
);

getans =
    (F, candidates) ->
        F(candidates)[1] * sum(filter(>(0), applystep(F(candidates)[2], F(candidates)[1])));

ans = getans(first, candidates);
println("Part 1: $ans")

# Part 2
ans = getans(last, candidates);
println("Part 2: $ans")
