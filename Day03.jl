# Input data
data = BitArray(
    hcat(
        map(
            line -> map(x -> parse(Int64, x), split(line, "")),
            readlines("Day03.input"),
        )...,
    ),
);

# Part 1
γ = (A) -> (sum(A, dims = 2) .>= size(A, 2) / 2)';
ε = (A) -> γ(A) .⊻ 1;
todecimal = (V) -> sum(map(((i, v),) -> v << (size(V, 2) - i), enumerate(V)));

ans = todecimal(γ(data)) * todecimal(ε(data));
println("Part 1: $ans")

# Part 2
rating =
    (F, A) ->
        reduce(
            (acc, v) -> size(acc, 2) > 1 ? acc[:, findall(==(F(acc)[v]), acc[v, :])] : acc,
            1:size(A, 1),
            init = A,
        )';

ans = todecimal(rating(γ, data)) * todecimal(rating(ε, data));
println("Part 2: $ans")
