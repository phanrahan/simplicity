module Clarity where 

import Prelude 

-- category

type Unit = ()

unit :: a -> Unit
unit _ = () 

iden :: a -> a
iden a = a

comp :: (a -> b) -> (b -> c) -> a -> c
comp s t a = t (s a)

constant a _ = a

-- products

exl :: (a -> c) -> (a, b) -> c 
exl f (a, _) = f a

exr :: (b -> c) -> (a, b) -> c
exr f (_, b) = f b

join :: (a -> b) -> (a -> c) -> a -> (b, c)
join f g a = (f a, g a)

-- coproducts

inl :: (a -> b) -> a -> (Either b c)
inl t a = Left (t a)

inr :: (a -> c) -> a -> (Either b c)
inr t a = Right (t a)

fork :: (a -> c) -> (b -> c) -> (Either a b) -> c 
fork f g (Left a) = f a
fork f g (Right b) = g b

-- match 

match :: ((a,c) -> d) -> ((b,c) -> d) -> (Either a b, c) -> d
match f t (Left a, c) = f (a,c)
match f t (Right b, c) = t (b,c)

fold fl fr f = comp (join l r) f
    where
        l = comp (exl iden) fl
        r = comp (exr iden) fr
foldl f = fold f iden f
foldr f = fold iden f f
foldlr f = fold f f f

-- isomorphisms

commute:: (a, b) -> (b, a)
commute (a, b) = (b, a)

commutes:: Either a b -> Either b a
commutes (Left a) = Right a
commutes (Right a) = Left a

assocl:: (a, (b, c)) -> ((a, b), c)
assocl (a, (b, c)) =  ((a, b), c)
assocr:: ((a, b), c) -> (a, (b, c))
assocr ((a, b), c) =  (a, (b, c))

--distributel:: ((Either a b), c) = Either (a,c) (b, c)
--distributel':: Either (a,c) (b,c) = ((Either a b), c)
--distributer:: (a, (Either b c)) = Either (a,b) (a, c)
--distributer':: Either (a, b) (a, c) = (a, (Either b c))

