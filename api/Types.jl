abstract type Baz end
mutable struct Foo <: Baz
  x::Int
  y::Int
end

mutable struct Bar <: Baz
  x::Int
  y::Int
end

mutable struct FFF <: Tuple <: Array
  x::Int
  y::Int
end
