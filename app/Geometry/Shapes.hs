module Geometry.Shapes
  ( Point (..),
    Enveloppe (..),
    geoIntersect,
    movePoint,
  )
where

-- import System.Random (Shuffle)
import System.Random.Internal (StdGen)

data Point = Point Float Float
  deriving (Show, Eq, Ord)

data Enveloppe = Enveloppe
  { xMin :: Float,
    xMax :: Float,
    yMin :: Float,
    yMax :: Float
  }
  deriving (Show, Eq, Ord)

type Seed = Int

geoIntersect :: Point -> Enveloppe -> Bool
geoIntersect (Point x y) (Enveloppe xmin xmax ymin ymax) =
  let xOk = x < xmax && x > xmin; yOk = y < ymax && y > ymin
   in xOk && yOk

movePoint ::  Enveloppe -> StdGen -> Point -> Maybe Point
movePoint e s (Point x y)=
	let mleft (Point a b) = Point (a - 1) b;
            mright (Point a b) = Point (a + 1) b;
            mup (Point a b) = Point a (b + 1);
            mdown (Point a b) = Point a (b - 1);
	    funcList = [mright, mleft, mdown, mup ];
   in subMovePoint (Point x y) funcList
  where
    subMovePoint :: Point -> [Point -> Point] -> Maybe Point
    subMovePoint (Point a b) (xf:xfs)
      | geoIntersect (xf (Point a b)) e = Just (xf (Point a b))
      | otherwise =
        if null xfs
          then Nothing
          else subMovePoint (Point a b) xfs
    subMovePoint _ _ = Nothing
