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
Array_
"""
function array_(x::Any, arg::Tuple)
  v = unshift!(convert(Array{Any}, collect(arg)), x)
  return v
end

function array_(x::Any, y::Any, arg::Tuple)
  v = unshift!(convert(Array{Any}, collect(arg)), x, y)
  return v
end

function array_(x::Any, y::Any, z::Any, arg::Tuple)
  v = unshift!(convert(Array{Any}, collect(arg)), x, y, z)
  return v
end

function array_(arg::Tuple, args...)
  any_arr = convert(Array{Any}, collect(arg))
  for i in args
    v = unshift!(any_arr, i)
  end
  return 1
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
    v = unshift!(collect(args), x, y, z)
    fnOne(reduce(fnTwo, v))
  end
end

function comp(fnOne::Function, fnTwo::Function, fnRest...)
  v = unshift!(convert(Array{Any}, collect(fnRest)), fnOne, fnTwo)
  reduce(comp, v)
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
"""

function apply(fn::Function, arg::Array{Any})
  reduce(fn, arg)
end

function apply(fn::Function, x::Any, arg::Array{Any})
  v = unshift!(arg, x)
  reduce(fn, v)
end

function apply(fn::Function, x::Any, y::Any, arg::Array{Any})
  v = unshift!(arg, x, y)
  reduce(fn, v)
end

function apply(fn::Function, x::Any, y::Any, z::Any, arg::Array{Any})
  v = unshift!(arg, x, y, z)
  reduce(fn, v)
end


function apply(fn::Function, a::Any, b::Any, c::Any, d::Any, args...)
  v = unshift!(convert(Array{Any}, collect(args)), a, b, c, d)
  reduce(fn, arg)
end


################################################################################
#Macros
################################################################################
using MacroTools

"""
Thread first
"""
macro >(exs...)
  thread(x) = isexpr(x, :block) ? thread(rmlines(x).args...) : x

  thread(x, ex) =
    isexpr(ex, :call, :macrocall) ? Expr(ex.head, ex.args[1], x, ex.args[2:end]...) :
    @capture(ex, f_.(xs__))       ? :($f.($x, $(xs...))) :
    isexpr(ex, :block)            ? thread(x, rmlines(ex).args...) :
    Expr(:call, ex, x)

  thread(x, exs...) = reduce(thread, x, exs)

  esc(thread(exs...))
end
