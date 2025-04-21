-- type signatures are variable name :: Type just like in typescript
-- so something like html_ :: Title -> Structure -> Html means the variable name is html_ and it is a function that takes in a title and a structure and returns element of type Html
import Html


main :: IO ()
main = putStrLn (render myhtml)

myhtml :: Html
myhtml =
  html_
    "Haskell Blog Generator"
    ( append_
      (h1_ "Heading")
      ( append_
        (p_ "Paragraph #1 <")
        ( append_
          (p_ "Paragraph #2")
          (p_ "Paragraph #3")
        )
      )
    )
