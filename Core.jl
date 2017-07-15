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

function comp(fnOne::Any, fnTwo::Any, fnThree::Any)
  function f()
    comp(fnOne, fnTwo)(fnThree)
  end

  function f(x::Any)
    comp(fnOne, fnTwo)(fnThree(x))
  end
end


function comp(fnOne::Any, fnTwo::Any, fnThree::Any, fnRest...)
  function f()
    comp(fnOne, fnTwo, fnThree)(fnThree)
  end
  function f(x::Any)
    comp(fnOne, fnTwo, fnThree)(fnThree(x))
  end
end
