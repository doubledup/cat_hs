module Main where

import System.Environment (getArgs)
import System.IO (withFile, hGetContents, IOMode(ReadMode))
import Control.Exception (catch, SomeException)
import Data.Maybe (listToMaybe, fromMaybe)

x |> f = f x

main = do
  args <- getArgs
  let filenameAction = case args of
        (head:_) -> return (Just head)
        [] -> return Nothing
  filename <- filenameAction
  case filename of
    (Just filename) -> catch (
      withFile filename ReadMode $ \h -> do
        contents <- hGetContents h
        putStrLn contents)
      handler
      where
        handler :: SomeException -> IO ()
        handler _ = putStr $ "cat: " ++ filename ++ ": No such file or directory"
    Nothing -> do
      _ <- mapM (\_ -> do
          l <- getLine
          putStrLn l)
        $ repeat 0
      return ()
