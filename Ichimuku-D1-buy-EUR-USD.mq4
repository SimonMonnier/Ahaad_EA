//+------------------------------------------------------------------+
//|                                                        EARSI.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
// Logique 
// Si RSI1>30 et RSI2<30 
// Si order lancé par le EA = 0 
// ------> Order d'achat .
// Si RSI1<70 et RSI2>70 
// Si order lancé par le EA = 0 
// ------> Order de vente .

extern int slippage = 10 ;
extern int MagicNumber = 4321 ;
extern double Lot = 0.1 ;
int signUp = 0;

int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
     
     double SPANB4 = iIchimoku (Symbol(),0,9,26,52,MODE_SENKOUSPANB,4);
     double SPANA4 = iIchimoku (Symbol(),0,9,26,52,MODE_SENKOUSPANA,4);
     double SPANB5 = iIchimoku (Symbol(),0,9,26,52,MODE_SENKOUSPANB,5);
     double SPANA5 = iIchimoku (Symbol(),0,9,26,52,MODE_SENKOUSPANA,5);
     double SPANB1 = iIchimoku (Symbol(),0,9,26,52,MODE_SENKOUSPANB,1);
     double SPANA1 = iIchimoku (Symbol(),0,9,26,52,MODE_SENKOUSPANA,1);
     double SPANB2 = iIchimoku (Symbol(),0,9,26,52,MODE_SENKOUSPANB,2);
     double SPANA2 = iIchimoku (Symbol(),0,9,26,52,MODE_SENKOUSPANA,2);
     double SPANB3 = iIchimoku (Symbol(),0,9,26,52,MODE_SENKOUSPANB,3);
     double SPANA3 = iIchimoku (Symbol(),0,9,26,52,MODE_SENKOUSPANA,3);
     double SPANB11 = iIchimoku (Symbol(),0,9,26,52,MODE_SENKOUSPANB,11);
     double SPANA11 = iIchimoku (Symbol(),0,9,26,52,MODE_SENKOUSPANA,11);
     
     double TEKAN0 = iIchimoku (Symbol(),0,9,26,52,MODE_TENKANSEN,0);
     double TEKAN1 = iIchimoku (Symbol(),0,9,26,52,MODE_TENKANSEN,1);
     double TEKAN2 = iIchimoku (Symbol(),0,9,26,52,MODE_TENKANSEN,2);
     double TEKAN3 = iIchimoku (Symbol(),0,9,26,52,MODE_TENKANSEN,3);
     double TEKAN4 = iIchimoku (Symbol(),0,9,26,52,MODE_TENKANSEN,4);
     double TEKAN5 = iIchimoku (Symbol(),0,9,26,52,MODE_TENKANSEN,5);
     double TEKAN6 = iIchimoku (Symbol(),0,9,26,52,MODE_TENKANSEN,6);
     double TEKAN7 = iIchimoku (Symbol(),0,9,26,52,MODE_TENKANSEN,7);
     double TEKAN8 = iIchimoku (Symbol(),0,9,26,52,MODE_TENKANSEN,8);
     double TEKAN9 = iIchimoku (Symbol(),0,9,26,52,MODE_TENKANSEN,9);
     double TEKAN11 = iIchimoku (Symbol(),0,9,26,52,MODE_TENKANSEN,11);
     double TEKAN33 = iIchimoku (Symbol(),0,9,26,52,MODE_TENKANSEN,33);
     double KIJUN1 = iIchimoku (Symbol(),0,9,26,52,MODE_KIJUNSEN,1);
     double KIJUN2 = iIchimoku (Symbol(),0,9,26,52,MODE_KIJUNSEN,2);
     double KIJUN3 = iIchimoku (Symbol(),0,9,26,52,MODE_KIJUNSEN,3);
     double KIJUN4 = iIchimoku (Symbol(),0,9,26,52,MODE_KIJUNSEN,4);
     
     double SL = 0 ;
     double TP = 0 ;
     
      if ((Low[1] - SPANA1) > 0.01500 && Low[1] > SPANB1 && Open[0] < Close[1] && (Low[0] - TEKAN0) < 0.02000 && (Low[1] - TEKAN1) > 0.00250 && signUp == 0 && OrdersTotal() == 1)
      {
         if (SPANB3 < TEKAN3 && SPANA3 < TEKAN3 && SPANB2 < TEKAN2 && SPANA2 < TEKAN2)
         {
            signUp = 9;
            Print(signUp);
         }
         else
         {
            closeOrder();
            Print(signUp);
         } 
      }
      
      if (signUp == 9)
      {
         if (KIJUN1 > TEKAN1 && KIJUN2 > TEKAN2 && KIJUN3 > TEKAN3 && Close[1] < KIJUN1 && Close[2] < KIJUN2 && Close[3] < KIJUN3 && Close[4] < KIJUN4 && Low[1] > SPANA1 && Low[1] > SPANB1)
         {
            closeOrder();
            Print(signUp);
         }
      }
  
     if ( (TEKAN11 < SPANA11 || TEKAN11 < SPANB11) && SPANB4 > Low[4] && SPANB5 > Low[5] 
         && (Low[5]-0.00050) < TEKAN5 && (Close[4] < TEKAN4 || Open[5] < TEKAN5) && (Low[4]-0.00050) < TEKAN4 && High[5] > TEKAN5 
         && High[4] > TEKAN4 && High[0] > High[1] && High[0] < TEKAN0 && High[2] < (TEKAN2 + 0.00050) && High[1] < TEKAN1
         && Close[1] < SPANB1 && Close[1] < TEKAN1 && Close[2] < SPANB1 && Close[2] < TEKAN2 && High[3] > TEKAN3 && OrdersTotal() == 0 )
     {
        OrderSend (Symbol(),OP_BUY,Lot,Ask,slippage,SL,TP,NULL,MagicNumber,0,Green);
     }  
} 

void closeOrder()
{
   signUp = 0;
   int total = OrdersTotal();
   for(int i=total-1; i>=0; i--)
   {
     int  ticket = OrderSelect(i,SELECT_BY_POS);
     bool result = OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),3,clrNONE);
            
   }
}