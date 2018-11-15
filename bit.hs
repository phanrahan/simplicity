-- Bit

import Clarity

type Bit = Either () ()
zero = Left ()
one = Right ()

invert :: Bit -> Bit
invert = fork (constant one) (constant zero)

type Word2 = (Bit, Bit)

and2 :: Word2 -> Bit
and2 = ife (constant zero) iden

or2 ::  Word2 -> Bit
or2 = ife iden (constant one) 

xor2 :: Word2 -> Bit
xor2 = ife iden invert

fold3 :: (Word2 -> Bit) -> (Bit, (Bit, Bit)) -> Bit
fold3 f = comp (join l r) f
    where 
        l = exl iden
        r = comp (exr iden) f

and3 = fold3 and2

type Word4 = (Word2, Word2)

fold4 :: (Word2 -> Bit) -> Word4 -> Bit
fold4 f = comp (join l r) f
    where 
        l = comp (exl iden) f
        r = comp (exr iden) f

and4 = fold4 and2

halfadder :: Word2 -> Word2
halfadder = join xor2 and2

-- fulladder :: (Word2,Bit) -> Word2
-- fulladder = join s c
--     where
--         ha0 = join halfadder iden
--         ha1 = comp (join (comp (exr iden) (exl iden)) (comp (exr iden) (exl iden))) ha0
--         s = exl ha1
--         c = comp (join (comp (exr iden) ha0) (comp (exr iden) ha1)) or2
