{-# LANGUAGE OverloadedStrings #-}

module Main where

import Options.Applicative
import Options.Applicative.Builder (str)
import Data.Text

import Lib


data Verbosity = Normal | Verbose
data Options = Options {
  verbose :: Verbosity
  , tickers :: [Text]
  }

commaListOption :: Mod OptionFields [Text] -> Parser [Text]
commaListOption = option $ ((splitOn "," . pack) <$> str)

optionsParser :: Parser Options
optionsParser =
  Options
  <$>
  flag Normal Verbose
  ( long "verbose"
    <> short 'v'
    <> help "Enable verbose mode" )
  <*> commaListOption
  ( long "tickers"
    <> short 't'
    <> metavar "TARGET"
    <> help "Tickers to evaluate")


greet :: Options -> IO ()
greet (Options Verbose h) = putStrLn $ "List of tickers, " ++ (show h)
greet _ = return ()

main :: IO ()
main = execParser opts >>= greet
  where
    opts = info (helper <*> optionsParser)
      ( fullDesc
     <> progDesc "Calculate the beta of a list of stocks"
     <> header "A simple program to calculate beta of stocks" )
