doubleMe :: Num a => a -> a
doubleMe x = x + x

main :: IO ()
main = print (doubleMe 5)  -- This will print "10"
