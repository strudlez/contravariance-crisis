module Lib
    (
     history,
     someFunc
    ) where

import Network.Wreq
import  Data.ByteString.Lazy.Internal

someFunc :: IO ()
someFunc = putStrLn "someFunc"

history :: String -> IO (Response ByteString)
history t = get $ url t

url :: String -> String
url t = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.historicaldata%20where%20symbol%20%3D%20%22" ++ t ++ "%22%20and%20startDate%20%3D%20%222015-01-01%22%20and%20endDate%20%3D%20%222016-01-01%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
