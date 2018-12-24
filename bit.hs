{-# LANGUAGE TypeSynonymInstances #-}

import Clarity

-- Bit

type Bit = Either Unit Unit
zero = Left ()
one = Right ()

-- Unary operators

buffer :: Bit -> Bit
buffer = iden

invert :: Bit -> Bit
invert = fork (constant one) (constant zero)

-- Binary operators
type Word2 = (Bit, Bit)

and2 :: Word2 -> Bit
and2 = match (constant zero) (exr iden)

nand2 :: Word2 -> Bit
nand2 = match (constant one) (exr invert)

or2 ::  Word2 -> Bit
or2 = match (exr iden) (constant one) 

xor2 :: Word2 -> Bit
xor2 = match (exr iden) (exr invert)

halfadder :: Word2 -> Word2
halfadder = join xor2 and2

-- Ternary operators

mux :: (Bit, (Bit, Bit)) -> Bit
mux = match (exr (exl iden)) (exr (exr iden))

fulladder :: (Word2,Bit) -> Word2
fulladder = join s c
    where
        ha = comp (exl iden) halfadder 
        has = comp ha (exl iden)
        hac = comp ha (exr iden)
        cin = exr iden
        s = comp (join has cin) xor2
        c = comp (join hac cin) or2


