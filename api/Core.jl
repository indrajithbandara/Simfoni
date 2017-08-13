function inc(x::Number)
    x + 1
end

function comp()
  function f(x)
    identity(x)
  end
end

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
  reduce(comp, unshift!(collect(fnRest), fnOne, fnTwo))
end


function str()
  ""
end

function str(x:: Any)
    if is(x, nothing) # TODO add nil check
        ""
    else string(x)
    end
end

function str(x:: Any, xs...)
    reduce(string, unshift!(collect(xs), x)) # TODO fix nothings should be removed eg [1,nothing,3] => 13
end
