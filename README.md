# Haskell-project
Question 1
Write two different functions max1 and max2 that compute the maximum of three numbers (without using built-in functions for computing the maximum). (Note: your two functions need to be computationally different, thus the same algorithm once implemented with an if-construction, once with a guarded equation, does not qualify.)

Question 2
Pizzeria Luigi sells pizzas of an arbitrary size and with an arbitrary number of toppings. The owner Luigi wishes to have a program that allows to compute the selling price of a pizza depending on its size (given by its diameter in cm) and the number of toppings. The pizza base costs are £0.002 per square centimetre and the costs for each topping £0.6 per topping Since Luigi also wants to make some profit, he multiplies the costs of a pizza by a factor 1.6. The result should be rounded to two digits. Can you help Luigi with a suitable Haskell function luigi :: Float -> Float -> Float? Is Pizza Bambini (tomatoes, mozzarella, ham, salami, broccoli, mushrooms, 15 cm) more expensive than Pizza Famiglia (tomatoes, mozzarella, 32 cm)? Add an answer to this question as a comment.

Question 3
Write a function that counts how many digits occur in a given list of characters. Do this in different ways, using

list comprehension
higher order functions
recursion
Question 4
In this part we will start off with a bit of nice string crunching! As a warm up, create a function normaliseSpace :: String -> String, that removes all double spaces in a string (and merges them into one single space). E.g.: normaliseSpace " ab c def " = " ab c def "
Next, we will do something that makes parsing e.g. names easier. Write two functions, normaliseFront :: String -> String and normaliseBack :: String -> String, that remove preceding and tailed spaces, respectively. So normaliseFront " abc d e " = "abc d e " and normaliseBack " abc d e " = " abc d e" For the remainder of this part the strings can be assumed to be finite.
Great! Now we just put everything together. Write a function normalise :: String -> String that combines the effect of all previous functions, so that the input string is stripped of leading spaces, following spaces and inbetween never has any more but one consecutive space.
This part is about generalising a bit what we have done before. First, we write some similar functions for the previous task, called prefix, substr and postfix, all with the type String -> String -> Bool. Their task is obvious from their name, so here are some examples of how they should work: prefix "abc" "abcdef" = True prefix "abc" "aabcaa" = False substring "abc" "aabcaa" = True 2 substring "abc" "aabbcc" = False postfix "abc" "defabc" = True postfix "abc" "aaabcc" = False For this task, all arguments are assumed to be finite. Furthermore it goes without saying that this time, no strings need to be normalised. (Do NOT use the library functions isPrefixOf, isSuffixOf or isInfixOf!)
Splendid! Now we try for something more difficult. Have you ever written a mail to 200+ students and wanted to address each by name? We did. Write a function substitute :: String -> String -> String -> String, such that substitute xs ys zs replaces the string xs in zs by ys, e.g. substitute "#name" "yourname" "Dear #name, you are awesome!" yields "Dear yourname, you are awesome!" Hints: substitute [] _ _ is undefined. Always the ”first match” is replaced, i.e. substitute "aa" "b" "aaa" yields "ba". There can be more than one or no instances of the string to be replaced.
Question 5
Implement the game of Nim. The rules are as follows: decide on a number of piles and a number of coins in each pile. E.g., [5,2,4,7] represents 4 piles where the first has 5 coins, the second 2, and so on. Two players play in turns. Each player choses a pile and removes one or more coins from it. The player that takes the last coin wins. Implement the core two player game by providing:

a function won::[Int] -> Bool that looks at the current list of piles and checks whether the game is won.
a function validMove that takes the current state of the piles, a number of a pile, and a number coins to be removed, and checks whether the pile entered and the number of coins entered consititue a valid move to do.
a function takeAway that takes the current state of the piles, a number of a pile, and a number of coins to be removed and computes the new state of piles.
a function getMove1::[Int]->IO(Int,Int) that takes as argument the current pile state and asks the user for the next move, i.e.for a pile and the number of coins to remove. A pair of the two inputs should be returned by function.
a function getMove2::[Int]->IO(Int,Int) that takes as argument the current pile state and asks the user for the next move, but checks in addition whether the move is valid. If not the user would be asked again. If the move is not valid, the user should be asked again for a next move.
a function displayGame that takes the list of piles and draws the current state as below. If the list of piles is: [5,4,3,6] it draws:
1:*****
2:****
3:**
4:******
a function nim that asks the users for their names and for an initial configuration of piles. If nothing is entered use as default: [5,4,3,6]. This function will then call a function nimaux that takes as argument a pair consisting of the names of the players and the list of piles as arguments and recursively plays the game using the above functions.
Question 6
In this question we want to build a version that allows to play nim against the computer. To do so, we need to equip the computer with a strategy how it plays this game.

Create a basic strategy stratB:: [Int] -> (Int, Int), that given a list of piles decides on the next move (number of piles and coins to take from the pile, as above.). In the basic strategy, always the first non-empty pile should be removed completely.
Create a version nimAI :: ([Int] -> (Int,Int)) -> IO() that takes in a strategy and allows a player to play against the computer (with this stragegy.) The player is allowed to start.
Create a second improved (optimal?) strategy, stratI, for the computer. Briefly explain how how your strategy works as a comment.
