module Html.Internal where
import GHC.Natural (Natural)
import Html.Markup

newtype Html = Html String

type Title = String

html_ :: Title -> Structure -> Html
html_ title content =
  Html
    ( el "html"
      ( el "head" (el "title" (escape title))
        <> el "body" (getStructureString content)
      )
    )

p_ :: String -> Structure
p_ = Paragraph

h1_ :: String -> Structure
h1_ = Heading 1

ul_ :: [String] -> Structure
ul_ = UnorderedList

ol_ :: [String] -> Structure
ol_ = OrderedList

code_ :: [String] -> Structure
code_ = CodeBlock

el :: String -> String -> String
el tag content =
  "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

instance Semigroup Structure where
  (<>) :: Structure -> Structure -> Structure
  (<>) (Paragraph a) (Paragraph b) = Paragraph (a <> b)
  (<>) a b = Paragraph (getStructureString a <> getStructureString b)


getStructureString :: Structure -> String
getStructureString content =
  case content of
    Heading n str -> el ("h" <> show n) (escape str)
    Paragraph str -> el "p" (escape str)
    UnorderedList items -> el "ul" (concatMap (el "li" . escape) items)
    OrderedList items -> el "ol" (concatMap (el "li" . escape) items)
    CodeBlock lines -> el "pre" (unlines lines)

render :: Html -> String
render html =
  case html of
    Html str -> str

-- Not working properly
escape :: String -> String
escape =
    let
        escapeChar c =
            case c of
                -- '<' -> "&lt;"
                -- '>' -> "&gt;"
                '&' -> "&amp;"
                '"' -> "&quot;"
                '\'' -> "&#39;"
                _ -> [c]
    in
        concatMap escapeChar

parse :: String -> Document
parse = parseLines [] . lines

parseLines :: [String] -> [String] -> Document
parseLines currentParagraph txts =
  let
    paragraph = Paragraph (unlines (reverse currentParagraph)) -- (2), (3)
  in
    case txts of -- (4)
      [] -> [paragraph]
      currentLine : rest ->
        if trim currentLine == ""
          then
            paragraph : parseLines [] rest -- (5)
          else
            parseLines (currentLine : currentParagraph) rest -- (6)

trim :: String -> String
trim = unwords . words
