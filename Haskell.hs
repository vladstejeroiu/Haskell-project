import Test.QuickCheck
import Text.Printf
import Data.Char
import Data.List
import Data.Maybe

----------Question1---------- 
--------a)
max1 :: Int -> Int -> Int -> Int
max1 x y z = 
          if x >= y && x >= z then x
          else if y >= x && y >= z then y
          else z
-- max1 986965 984963 984174
-- 986965
max2 :: Int -> Int -> Int -> Int
max2 x y z = 
          if x -(y+z) >= y -(x+z) && x -(y+z) >= z -(x+y) then x
          else if y -(x+z) >= x -(y+z) && y -(x+z) >= z -(x+y) then y
          else z
-- max2 986965 984963 984174
-- 986965

--------b)
checkcorrectness :: Int -> Int -> Int -> Bool
checkcorrectness x y z =
         max1 x y z == max2 x y z
-- +++ Ok, passed 100 tests.
--  This correctness check has a weakness as 100 tests cases might not be enough in order to cover all the possible situations.

----------Question2----------
rounded :: Float -> Int -> Float
rounded x n = (fromIntegral (floor (x * t))) / t
    where t = 10^n

circleArea :: Float -> Float
circleArea d = pi* (d/2)* (d/2)
 
luigi :: Float -> Float -> Float
luigi x y = rounded (( (circleArea x) *0.002 + y*0.6)*1.6) (2)

--Pizza Bambini 6.32
--Pizza Famiglia 4.49
--Pizza Bambini is more expensive than pizza Famiglia.

----------Question3----------
---------a)
counta :: [Char] -> Int
counta xs =
       length [ x| x <- xs, isDigit x]

---------b)
countb :: [Char] -> Int
countb xs = length (filter isDigit xs)

---------c)
countc :: [Char] -> Int
countc [] = 0
countc (x:xs) = 
               if isDigit x then 1 + countc xs
               else countc xs

----------Question4----------

--------------a)
isSpace1::Char -> Bool
isSpace1 c = if c == ' ' then True 
             else False

normaliseSpace::String -> String
normaliseSpace [] = []
normaliseSpace (x:[]) = [x]
normaliseSpace (x:(s:xs)) = 
                    if (isSpace1 x && isSpace1 s) then normaliseSpace (s:xs)
                    else x:(normaliseSpace (s:xs))

--------------b)
normaliseFront::String -> String
normaliseFront = dropWhile isSpace1 

normaliseBack::String -> String
normaliseBack = dropWhileEnd isSpace1 

--------------c)
normalise::String -> String
normalise xs = normaliseFront (normaliseBack (normaliseSpace xs))

--------------d)
prefix::String -> String -> Bool
prefix x xs = 
          if take (length x) xs == x then True
          else False

substr::String -> String -> Bool
substr (x:xs) [] = False
substr xs ys =
            if prefix xs ys then True
            else if substr xs (tail ys) then True
            else False

postfix::String -> String -> Bool
postfix x xs = 
          if reverse (take (length x) (reverse xs)) == x then True
          else False

--------------e)
substitute::String -> String -> String -> String
substitute _ _ []= []
substitute xs ys zs = 
              if take (length xs) zs == xs
              then ys ++ (substitute  xs ys (drop (length xs) zs))
              else [head zs] ++ (substitute  xs ys (tail zs))

----------Question5----------
----------a)
won :: [Int] -> Bool
won [] = True
won (x:xs) = 
            if x /=0 then False
            else won xs
   
----------b) 
validMove :: [Int] -> Int -> Int -> Bool
validMove [] _ _ = False
validMove (x:xs) n y =
                      if y == 0 then False
                      else if n == 0 && x - y >= 0 then True  
                      else validMove xs (n-1) y 

----------c)
takeAway :: [Int] -> Int -> Int -> [Int]
takeAway [] _ _ = []
takeAway (x:xs) n y = 
                     if n == 0 then (x-y):xs  
                     else [x] ++ takeAway xs (n-1) y

----------d)
getMove1 :: [Int] -> IO (Int,Int)
getMove1 [] = return (0,0)
getMove1 (x:xs) = do {
                      ;putStr "Enter pile number: "
                      ;x <- readLn
                      ;putStr "Enter coins number:"
                      ;y <- readLn
                      ;return (x,y)}

----------e)
getMove2 :: [Int] -> IO (Int,Int)
getMove2 [] = return (0,0)
getMove2 (x:xs) = do {
                      ;putStr "Enter pile number: "
                      ;p <- readLn
                      ;putStr "Enter coins number: "
                      ;c <- readLn
                      ;if validMove (x:xs) p c == True then return (p,c)
                      ;else do
                      ; putStr "Invalid move \n"
                      ;getMove2 (x:xs) }

----------f)
printStars :: Int -> IO()
printStars 0 = putStr "\n"
printStars x = 
              do {
                  ;putStr "*"
                  ;printStars(x-1)} 

displayGame :: [Int] -> Int -> IO()
displayGame [] _ = putStr ""
displayGame (x:xs) y = 
                    do { 
                        ;putStr (show y) 
                        ;putStr ":"
                        ;printStars x
                        ;displayGame xs (y+1)}


-----------g)
nim :: IO()
nim = do {
          ;putStr "Enter the name of player 1: "
          ;player1 <- getLine
          ;putStr "Enter the name of player 2: "
          ;player2 <- getLine
          ;putStr "Enter the number of piles(if you want a default config enter 0): "
          ;nr <- getLine
          ;if (read nr :: Int) == 0 then nimaux (player1,player2) [5,4,3,6]
          ;else do {putStr"Enter the pile configuration: \n "
          ;input <- getLine
          ;let piles = (read input :: [Int]) 
          ;nimaux (player1,player2) piles }}

nimaux :: (String, String) -> [Int] -> IO()
nimaux (player1, player2) xs = do{ 
                                  ;displayGame xs 0
                                  ;(x,y) <- getMove2 xs
                                  ;newxs <- return (takeAway xs x y) 
                                  ;if won newxs then putStr (player1 ++ ", you have won! \n")
                                   else nimaux (player2, player1) newxs}
------------h)

-----We chose to display the piles from 0-3 not 1-4 because the array index starts from 0
---nim
------Enter the name of player 1: Alex
------Enter the name of player 2: Mazi
------Enter the number of piles(if you want a default config enter 0): 3
------Enter the pile configuration: 
------[3,4,5]
------0:***
------1:****
------2:*****
------Enter pile number: 0
------Enter coins number: 1
------0:**
------1:****
------2:*****
------Enter pile number: 2
------Enter coins number: 1
------0:**
------1:****
------2:****
------Enter pile number: 1
------Enter coins number: 2
------0:**
------1:**
------2:****
------Enter pile number: 0
------Enter coins number: 2
------0:
------1:**
------2:****
------Enter pile number: 0
------Enter coins number: 3
------Invalid move 
------Enter pile number: 2
------Enter coins number: 3
------0:
------1:**
------2:*
------Enter pile number: 1
------Enter coins number: 1
------0:
------1:*
------2:*
------Enter pile number: 1
------Enter coins number: 1
------0:
------1:
------2:*
------Enter pile number: 2
------Enter coins number: 1
------Mazi, you have won!
----------Question6----------
 
------------a)
stratB :: [Int] -> (Int, Int)
stratB (x:xs) = do {
                    ;let ys = zip [0..] (x:xs)
                    ;head [(x,y) | (x,y) <- ys, y/=0] }
------------b)
nimAI :: ([Int] -> (Int, Int)) -> IO()
nimAI xs = do {
               ;putStr "Enter the name of player : "
               ;player1 <- getLine
               ;let computer = "Computer"
               ;putStr "Enter the number of piles(if you want a default config enter 0): "
               ;nr <- getLine
               ;if (read nr :: Int) == 0 then nimauxAI (player1,computer) [5,4,3,6] xs
               ;else putStr "Enter the pile configuration: \n "
               ;input <- getLine
               ;let piles = (read input :: [Int]) 
               ;nimauxAI (player1,computer) piles xs }

auxComputer ::(String, String) -> [Int] -> ([Int] -> (Int, Int)) -> IO()
auxComputer (player1,player2) xs strategy = do {
                                                ;displayGame xs 0
                                                ;putStr "Computer's turn \n"
                                                ;let stratX = fst(strategy xs)
                                                ;let stratY = snd(strategy xs)
                                                ;newxs <- return (takeAway xs stratX stratY)
                                                ;if won newxs then putStr (player1 ++ ", you have won! \n")
                                                 else nimauxAI (player2, player1) newxs strategy}

auxPlayer :: (String,String) -> [Int] -> ([Int] -> (Int, Int))-> IO()
auxPlayer (player1,player2) xs  strategy = do { 
                                               ;displayGame xs 0
                                               ;(x,y) <- getMove2 xs
                                               ;newxs <- return (takeAway xs x y)
                                               ;if won newxs then putStr (player1 ++ ", you have won! \n")
                                                else nimauxAI (player2,player1) newxs strategy }

nimauxAI :: (String, String) -> [Int] -> ([Int] -> (Int, Int)) -> IO()
nimauxAI (player1, computer) xs strategy = if player1 == "Computer" then auxComputer (player1,computer) xs strategy
                                           else if (won xs == False) then auxPlayer (player1,computer) xs strategy
                                           else putStr ""
-------------c)

----Algorithm description:
----Our AI system takes the pile with the maximum amount of coins
----and makes it equal with the minimum pile.
----This is better than the basic strategy as the computer does not
----always take unnecessary coins from a pile, leaving the opportunity
----for a player to take the last coins.  


maxi :: [Int] -> (Int,Int)
maxi xs  = do {
               ;let ys = zip [0..] (xs)              
               ;let zs = sortOn snd ys
               ;head (reverse zs)}
 

mini :: [Int] -> Int -> Int
mini [] y = y
mini (x:xs) y = if x < y then mini xs x
                else mini xs y      

stratI :: [Int] -> (Int, Int)
stratI xs = if snd (maxi xs) - mini xs 9999 == 0 then stratB xs
            else ( fst (maxi xs), snd (maxi xs) - mini xs 9999)

---nimAI stratI
---Enter the name of player : Alex
---Enter the number of piles(if you want a default config enter 0): 0
---0:*****
---1:****
---2:***
---3:******
---Enter pile number: 0
---Enter coins number: 4
---0:*
---1:****
---2:***
---3:******
---Computer's turn 
---0:*
---1:****
---2:***
---3:*
---Enter pile number: 1
---Enter coins number: 4
---0:*
---1:
---2:***
---3:*
---Computer's turn 
---0:*
---1:
---2:
---3:*
---Enter pile number: 0
---Enter coins number: 0
---Invalid move 
---Enter pile number: 0
---Enter coins number: 1
---0:
---1:
---2:
---3:*
---Computer's turn 
---Computer, you have won!


---We have tried to implement the winning strategy from CS-175
---With balanced and unbalanced positions
---However we could not implement this solution, 
---even though we know this is the optimal one
---If you could let us know the implementation for this strategy,
---that would be much appreciated.

toBin :: Int -> [Int]
toBin 0 = [0]
toBin 1 = [1]
toBin n
    | n `mod` 2 == 0 = toBin (n `div` 2) ++ [0]
    | otherwise = toBin (n `div` 2) ++ [1]

xor a b = if a==b then 0
           else 1

and' 1 1 = 1
and' _ _ = 0

bitsum :: [Int] -> [Int] -> [Int]
bitsum xs ys 
      |(sum xs) == 0 = ys
      |(sum ys) == 0 = xs
      |otherwise = bitsum low ((tail high) ++ [0])
           where low = zipWith xor xs ys
                 high = zipWith and' xs ys

mysum ::[Int] -> [Int]
mysum (x:(y:xs)) = bitsum (toBin (x)) (toBin (y))


 


