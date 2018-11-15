module Clarity where 

import Prelude 

-- category

iden :: a -> a
iden a = a

comp :: (a -> b) -> (b -> c) -> a -> c
comp s t a = t (s a)

-- products

exl :: (a -> c) -> (a, b) -> c 
exl f (a, b) = f a

exr :: (b -> c) -> (a, b) -> c
exr f (a, b) = f b

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

-- combinators

constant b _ = b

ife :: (c -> d) -> (c -> d) -> (Either a b, c) -> d
ife f t (Left a, c) = f c
ife f t (Right b, c) = t c

-- isomorphisms

commute :: (a, b) -> (b, a)
commute (a,b) = (b,a)

associatel (a, (b, c)) =  ((a, b), c)
associater ((a, b), c) =  (a, (b, c))
