data = map(x->parse(Int64, x), readlines("Day01.csv"));

# Part 1
ans = count(map(x->(x[1] > 1 && x[2] - data[x[1]-1] > 0), enumerate(data)));
println("Part 1: $ans")

# Part 2
ans = count(map(x->(x[1] > 3 && x[2] - data[x[1]-3] > 0), enumerate(data)));
println("Part 2: $ans")