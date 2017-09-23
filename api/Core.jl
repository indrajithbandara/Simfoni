"""
Returns a number one greater than the number applied

# Examples
```julia-repl
julia> inc(1)
> 2
```
"""
function inc(x::Number)
    x + 1
end



"""
Creates a Vector{Any} containing the x's and y's
prepended to arg

# Examples
```julia-repl
julia> tuple_(tuple(4,5), 1,2,3)
> [1, 2, 3, 4, 5]
```

"""
function tuple_(arg::Tuple, x::Any)
  v = unshift!(collect(Any, arg), x)
  return v
end

function tuple_(arg::Tuple, x::Any, y::Any)
  v = unshift!(collect(Any, arg), x, y)
  return v
end

function tuple_(arg::Tuple, x::Any, y::Any, z::Any)
  v = unshift!(collect(Any, arg), x, y, z)
  return v
end

function tuple_(arg::Tuple, args...)
  vcat(collect(Any, args), collect(Any, arg))
end



"""
Takes a set of functions and returns a function that is the composition
of those functions. Functions are applied right to left. The returned
function takes a variable number of arguments, applies the rightmost
of functions to the arguments, the the next etc etc, until all
functions have been applied

# Examples
```julia-repl
julia> comp(parse, str, inc, x -> x * x)(2)
> 5
```
"""
function comp()
  function fn(x)
    identity(x)
  end
end

function comp(fnOne::Function)
  fnOne
end

function comp(fnOne::Function, fnTwo::Function)
  function fn()
    fnOne(fnTwo)
  end
  function fn(x::Any)
    fnOne(fnTwo(x))
  end
  function fn(x::Any, y::Any)
    fnOne(fnTwo(x, y))
  end
  function fn(x::Any, y::Any, z::Any)
    fnOne(fnTwo(x, y, z))
  end
  function fn(x::Any, y::Any, z::Any, args...)
    fnOne(reduce(fnTwo, tuple_(args, x, y, z)))
  end
end

function comp(fnOne::Function, fnTwo::Function, fnRest...)
  reduce(comp, tuple_(fnRest, fnOne, fnTwo))
end



"""
With no arguments returns an empty string. With one argument, returns
string(x). With 'nothing' applied, returns an empty string. With more
than one argument applied, returns the concatenation of the string
values

# Examples
```julia-repl

julia> str()
> ""

julia> str(nothing)
> ""

julia> str(1, 2, 3)
> "123"

julia> str([1, 2, 3])
> "[1, 2, 3]"
```
"""
function str()
  ""
end

function str(x:: Any)
    if x === nothing
        ""
    else string(x)
    end
end

function str(x:: Any, xs...)
    reduce(string, unshift!(collect(xs), x))
end



"""
Apply
"""
#TODO fix
function apply(fn::Function, arg::Array{Any})
  reduce(fn, arg)
end

function apply(fn::Function, x::Any, arg::Array{Any})
  reduce(fn, array(arg, x))
end

function apply(fn::Function, x::Any, y::Any, arg::Array{Any})
  reduce(fn, tuple_(arg, x, y))
end

function apply(fn::Function, x::Any, y::Any, z::Any, arg::Array{Any})
  reduce(fn, tuple_(arg, x, y, z))
end

function apply(fn::Function, a::Any, b::Any, c::Any, d::Any, args...)
  return 1
end
