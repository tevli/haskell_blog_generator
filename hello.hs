-- type signatures are variable name :: Type just like in typescript
-- so something like html_ :: Title -> Structure -> Html means the variable name is html_ and it is a function that takes in a title and a structure and returns element of type Html
import Html


main :: IO ()
main = putStrLn (render myhtml)

myhtml :: Html
myhtml =
  html_
    "Haskell Blog Generator"
    ( h1_ "Heading"
      <> p_ "Paragraph #1"
      <> p_ "Paragraph #2"
      <> p_ "Paragraph #3"
    )