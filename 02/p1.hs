readIn = do
  l <- getLine
  if l /= "end-of-input"
    then do
      i <- readIn
      return $ l : i
  else
    return []

maxDiff row = maximum row - minimum row

main = do
  lines <- readIn
  let l = map words lines
  let spreadsheet = map (map read) l
  print (sum (map maxDiff spreadsheet))
