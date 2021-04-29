//+------------------------------------------------------------------+
//|                                              IchimukuFetcher.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict



//+-----------------------------------------------------------------------+
//| Extern global variable                                                |
//+-----------------------------------------------------------------------+
extern int slippage = 10 ;
extern int MagicNumber = 1618 ;



//+-----------------------------------------------------------------------+
//| global variable                                                       |
//+-----------------------------------------------------------------------+
double Lot = 0.02 ;

string currentSymbole = "";
   
double SL = 150 ;
double TP = 30 ;

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
   //pushData();
   checkSell();
   checkBuy();
} 

void checkSell()
{
   double chikout26M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_CHIKOUSPAN,26);
   double chikout27M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_CHIKOUSPAN,27);
   double chikout28M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_CHIKOUSPAN,28);
   
   double chikout26M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_CHIKOUSPAN,26);
   double chikout27M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_CHIKOUSPAN,27);
   double chikout28M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_CHIKOUSPAN,28);
   
   double chikout26M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_CHIKOUSPAN,26);
   double chikout27M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_CHIKOUSPAN,27);
   double chikout28M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_CHIKOUSPAN,28);
   
   double chikout26H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_CHIKOUSPAN,26);
   double chikout27H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_CHIKOUSPAN,27);
   double chikout28H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_CHIKOUSPAN,28);
   
   double kijun0M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,0);
   double kijun1M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,1);
   double kijun2M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,2);
   double kijun26M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,26);
   double kijun27M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,27);
   double kijun28M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,28);
   
   double kijun0M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,0);
   double kijun1M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,1);
   double kijun2M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,2);
   double kijun26M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,26);
   double kijun27M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,27);
   double kijun28M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,28);
   
   double kijun0M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,0);
   double kijun1M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,1);
   double kijun2M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,2);
   double kijun26M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,26);
   double kijun27M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,27);
   double kijun28M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,28);
   
   double kijun0H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_KIJUNSEN,0);
   double kijun1H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_KIJUNSEN,1);
   double kijun2H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_KIJUNSEN,2);
   double kijun26H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_KIJUNSEN,26);
   double kijun27H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_KIJUNSEN,27);
   double kijun28H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_KIJUNSEN,28);
   
   if(chikout26M1 < kijun26M1 && chikout27M1 < kijun27M1 && chikout28M1 < kijun28M1
   && chikout26M5 < kijun26M5 && chikout27M5 < kijun27M5 && chikout28M5 < kijun28M5
   && chikout26M15 < kijun26M15 && chikout27M15 < kijun27M15 && chikout28M15 < kijun28M15
   /*&& chikout26H1 < kijun26H1 && chikout27H1 < kijun27H1 && chikout28H1 < kijun28H1*/
   && chikout26M1 < iHigh(Symbol(),PERIOD_M1,26) && chikout27M1 < iHigh(Symbol(),PERIOD_M1,27) && chikout28M1 < iHigh(Symbol(),PERIOD_M1,28)
   && chikout26M5 < iHigh(Symbol(),PERIOD_M5,26) && chikout27M5 < iHigh(Symbol(),PERIOD_M5,27) && chikout28M5 < iHigh(Symbol(),PERIOD_M5,28)
   && chikout26M15 < iHigh(Symbol(),PERIOD_M15,26) && chikout27M15 > iHigh(Symbol(),PERIOD_M15,27) && chikout28M15 > iHigh(Symbol(),PERIOD_M15,28)
   && iHigh(Symbol(),PERIOD_M1,0) < kijun0M1 && iHigh(Symbol(),PERIOD_M1,1) < kijun1M1 && iHigh(Symbol(),PERIOD_M1,2) < kijun2M1
   && iHigh(Symbol(),PERIOD_M5,0) < kijun0M1 && iHigh(Symbol(),PERIOD_M5,1) < kijun1M5 && iHigh(Symbol(),PERIOD_M5,2) < kijun2M5
   && iHigh(Symbol(),PERIOD_M15,0) < kijun0M1 && iHigh(Symbol(),PERIOD_M15,1) < kijun1M15 && iHigh(Symbol(),PERIOD_M15,2) < kijun2M15
   /*&& iHigh(Symbol(),PERIOD_H1,0) < kijun0M1 && iHigh(Symbol(),PERIOD_H1,1) < kijun1H1 && iHigh(Symbol(),PERIOD_H1,2) < kijun2H1*/ && OrdersTotal() == 0)
   {
      OrderSend(Symbol(),OP_SELL,Lot,Bid,slippage,SL,Bid-(TP*Point),"Trad",MagicNumber,0,Red);
   }
}


void checkBuy()
{
   double chikout26M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_CHIKOUSPAN,26);
   double chikout27M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_CHIKOUSPAN,27);
   double chikout28M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_CHIKOUSPAN,28);
   
   double chikout26M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_CHIKOUSPAN,26);
   double chikout27M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_CHIKOUSPAN,27);
   double chikout28M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_CHIKOUSPAN,28);
   
   double chikout26M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_CHIKOUSPAN,26);
   double chikout27M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_CHIKOUSPAN,27);
   double chikout28M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_CHIKOUSPAN,28);
   
   double chikout26H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_CHIKOUSPAN,26);
   double chikout27H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_CHIKOUSPAN,27);
   double chikout28H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_CHIKOUSPAN,28);
   
   double kijun0M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,0);
   double kijun1M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,1);
   double kijun2M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,2);
   double kijun26M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,26);
   double kijun27M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,27);
   double kijun28M1 = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,28);
   
   double kijun0M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,0);
   double kijun1M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,1);
   double kijun2M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,2);
   double kijun26M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,26);
   double kijun27M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,27);
   double kijun28M5 = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,28);
   
   double kijun0M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,0);
   double kijun1M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,1);
   double kijun2M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,2);
   double kijun26M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,26);
   double kijun27M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,27);
   double kijun28M15 = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,28);
   
   double kijun0H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_KIJUNSEN,0);
   double kijun1H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_KIJUNSEN,1);
   double kijun2H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_KIJUNSEN,2);
   double kijun26H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_KIJUNSEN,26);
   double kijun27H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_KIJUNSEN,27);
   double kijun28H1 = iIchimoku (currentSymbole,PERIOD_H1,9,26,52,MODE_KIJUNSEN,28);
   
   if(chikout26M1 > kijun26M1 && chikout27M1 > kijun27M1 //&& chikout28M1 > kijun28M1
   && chikout26M5 > kijun26M5 && chikout27M5 > kijun27M5 //&& chikout28M5 > kijun28M5
   /*&& chikout26M15 > kijun26M15 && chikout27M15 > kijun27M15 && chikout28M15 > kijun28M15
   && chikout26H1 > kijun26H1 && chikout27H1 > kijun27H1 && chikout28H1 > kijun28H1*/
   && chikout26M1 > iHigh(Symbol(),PERIOD_M1,26) && chikout27M1 > iHigh(Symbol(),PERIOD_M1,27) //&& chikout28M1 > iHigh(Symbol(),PERIOD_M1,28)
   && chikout26M5 > iHigh(Symbol(),PERIOD_M5,26) && chikout27M5 > iHigh(Symbol(),PERIOD_M5,27) //&& chikout28M5 > iHigh(Symbol(),PERIOD_M5,28)
   //&& chikout26M15 > iHigh(Symbol(),PERIOD_M15,26) && chikout27M15 > iHigh(Symbol(),PERIOD_M15,27) //&& chikout28M15 > iHigh(Symbol(),PERIOD_M15,28)
   && iHigh(Symbol(),PERIOD_M1,0) > kijun0M1 && iHigh(Symbol(),PERIOD_M1,1) > kijun1M1 //&& iHigh(Symbol(),PERIOD_M1,2) > kijun2M1
   && iHigh(Symbol(),PERIOD_M5,0) > kijun0M1 && iHigh(Symbol(),PERIOD_M5,1) > kijun1M5 //&& iHigh(Symbol(),PERIOD_M5,2) > kijun2M5
   /*&& iHigh(Symbol(),PERIOD_M15,0) > kijun0M1 && iHigh(Symbol(),PERIOD_M15,1) > kijun1M15 && iHigh(Symbol(),PERIOD_M15,2) > kijun2M15
   && iHigh(Symbol(),PERIOD_H1,0) > kijun0M1 && iHigh(Symbol(),PERIOD_H1,1) > kijun1H1 && iHigh(Symbol(),PERIOD_H1,2) > kijun2H1*/ && OrdersTotal() == 0)
   {
      double SLtmp = Bid+(SL*Point);
      OrderSend(Symbol(),OP_BUY,Lot,Ask,slippage,SLtmp,Ask+(TP*Point),"Trad",MagicNumber,0,Blue);
      OrderSend(Symbol(),OP_SELL,Lot,Bid,slippage,SLtmp,Bid-(TP*Point),"Trad",MagicNumber,0,Blue);
   }
}



//////////////////////////////////////////////////////////////////////////////



//+-----------------------------------------------------------------------+
//| getChikouSpan function                                                |
//+-----------------------------------------------------------------------+
string getChikouSpanM1()
{  
   string chikouString = "";
   int i = 78;
   while (i > 26)
   {
      double chikoutmp = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_CHIKOUSPAN,i);
      if (i > 27)
      {
         chikouString = StringConcatenate(chikouString,chikoutmp,",");
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
   int i = 78;
   while (i > 26)
   {
      double chikoutmp = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_CHIKOUSPAN,i);
      if (i > 27)
      {
         chikouString = StringConcatenate(chikouString,chikoutmp,",");
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
   int i = 78;
   while (i > 26)
   {
      double chikoutmp = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_CHIKOUSPAN,i);
      if (i > 27)
      {
         chikouString = StringConcatenate(chikouString,chikoutmp,",");
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
   int i = 78;
   while (i > -24)
   {
      double spanAtmp = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_SENKOUSPANA,i);
      double spanBtmp = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_SENKOUSPANB,i);
      if (i > -25)
      {
         spanString = StringConcatenate(spanString,spanAtmp,",",spanBtmp,",");
      }
      else
      {
         spanString = StringConcatenate(spanString,spanAtmp,",",spanBtmp);
      }
      i--;
   }
   return spanString;
}

string getSpanM5()
{
   string spanString = "";
   int i = 78;
   while (i > -26)
   {
      double spanAtmp = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_SENKOUSPANA,i);
      double spanBtmp = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_SENKOUSPANB,i);
      if (i > -27)
      {
         spanString = StringConcatenate(spanString,spanAtmp,",",spanBtmp,",");
      }
      else
      {
         spanString = StringConcatenate(spanString,spanAtmp,",",spanBtmp);
      }
      i--;
   }
   return spanString;
}

string getSpanM15()
{
   string spanString = "";
   int i = 78;
   while (i > -26)
   {
      double spanAtmp = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_SENKOUSPANA,i);
      double spanBtmp = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_SENKOUSPANB,i);
      if (i > -27)
      {
         spanString = StringConcatenate(spanString,spanAtmp,",",spanBtmp,",");
      }
      else
      {
         spanString = StringConcatenate(spanString,spanAtmp,",",spanBtmp);
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
   int i = 78;
   while (i > -1)
   {
      double tekantmp = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_TENKANSEN,i);
      if (i > 0)
      {
         tekanString = StringConcatenate(tekanString,tekantmp,",");
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
   int i = 78;
   while (i > -1)
   {
      double tekantmp = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_TENKANSEN,i);
      if (i > 0)
      {
         tekanString = StringConcatenate(tekanString,tekantmp,",");
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
   int i = 78;
   while (i > -1)
   {
      double tekantmp = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_TENKANSEN,i);
      if (i > 0)
      {
         tekanString = StringConcatenate(tekanString,tekantmp,",");
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
   int i = 78;
   while (i > -1)
   {
      double kijuntmp = iIchimoku (currentSymbole,PERIOD_M1,9,26,52,MODE_KIJUNSEN,i);
      if (i > 0)
      {
         kijunString = StringConcatenate(kijunString,kijuntmp,",");
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
   int i = 78;
   while (i > -1)
   {
      double kijuntmp = iIchimoku (currentSymbole,PERIOD_M5,9,26,52,MODE_KIJUNSEN,i);
      if (i > 0)
      {
         kijunString = StringConcatenate(kijunString,kijuntmp,",");
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
   int i = 78;
   while (i > -1)
   {
      double kijuntmp = iIchimoku (currentSymbole,PERIOD_M15,9,26,52,MODE_KIJUNSEN,i);
      if (i > 0)
      {
         kijunString = StringConcatenate(kijunString,kijuntmp,",");
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
   int i = 78;
   while (i > -1)
   {
      if (i > 0)
      {
         priceString = StringConcatenate(priceString,iOpen(currentSymbole,PERIOD_M1,i),",",iClose(currentSymbole,PERIOD_M1,i),",",iHigh(currentSymbole,PERIOD_M1,i),",",iLow(currentSymbole,PERIOD_M1,i),",");
      }
      else
      {
         priceString = StringConcatenate(priceString,iOpen(currentSymbole,PERIOD_M1,i),",",iClose(currentSymbole,PERIOD_M1,i),",",iHigh(currentSymbole,PERIOD_M1,i),",",iLow(currentSymbole,PERIOD_M1,i));
      }
      i--;
   }
   return priceString;
}

string getPriceM5()
{
   string priceString = "";
   int i = 78;
   while (i > -1)
   {
      if (i > 0)
      {
         priceString = StringConcatenate(priceString,iOpen(currentSymbole,PERIOD_M5,i),",",iClose(currentSymbole,PERIOD_M5,i),",",iHigh(currentSymbole,PERIOD_M5,i),",",iLow(currentSymbole,PERIOD_M5,i),",");
      }
      else
      {
         priceString = StringConcatenate(priceString,iOpen(currentSymbole,PERIOD_M5,i),",",iClose(currentSymbole,PERIOD_M5,i),",",iHigh(currentSymbole,PERIOD_M5,i),",",iLow(currentSymbole,PERIOD_M5,i));
      }
      i--;
   }
   return priceString;
}

string getPriceM15()
{
   string priceString = "";
   int i = 78;
   while (i > -1)
   {
      if (i > 0)
      {
         priceString = StringConcatenate(priceString,iOpen(currentSymbole,PERIOD_M15,i),",",iClose(currentSymbole,PERIOD_M15,i),",",iHigh(currentSymbole,PERIOD_M15,i),",",iLow(currentSymbole,PERIOD_M15,i),",");
      }
      else
      {
         priceString = StringConcatenate(priceString,iOpen(currentSymbole,PERIOD_M15,i),",",iClose(currentSymbole,PERIOD_M15,i),",",iHigh(currentSymbole,PERIOD_M15,i),",",iLow(currentSymbole,PERIOD_M15,i));
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
   concat = StringConcatenate(Ask,",",Bid,",",((Ask + Bid)/2),",",spread,",",getChikouSpanM1(),",",getChikouSpanM5(),",",getChikouSpanM15(),",",getSpanM1(),",",getSpanM5(),",",getSpanM15(),",",getTekanM1(),",",getTekanM5(),",",getTekanM15(),",",getKijunM1(),",",getKijunM5(),",",getKijunM15(),",",getPriceM1(),",",getPriceM5(),",",getPriceM15());
   return concat;
}

////////////////////////////////////////////
//    Push Data into the file
////////////////////////////////////////////
void pushData()
{
      ResetLastError();
   if(filehandle != INVALID_HANDLE)
   {
      FileWrite(filehandle,concatenate());
   }
   else Print("Operation FileOpen failed, error ",GetLastError());
}