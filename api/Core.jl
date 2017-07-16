function comp()
  function f(x)
    identity(x)
  end
end

function comp(arg::Any)
  arg
end

function comp(fnOne::Any, fnTwo::Any)
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
