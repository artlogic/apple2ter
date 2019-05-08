module Lib
    ( readDisk
    ) where

import Data.Binary.Get
import qualified Data.ByteString.Lazy as BL
import Data.Word

-- magic numbers for identifying disk types
proDosDisk = 0x0138b0034c32a186
dos33Disk = 0x01a527c909d018a5

diskType :: Word64 -> String
diskType magicNumber
  | magicNumber == proDosDisk = "ProDOS"
  | magicNumber == dos33Disk = "DOS 3.3"
  | otherwise = "Unknown"

readDisk :: FilePath -> IO ()
readDisk path = do
  rawBytes <- BL.readFile path
  let magicNumber = runGet getWord64be rawBytes
  putStrLn $ diskType magicNumber
