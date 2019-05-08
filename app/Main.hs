module Main where

import Lib
import System.Environment

main :: IO ()
main = do
  paths <- getArgs
  mapM_ readDisk paths
