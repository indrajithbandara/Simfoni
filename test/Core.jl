using Base.Test
include(string(pwd(), "/api/Core.jl"))

@test comp(string)(1) == "1"
@test comp(string, float)(1) == "1.0"
@test comp(string, (x) -> x + x)(2) == "4"
@test comp(string)(0,1,2,3,4,5,6,7,8,9) == "0123456789"
@test comp(parse, string)(0,1,2,3,4,5,6,7,8,9) == 123456789
@test comp(inc, inc, inc, inc, inc)(1) == 6
#@test comp(inc, inc, inc, inc, str)(1) != "7" #TODO fix instance of object conversion failure
