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
end
