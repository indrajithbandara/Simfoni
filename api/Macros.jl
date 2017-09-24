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

 """
condition
 """
