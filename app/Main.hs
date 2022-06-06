import Geometry.Shapes
  ( Enveloppe (..),
    Point (Point),
    geoIntersect,
    movePoint,
  )
import System.Environment
import System.Exit
import System.Random (Random (randomRs), newStdGen)
import System.Random.Internal (StdGen)

data TableRecord shp = TableRecord Int shp Int
  deriving (Show)

genRandomPointsList :: Int -> (Float, Float) -> StdGen -> StdGen -> [Point]
genRandomPointsList llength pointsInterval seed1 seed2 =
  let tuples = zip (randomRs pointsInterval seed1) (randomRs pointsInterval seed2)
   in take llength $ uncurry Point <$> tuples


tac  = unlines . reverse . lines
parse ["-h"] = usage   >> exit
parse ["-v"] = version >> exit
parse []     = getContents
parse fs     = concat `fmap` mapM readFile fs

usage   = putStrLn "Usage: tac [-vh] [file ..]"
version = putStrLn "Haskell tac 0.1"
exit    = exitWith ExitSuccess
die     = exitWith (ExitFailure 1)

main :: IO ()
-- main = getArgs >>= parse >>= putStr . tac
main = do
  seed1 <- newStdGen
  seed2 <- newStdGen


  let pointList = genRandomPointsList 10 (0.0, 100.0) seed1 seed2
  let envelope = Enveloppe 1.0 100.0 1.0 100.0
  print $ pointList
  print $ fmap (movePoint envelope seed1) pointList
