using Base.Test
include(string(pwd(), "/api/Core.jl"))

# comp #
@test comp(string)(1) == "1"
@test comp(string, float)(1) == "1.0"
@test comp(string, (x) -> x + x)(2) == "4"
@test comp(str)(0,1,2,3,4,5,6,7,8,9) == "0123456789"
@test comp(parse, string)(0,1,2,3,4,5,6,7,8,9) == 123456789
@test comp(str)("0.1") == "0.1"
@test comp(str, inc)(0.1) == "1.1"
@test comp(inc, inc, inc, inc, inc)(1) == 6
@test comp(str, str, inc, inc, inc, inc)(1) == "5"
@test comp(str, inc, inc, inc, inc, inc, inc)(1) == "7"
@test comp(parse, str)(1) == 1
@test comp(parse, str, str)(1) == 1
@test comp(parse, str, str, str)(1) == 1
@test comp(inc, parse, str, str, str, inc)(1) == 3

# str #
@test str(1) == "1"
@test str(1,2,3) == "123"
@test str([1,2,3]) == "[1, 2, 3]"
@test str() == ""


#=
DEBUG NOTES:

When calling collect() on a collection with only one element. The type of the collection collected as an array
is automatically promoted to that type

=#
