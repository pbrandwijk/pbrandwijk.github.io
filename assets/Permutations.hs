module Main where

import Data.List (delete)

data Card = Red | Green | Blue | Yellow deriving (Show, Eq, Ord)


-- Function takes a set of elements and returns the set of all permutations
--
-- The base case is the empty list, in which case a list with an empty list returned
-- The recursive case starts by mapping each element in the list to a function that maps each 
-- permutation of the remainder of the list (so without the current element) to a function that 
-- puts the current element at the head of the permutation. 
--
-- Because this would generate lists of lists of lists, we apply a fold function to join the result 
-- of each permutation option together.
perms :: Eq a => [a] -> [[a]]
perms [] = [[]]
--perms xs = foldr (++) [] $ map (\x -> map (\ys -> [x] ++ ys) (perms (delete x xs))) xs
perms xs = foldr (++) [] $ map (\x -> insertAtEachHead (perms (delete x xs)) x) xs
--perms xs = map (\x -> [x] ++ (delete x xs)) xs

-- Put x at the head of every list in xss
insertAtEachHead :: [[a]] -> a -> [[a]]
insertAtEachHead xss x = map (insertAtHead x) xss
--insertAtEachHead xss x = map (\xs -> [x] ++ xs) xss

-- Insert an element at the head of a list
insertAtHead :: a -> [a] -> [a]
insertAtHead x xs = [x] ++ xs



{--
Take a list l and an integer n. Calculate all possible orderings of a list with 
n elements, using the elements of l. This means f(l, length l) is the list of 
permutations of l.
--}
orderings :: Eq a => [a] -> Int -> [[a]]
orderings _ 0 = [[]]
orderings ls n = foldr (++) [] $ map (\x -> map (\ys -> [x] ++ ys) (orderings (delete x ls) (n-1))) ls


separations :: [a] -> [(a,[a])]
separations xs = separations' xs ((length xs) - 1)

separations' :: [a] -> Int -> [(a, [a])]
separations' [] _ = []
separations' xs n
  | n < 0 = []
  | otherwise = (xs !! n, let (ys,zs) = splitAt n xs in ys ++ (tail zs)) : separations' xs (n-1) 






