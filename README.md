# Clarity: A variation of the Simplicity programming language 

See https://blockstream.com/2017/10/30/simplicity.html

See https://medium.com/@danrobinson/understanding-simplicity-implementing-a-smart-contract-language-in-30-lines-of-haskell-827521bfeb4d for an implementation
in Haskell.

$ ghci bit.hs
ghci> invert one
Left ()
ghci> and2 (one, one)
Right ()

Evaluation

invert one
-- invert = fork (constant one) (constant zero) 
fork (constant one) (constant zero) one
-- one = Left ()
fork (constant one) (constant zero) (Right ())
-- fork _ r (Right x) = r x
constant zero ()
-- constant x _ = x
zero 

## reductions: folds and scans

fold
scan

TODO

type Unit = ()
data Sum a b = Left a | Right b
data Product a b = Product a b

data Bit = Sum Unit Unit


-- instance Show Bit where
--    show zero = "0"
--    show one  = "1"
