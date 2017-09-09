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

function comp()
  function f(x)
    identity(x)
  end
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

function comp(fnOne::Function)
  fnOne
end

function comp(fnOne::Function, fnTwo::Function)
  function f()
    fnOne(fnTwo)
  end
  function f(x::Any)
    fnOne(fnTwo(x))
  end
  function f(x::Any, y::Any)
    fnOne(fnTwo(x, y))
  end
  function f(x::Any, y::Any, z::Any)
    fnOne(fnTwo(x, y, z))
  end
  function f(x::Any, y::Any, z::Any, args...)
    fnOne(reduce(fnTwo, unshift!(collect(args), x, y, z)))
  end
end

function comp(fnOne::Function, fnTwo::Function, fnRest...)
  reduce(comp, unshift!(convert(Array{Any}, collect(fnRest)), fnOne, fnTwo))
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
