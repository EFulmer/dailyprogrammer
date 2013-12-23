
import Data.Char
import qualified Data.Set as S

isPangram :: String -> Bool
isPangram cs = let
    alpha = S.fromList ['a'..'z']
    lcs = S.fromList $ map toLower cs
    in
    alpha `S.isSubsetOf` lcs
    
