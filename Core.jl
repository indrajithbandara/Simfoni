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


# (defn comp
#   "Takes a set of functions and returns a fn that is the composition
#   of those fns.  The returned fn takes a variable number of args,
#   applies the rightmost of fns to the args, the next
#   fn (right-to-left) to the result, etc."
#   {:added "1.0"
#    :static true}
#   ([] identity)
#   ([f] f)
#   ([f g]
#      (fn
#        ([] (f (g)))
#        ([x] (f (g x)))
#        ([x y] (f (g x y)))
#        ([x y z] (f (g x y z)))
#        ([x y z & args] (f (apply g x y z args)))))
#   ([f g & fs]
#      (reduce1 comp (list* f g fs))))
