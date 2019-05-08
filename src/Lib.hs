module Lib
    ( readDisk
    ) where

import Data.Binary.Get
import qualified Data.ByteString.Lazy as BL
import Data.Word

-- magic numbers for identifying disk types
proDosDisk = 0x0138b0034c32a186
dos33Disk = 0x01a527c909d018a5

data DiskType = ProDosDisk | Dos33Disk deriving Show

diskType :: Word64 -> Maybe DiskType
diskType magicNumber
  | magicNumber == proDosDisk = Just ProDosDisk
  | magicNumber == dos33Disk = Just Dos33Disk
  | otherwise = Nothing

readDisk :: FilePath -> IO ()
readDisk path = do
  rawBytes <- BL.readFile path
  let magicNumber = runGet getWord64be rawBytes
  print $ diskType magicNumber
