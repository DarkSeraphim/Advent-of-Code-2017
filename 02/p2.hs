readIn = do
  l <- getLine
  if l /= "end-of-input"
    then do
      i <- readIn
      return $ l : i
  else
    return []
    
isDivisor :: Int -> Int -> Bool
isDivisor x y = x /= y && x `mod` y == 0

findDivisor :: Int -> [Int] -> [Int]
findDivisor x row = filter (isDivisor x) row

scanRow :: [Int] -> Int -> Int
scanRow row x = sum(map (x `div`) (findDivisor x row))

findDivision :: [Int] -> Int
findDivision row = (sum (map (scanRow row) row))

main = do
  lines <- readIn
  let l = map words lines :: [[String]]
  let spreadsheet = map (map read) l
  print (sum(map findDivision spreadsheet))
