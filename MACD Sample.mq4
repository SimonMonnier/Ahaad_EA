//+------------------------------------------------------------------+
//|                                              IchimukuFetcher.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

/// 140 bougie à récupérer + kijun & tanken 
/// 27 dans le futur pour le nuage
/// 26 dans le passé, début chikounspan

//+-----------------------------------------------------------------------+
//| Extern global variable                                                |
//+-----------------------------------------------------------------------+
extern int slippage = 10 ;
extern int MagicNumber = 1618 ;



//+-----------------------------------------------------------------------+
//| global variable                                                       |
//+-----------------------------------------------------------------------+

string currentSymbole = "";

int filehandle = 0;

//+-----------------------------------------------------------------------+
//| Init function                                                         |
//+-----------------------------------------------------------------------+
int OnInit()
{
   currentSymbole = Symbol();
   filehandle = FileOpen("marketData.csv",FILE_WRITE|FILE_CSV);

   return(INIT_SUCCEEDED);
}


//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
      FileClose(filehandle);
  }
      
//+-----------------------------------------------------------------------+
//| Expert tick function                                                  |
//+-----------------------------------------------------------------------+
void OnTick()
{
   GetData();
}

//////////////////////////////////////////////////////////////////////////////



//+-----------------------------------------------------------------------+
//| getChikouSpan function                                                |
//+-----------------------------------------------------------------------+
string getChikouSpanM1()
{  
   string chikouString = "";
   int i = 8 * 15;
   while (i > 26)
   {
      double chikoutmp = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_CHIKOUSPAN,i);
      if (i > 27)
      {
         chikouString = StringConcatenate(chikouString,chikoutmp,";");
      }
      else
      {
         chikouString = StringConcatenate(chikouString,chikoutmp);
      }
      i--;
   }
   return chikouString;
}

string getChikouSpanM5()
{  
   string chikouString = "";
   int i = 8 * 3 + 26;
   while (i > 26)
   {
      double chikoutmp = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_CHIKOUSPAN,i);
      if (i > 27)
      {
         chikouString = StringConcatenate(chikouString,chikoutmp,";");
      }
      else
      {
         chikouString = StringConcatenate(chikouString,chikoutmp);
      }
      i--;
   }
   return chikouString;
}

string getChikouSpanM15()
{  
   string chikouString = "";
   int i = 8+ 26;
   while (i > 26)
   {
      double chikoutmp = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_CHIKOUSPAN,i);
      if (i > 27)
      {
         chikouString = StringConcatenate(chikouString,chikoutmp,";");
      }
      else
      {
         chikouString = StringConcatenate(chikouString,chikoutmp);
      }
      i--;
   }
   return chikouString;
}


//+-----------------------------------------------------------------------+
//| getCloud function                                                     |
//+-----------------------------------------------------------------------+
string getSpanM1()
{
   string spanString = "";
   int i = 8 * 15;
   while (i > -24)
   {
      double spanAtmp = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_SENKOUSPANA,i);
      double spanBtmp = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_SENKOUSPANB,i);
      if (i > -25)
      {
         spanString = StringConcatenate(spanString,spanAtmp,";",spanBtmp,";");
      }
      else
      {
         spanString = StringConcatenate(spanString,spanAtmp,";",spanBtmp);
      }
      i--;
   }
   return spanString;
}

string getSpanM5()
{
   string spanString = "";
   int i = 8 * 3 + 26;
   while (i > -26)
   {
      double spanAtmp = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_SENKOUSPANA,i);
      double spanBtmp = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_SENKOUSPANB,i);
      if (i > -27)
      {
         spanString = StringConcatenate(spanString,spanAtmp,";",spanBtmp,";");
      }
      else
      {
         spanString = StringConcatenate(spanString,spanAtmp,";",spanBtmp);
      }
      i--;
   }
   return spanString;
}

string getSpanM15()
{
   string spanString = "";
   int i = 8 + 26;
   while (i > -26)
   {
      double spanAtmp = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_SENKOUSPANA,i);
      double spanBtmp = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_SENKOUSPANB,i);
      if (i > -27)
      {
         spanString = StringConcatenate(spanString,spanAtmp,";",spanBtmp,";");
      }
      else
      {
         spanString = StringConcatenate(spanString,spanAtmp,";",spanBtmp);
      }
      i--;
   }
   return spanString;
}

//+-----------------------------------------------------------------------+
//| getRedLine function                                                   |
//+-----------------------------------------------------------------------+
string getTekanM1()
{
   string tekanString = "";
   int i = 8 * 15;
   while (i > -1)
   {
      double tekantmp = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_TENKANSEN,i);
      if (i > 0)
      {
         tekanString = StringConcatenate(tekanString,tekantmp,";");
      }
      else
      {
         tekanString = StringConcatenate(tekanString,tekantmp);
      }
      i--;
   }
   return tekanString;
}

string getTekanM5()
{
   string tekanString = "";
   int i = 8 * 3;
   while (i > -1)
   {
      double tekantmp = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_TENKANSEN,i);
      if (i > 0)
      {
         tekanString = StringConcatenate(tekanString,tekantmp,";");
      }
      else
      {
         tekanString = StringConcatenate(tekanString,tekantmp);
      }
      i--;
   }
   return tekanString;
}

string getTekanM15()
{
   string tekanString = "";
   int i = 8;
   while (i > -1)
   {
      double tekantmp = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_TENKANSEN,i);
      if (i > 0)
      {
         tekanString = StringConcatenate(tekanString,tekantmp,";");
      }
      else
      {
         tekanString = StringConcatenate(tekanString,tekantmp);
      }
      i--;
   }
   return tekanString;
}


//+-----------------------------------------------------------------------+
//| getBlueLine function                                                  |
//+-----------------------------------------------------------------------+
string getKijunM1()
{
   string kijunString = "";
   int i = 8 * 15;
   while (i > -1)
   {
      double kijuntmp = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,i);
      if (i > 0)
      {
         kijunString = StringConcatenate(kijunString,kijuntmp,";");
      }
      else
      {
         kijunString = StringConcatenate(kijunString,kijuntmp);
      }
      i--;
   }
   return kijunString;
}

string getKijunM5()
{
   string kijunString = "";
   int i = 8 * 3;
   while (i > -1)
   {
      double kijuntmp = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,i);
      if (i > 0)
      {
         kijunString = StringConcatenate(kijunString,kijuntmp,";");
      }
      else
      {
         kijunString = StringConcatenate(kijunString,kijuntmp);
      }
      i--;
   }
   return kijunString;
}

string getKijunM15()
{
   string kijunString = "";
   int i = 8;
   while (i > -1)
   {
      double kijuntmp = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,i);
      if (i > 0)
      {
         kijunString = StringConcatenate(kijunString,kijuntmp,";");
      }
      else
      {
         kijunString = StringConcatenate(kijunString,kijuntmp);
      }
      i--;
   }
   return kijunString;
}


//+-----------------------------------------------------------------------+
//| getPrice function                                                  |
//+-----------------------------------------------------------------------+
string getPriceM1()
{
   string priceString = "";
   int i = 8 * 15;
   while (i > -1)
   {
      if (i > 0)
      {
         priceString = StringConcatenate(priceString,iOpen(currentSymbole,PERIOD_M1,i),";",iClose(currentSymbole,PERIOD_M1,i),";",iHigh(currentSymbole,PERIOD_M1,i),";",iLow(currentSymbole,PERIOD_M1,i),";");
      }
      else
      {
         priceString = StringConcatenate(priceString,iOpen(currentSymbole,PERIOD_M1,i),";",iClose(currentSymbole,PERIOD_M1,i),";",iHigh(currentSymbole,PERIOD_M1,i),";",iLow(currentSymbole,PERIOD_M1,i));
      }
      i--;
   }
   return priceString;
}

string getPriceM5()
{
   string priceString = "";
   int i = 8 * 3;
   while (i > -1)
   {
      if (i > 0)
      {
         priceString = StringConcatenate(priceString,iOpen(currentSymbole,PERIOD_M5,i),";",iClose(currentSymbole,PERIOD_M5,i),";",iHigh(currentSymbole,PERIOD_M5,i),";",iLow(currentSymbole,PERIOD_M5,i),";");
      }
      else
      {
         priceString = StringConcatenate(priceString,iOpen(currentSymbole,PERIOD_M5,i),";",iClose(currentSymbole,PERIOD_M5,i),";",iHigh(currentSymbole,PERIOD_M5,i),";",iLow(currentSymbole,PERIOD_M5,i));
      }
      i--;
   }
   return priceString;
}

string getPriceM15()
{
   string priceString = "";
   int i = 8;
   while (i > -1)
   {
      if (i > 0)
      {
         priceString = StringConcatenate(priceString,iOpen(currentSymbole,PERIOD_M15,i),";",iClose(currentSymbole,PERIOD_M15,i),";",iHigh(currentSymbole,PERIOD_M15,i),";",iLow(currentSymbole,PERIOD_M15,i),";");
      }
      else
      {
         priceString = StringConcatenate(priceString,iOpen(currentSymbole,PERIOD_M15,i),";",iClose(currentSymbole,PERIOD_M15,i),";",iHigh(currentSymbole,PERIOD_M15,i),";",iLow(currentSymbole,PERIOD_M15,i));
      }
      i--;
   }
   return priceString;
}


////////////////////////////////////////////
//    Prepare Data Concatenate
////////////////////////////////////////////
string concatenate()
{
   string concat = "";
   double spread = MarketInfo(Symbol(), MODE_SPREAD);
   concat = StringConcatenate(Ask,";",Bid,";",((Ask + Bid)/2),";",spread,";",getChikouSpanM1(),";",getSpanM1(),";",getTekanM1(),";",getKijunM1(),";",getPriceM1());
   return concat;
}

////////////////////////////////////////////
//    Push Data into the file
////////////////////////////////////////////
void GetData()
{
      ResetLastError();
   if(filehandle != INVALID_HANDLE)
   {
      FileWrite(filehandle,concatenate());
   }
   else Print("Operation FileOpen failed, error ",GetLastError());
}