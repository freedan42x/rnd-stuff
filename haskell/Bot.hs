{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
module Bot where

import Data.Text (Text, unpack)
import Data.List (intercalate)
import Text.Printf (printf)
import Control.Monad.State (StateT(..), put, get)


newtype Subject = Topic 
  { topic :: Text }
  deriving Eq

newtype BotRate = BotRate 
  { botRate :: (Subject, Int) }
  deriving Eq

data BotData = BotData {
  botName  :: Text,
  botRates :: [BotRate]
} deriving Eq

data Bot = Bot {
  botData  :: BotData,
  botLevel :: Int
} deriving Eq

type BotM = StateT Bot IO ()


instance Show Subject where
  show (Topic t) = "Topic < " <> unpack t <> " >"

instance Show BotRate where
  show (BotRate (s, n)) = show s <> " with rate " <> show n

instance Show BotData where
  show (BotData {..}) = printf "Bot %s; Interests:\n%s" (unpack botName)
    (intercalate "\n" $ show <$> botRates)

instance Show Bot where
  show (Bot {..}) = printf "Level %d; " botLevel <> show botData


-- | Initialize new bot
initBot :: Text -> Bot
initBot name = Bot (BotData name []) 0

initBotM :: Text -> BotM
initBotM = put . initBot

-- | Modifies bot so that it adds new BotRate to exisiting ones
addBotRate :: Bot -> BotRate -> Bot
addBotRate (Bot {..}) botRate = Bot (botData { botRates = botRate : botRates botData }) $ succ botLevel

addBotRateM :: BotRate -> BotM
addBotRateM botRate = do
  bot <- get
  put $ addBotRate bot botRate  


test0, test1 :: IO Bot -- Should be the same
test0 = do
  let bredorV0 = initBot "Bredor"
      bredorV1 = addBotRate bredorV0 $ BotRate (Topic "loli", 999)
      bredorV2 = addBotRate bredorV1 $ BotRate (Topic "hentai", 888)
  return bredorV2
test1 = runStateT code (initBot "Bredor") >>= return . snd
  where 
    code = do
      bot <- get
      addBotRateM $ BotRate (Topic "loli", 999)
      addBotRateM $ BotRate (Topic "hentai", 888)

main :: IO ()
main = do
  x <- test0
  y <- test1
  if x == y then
    print x
  else
    putStrLn ":("
