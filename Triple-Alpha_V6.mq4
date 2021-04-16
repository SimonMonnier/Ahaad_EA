//+------------------------------------------------------------------+
//|                                     Algorithme de Dani Demia.mq4 |
//|                                     Copyright 2021, Deeply Free. |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, Deeply Free."
#property link      ""
#property version   "1.00"
#property strict


//+------------------------------------------------------------------+
//| Global extern variable                            |
//+------------------------------------------------------------------+
extern double Lot = 0;

extern int slippage = 10 ;

extern int MagicNumber = 1618 ;

extern double takeProfitTradOneBuy = 0; 
extern double takeProfitTradTwoBuy = 0;
extern double takeProfitTradThreeBuy = 0;

extern double takeProfitTradOneSell = 0; 
extern double takeProfitTradTwoSell = 0;
extern double takeProfitTradThreeSell = 0;

extern double stopLossTradOneBuy = 0; 
extern double stopLossTradTwoBuy = 0;
extern double stopLossTradThreeBuy = 0;

extern double stopLossTradOneSell = 0; 
extern double stopLossTradTwoSell = 0;
extern double stopLossTradThreeSell = 0;

extern double updateStopLossTradTwoBuy = 0;
extern double firstUpdateStopLossTradThreeBuy = 0;
extern double secondeUpdateStopLossTradThreeBuy = 0;

extern double updateStopLossTradTwoSell = 0;
extern double firstUpdateStopLossTradThreeSell = 0;
extern double secondeUpdateStopLossTradThreeSell = 0;

extern double referencePriceForCheckStartTradBuy = 0;
extern double referencePriceForCheckStartTradSell = 0;

extern double maxSpread = 20;

double touchTakeProfitOneBuy = 0;
double touchTakeProfitTwoBuy = 0;
double touchTakeProfitThreeBuy = 0;

double touchTakeProfitOneSell = 0;
double touchTakeProfitTwoSell = 0;
double touchTakeProfitThreeSell = 0;

int currentPeriod = PERIOD_CURRENT;
string currentSymbole = Symbol();
   
double protectionOneShotBuy = false;
double protectionOneShotSell = false;
   
bool aboveTheReferencePriceBuy = false;
bool belowTheReferencePriceSell = false;
   
bool ioaNegatifBuy = false;
bool ioaPositifBuy = false;

bool ioaNegatifSell = false;
bool ioaPositifSell = false;

double checkEndOfdayBuy = 0;
double doubleCheckEndOfdayBuy = 0;

double checkEndOfdaySell = 0;
double doubleCheckEndOfdaySell = 0;

bool updateTradTwoAndThreeBuy = false;
bool updateTradThreeBuy = false;

bool updateTradTwoAndThreeSell = false;
bool updateTradThreeSell = false;

bool startFalseBuy = false;
bool startFalseSell = false;

int ok1 = -1;
int ok2 = -1;
int ok3 = -1;
int ok4 = -1;
int ok5 = -1;
int ok6 = -1;

double TickSize = 0;
double Points = 0;

double checkPingpongBuy = false;
double checkPingpongSell = false;

double alertSonoreBuy = false;
double alertSonoreSell = false;

double IAO0 = iAO(currentSymbole,currentPeriod,0);
double IAO1 = iAO(currentSymbole,currentPeriod,1);

bool freezeProtectionBuy1 = false;
bool freezeProtectionBuy2 = false;

bool freezeProtectionSell1 = false;
bool freezeProtectionSell2 = false;

double Spread = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   currentPeriod = PERIOD_CURRENT;
   currentSymbole = Symbol();
   
   protectionOneShotBuy = false;
   protectionOneShotSell = false;
   
   aboveTheReferencePriceBuy = false;
   belowTheReferencePriceSell = false;
   
   ioaNegatifBuy = false;
   ioaPositifBuy = false;
   
   ioaNegatifSell = false;
   ioaPositifSell = false;
   
   updateTradTwoAndThreeBuy = false;
   
   Print(MarketInfo(Symbol(), MODE_LOTSIZE));
   Print(MarketInfo(Symbol(), MODE_MINLOT));
   Print(MarketInfo(Symbol(), MODE_LOTSTEP));
   Print(MarketInfo(Symbol(), MODE_MAXLOT));
   TickSize = MarketInfo (Symbol(),MODE_TICKSIZE);
   Spread = MarketInfo(Symbol(), MODE_SPREAD);


   if (TickSize == 0.00001 || TickSize == 0.001 )
   {
      Points = TickSize;
   }
   else Points = TickSize;
   
   IAO0 = iAO(currentSymbole,currentPeriod,0);
   IAO1 = iAO(currentSymbole,currentPeriod,1);
   
   buyButtonCreate();
   sellButtonCreate();
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
      ObjectsDeleteAll(0,OBJ_BUTTON);
      ObjectsDeleteAll(0,OBJ_BUTTON);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
      IAO0 = iAO(currentSymbole,currentPeriod,0);
      IAO1 = iAO(currentSymbole,currentPeriod,1);
         
      checkForBuy();
      checkForUpdateTradTwoAndThreeBuy();
      checkForUpdateTradThreeBuy();
         
      checkForSell();
      checkForUpdateTradTwoAndThreeSell();
      checkForUpdateTradThreeSell();
  }
 
 
void buyButtonCreate()
{
   ObjectCreate(currentSymbole,"BuyButton",OBJ_BUTTON,0,0,0);
   ObjectSetInteger(currentSymbole,"BuyButton", OBJPROP_XDISTANCE,10);
   ObjectSetInteger(currentSymbole,"BuyButton", OBJPROP_XSIZE,100);
   ObjectSetInteger(currentSymbole,"BuyButton", OBJPROP_YDISTANCE,120);
   ObjectSetInteger(currentSymbole,"BuyButton", OBJPROP_YSIZE,50);
   ObjectSetInteger(currentSymbole,"BuyButton", OBJPROP_CORNER,2);
   ObjectSetInteger(_Symbol,"BuyButton", OBJPROP_COLOR,Blue);
   ObjectSetString(currentSymbole,"BuyButton", OBJPROP_TEXT,"OneShot Buy");
}
 

void sellButtonCreate()
{
   ObjectCreate(currentSymbole,"SellButton",OBJ_BUTTON,0,0,0);
   ObjectSetInteger(currentSymbole,"SellButton", OBJPROP_XDISTANCE,10);
   ObjectSetInteger(currentSymbole,"SellButton", OBJPROP_XSIZE,100);
   ObjectSetInteger(currentSymbole,"SellButton", OBJPROP_YDISTANCE,60);
   ObjectSetInteger(currentSymbole,"SellButton", OBJPROP_YSIZE,50);
   ObjectSetInteger(currentSymbole,"SellButton", OBJPROP_CORNER,2);
   ObjectSetInteger(currentSymbole,"SellButton", OBJPROP_COLOR,Red);
   ObjectSetString(currentSymbole,"SellButton", OBJPROP_TEXT,"OneShot Sell");
}


void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   if(id == CHARTEVENT_OBJECT_CLICK)
   {
      if(sparam == "BuyButton" && protectionOneShotBuy == false)
      {
         Comment("OneShot Buy button was pressed !");
         protectionOneShotBuy = true;
      
         int i = 0;
         int j = 0;
         int k = 0;    
      
         while (i < 1)
         {
            touchTakeProfitOneBuy = takeProfitTradOneBuy;
         
            ok1 = OrderSend (currentSymbole,OP_BUY,Lot,Ask,slippage,Ask-(stopLossTradOneBuy*Points),Ask+(takeProfitTradOneBuy*Points),"Trad One",MagicNumber,0,Blue);
            if (ok1 > -1 && i < 1)
            {
               i++;
            }
         }
      
         while (j < 1)
         {
            touchTakeProfitTwoBuy = takeProfitTradTwoBuy;
         
            ok2 = OrderSend (currentSymbole,OP_BUY,Lot,Ask,slippage,Ask-(stopLossTradTwoBuy*Points),Ask+(takeProfitTradTwoBuy*Points),"Trad Two",MagicNumber,0,Blue);
            if (ok2 > -1 && j < 1)
            {
               j++;
            }
         }
      
         while (k < 1)
         {
            touchTakeProfitThreeBuy = takeProfitTradThreeBuy;
         
            ok3 = OrderSend (currentSymbole,OP_BUY,Lot,Ask,slippage,Ask-(stopLossTradThreeBuy*Points),Ask+(takeProfitTradThreeBuy*Points),"Trad Three",MagicNumber,0,Blue);
            if (ok3 > -1 && k < 1)
            {
               k++;
            }
         }
      }
      
      else if(sparam == "SellButton" && protectionOneShotSell == false)
      {
         Comment("OneShot Sell button was pressed !");
         protectionOneShotSell = true;
      
         int i = 0;
         int j = 0;
         int k = 0;    
      
         while (i < 1)
         {
            touchTakeProfitOneSell = takeProfitTradOneSell;
         
            ok4 = OrderSend (currentSymbole,OP_SELL,Lot,Bid,slippage,Bid+(stopLossTradOneSell*Points),Bid-(takeProfitTradOneSell*Points),"Trad One",MagicNumber,0,Red);
            if (ok4 > -1 && i < 1)
            {
               i++;
            }
         }
      
         while (j < 1)
         {
            touchTakeProfitTwoSell = takeProfitTradTwoSell;
         
            ok5 = OrderSend (currentSymbole,OP_SELL,Lot,Bid,slippage,Bid+(stopLossTradTwoSell*Points),Bid-(takeProfitTradTwoSell*Points),"Trad Two",MagicNumber,0,Red);
            if (ok5 > -1 && j < 1)
            {
               j++;
            }
         }
      
         while (k < 1)
         {
            touchTakeProfitThreeSell = takeProfitTradThreeSell;
         
            ok6 = OrderSend (currentSymbole,OP_SELL,Lot,Bid,slippage,Bid+(stopLossTradThreeSell*Points),Bid-(takeProfitTradThreeSell*Points),"Trad Three",MagicNumber,0,Red);
            if (ok6 > -1 && k < 1)
            {
               k++;
            }
         }
      }
   }
}
 
 
//+------------------------------------------------------------------+
//| checkForBuy function                                             |
//+------------------------------------------------------------------+
void checkForBuy()
{
   Spread = MarketInfo(Symbol(), MODE_SPREAD);
   
   if(((Bid <= referencePriceForCheckStartTradBuy) && aboveTheReferencePriceBuy == true && protectionOneShotBuy == false && checkPingpongBuy == true && startFalseBuy == false)
      || (aboveTheReferencePriceBuy == true && IAO0 < 0 && protectionOneShotBuy == false && Bid > referencePriceForCheckStartTradBuy && checkPingpongBuy == true && startFalseBuy == false))
   {
      aboveTheReferencePriceBuy = false;
      ioaNegatifBuy = false;
      ioaPositifBuy = false;
      updateTradTwoAndThreeBuy = false;
      updateTradThreeBuy = false;
      startFalseBuy = true;
      checkPingpongBuy = false;
      alertSonoreBuy = false;
      startFalseBuy = true;
      Comment("L'Oscillateur est repassé une deuxième fois en négatif !!! Annulation process Buy, attente prochain cycle !!!");
   }
   
   if(Bid > referencePriceForCheckStartTradBuy && protectionOneShotBuy == false && IAO0 > 0)
   {
      aboveTheReferencePriceBuy = true;
   }
   
   if(aboveTheReferencePriceBuy == true && IAO0 < 0 && protectionOneShotBuy == false && Bid > referencePriceForCheckStartTradBuy)
   {
      ioaNegatifBuy = true;
   }
   
   if(Bid > referencePriceForCheckStartTradBuy && protectionOneShotBuy == false && ioaNegatifBuy == true && IAO0 > 0)
   {
      checkPingpongBuy = true;
      Comment("L'Oscillateur est passé de positif à négatif puis de nouveau positif !!! Attente de la validation positive de l'Oscillateur à la cloture !!! Attente de validation de l'Oscillateur en positif à la cloture pour Buy!!!");
   }
   
   if(aboveTheReferencePriceBuy == true && IAO0 > 0 && Bid > referencePriceForCheckStartTradBuy && ioaNegatifBuy == true && protectionOneShotBuy == false && checkPingpongBuy == true && alertSonoreBuy == false)
   {
      PlaySound("alert.wav");
      Comment("Attente de validation de l'Oscillateur en positif à la cloture pour Buy !!!");
      ioaPositifBuy = true;
      checkEndOfdayBuy = Open[0];
      doubleCheckEndOfdayBuy = Open[1];
      alertSonoreBuy = true;
   }
   
   if(aboveTheReferencePriceBuy == true && Bid > referencePriceForCheckStartTradBuy
      && ioaNegatifBuy == true && ioaPositifBuy == true && checkEndOfdayBuy == Open[1] && checkHistoryForBuy() == true
      && doubleCheckEndOfdayBuy == Open[2] && IAO1 > 0 && protectionOneShotBuy == false && checkPingpongBuy == true && alertSonoreBuy == true && Spread < maxSpread)
   {
      protectionOneShotBuy = true;
      
      int i = 0;
      int j = 0;
      int k = 0;    
      
      while (i < 1)
      {
         touchTakeProfitOneBuy = takeProfitTradOneBuy;
         
         ok1 = OrderSend (currentSymbole,OP_BUY,Lot,Ask,slippage,Ask-(stopLossTradOneBuy*Points),Ask+(takeProfitTradOneBuy*Points),"Trad One",MagicNumber,0,Blue);
         if (ok1 > -1 && i < 1)
         {
            i++;
         }
      }
      
      while (j < 1)
      {
         touchTakeProfitTwoBuy = takeProfitTradTwoBuy;
         
         ok2 = OrderSend (currentSymbole,OP_BUY,Lot,Ask,slippage,Ask-(stopLossTradTwoBuy*Points),Ask+(takeProfitTradTwoBuy*Points),"Trad Two",MagicNumber,0,Blue);
         if (ok2 > -1 && j < 1)
         {
            j++;
         }
      }
      
      while (k < 1)
      {
         touchTakeProfitThreeBuy = takeProfitTradThreeBuy;
         
         ok3 = OrderSend (currentSymbole,OP_BUY,Lot,Ask,slippage,Ask-(stopLossTradThreeBuy*Points),Ask+(takeProfitTradThreeBuy*Points),"Trad Three",MagicNumber,0,Blue);
         if (ok3 > -1 && k < 1)
         {
            k++;
         }
      }
   }
   
   if(startFalseBuy == true && checkEndOfdayBuy == Open[1] && doubleCheckEndOfdayBuy == Open[2])
   {
      startFalseBuy = false;
   }
}


//+------------------------------------------------------------------+
//| checkForSell function                                            |
//+------------------------------------------------------------------+
void checkForSell()
{
   Spread = MarketInfo(Symbol(), MODE_SPREAD);
   
   if((Ask >= referencePriceForCheckStartTradSell && belowTheReferencePriceSell == true && protectionOneShotSell == false && checkPingpongSell == true && startFalseSell == false)
      || (belowTheReferencePriceSell == true && IAO0 > 0 && protectionOneShotSell == false && Ask < referencePriceForCheckStartTradSell && checkPingpongSell == true && startFalseSell == false))
   {
      belowTheReferencePriceSell = false;
      ioaNegatifSell = false;
      ioaPositifSell = false;
      updateTradTwoAndThreeSell = false;
      updateTradThreeSell = false;
      startFalseSell = true;
      checkPingpongSell = false;
      alertSonoreSell = false;
      
      Comment("L'Oscillateur est repassé une deuxième fois en positif !!! Annulation process Sell, attente prochain cycle !!!");
   }
   
   if(Ask < referencePriceForCheckStartTradSell && protectionOneShotSell == false && IAO0 < 0)
   {
      belowTheReferencePriceSell = true;
      
   }
   
   if(belowTheReferencePriceSell == true && IAO0 > 0 && protectionOneShotSell == false && Ask < referencePriceForCheckStartTradSell)
   {
      ioaNegatifSell = true;
   }
   
   if(Ask < referencePriceForCheckStartTradSell && protectionOneShotSell == false && ioaNegatifSell == true && IAO0 < 0)
   {
      checkPingpongSell = true;
      Comment("L'Oscillateur est passé de négatif à positif puis de nouveau négatif !!! Attente de la validation négative de l'Oscillateur à la cloture !!! Attente de validation de l'Oscillateur en négatif à la cloture pour Sell!!!");
   }
   
   if(belowTheReferencePriceSell == true && IAO0 < 0 && Ask < referencePriceForCheckStartTradSell && ioaNegatifSell == true && protectionOneShotSell == false && checkPingpongSell == true && alertSonoreSell == false)
   {
      PlaySound("alert.wav");
      Comment("Attente de validation de l'Oscillateur en négatif à la cloture pour Sell!!!");
      ioaPositifSell = true;
      checkEndOfdaySell = Open[0];
      doubleCheckEndOfdaySell = Open[1];
      alertSonoreSell = true;
   }
   
   if(belowTheReferencePriceSell == true && Ask < referencePriceForCheckStartTradSell
      && ioaNegatifSell == true && ioaPositifSell == true && checkEndOfdaySell == Open[1] && checkHistoryForSell() == true
      && doubleCheckEndOfdaySell == Open[2] && IAO1 < 0 && protectionOneShotSell == false && checkPingpongSell == true && alertSonoreSell == true && Spread < maxSpread)
   {
      protectionOneShotSell = true;
      
      int i = 0;
      int j = 0;
      int k = 0;    
      
      while (i < 1)
      {
         touchTakeProfitOneSell = takeProfitTradOneSell;
         
         ok4 = OrderSend (currentSymbole,OP_SELL,Lot,Bid,slippage,Bid+(stopLossTradOneSell*Points),Bid-(takeProfitTradOneSell*Points),"Trad One",MagicNumber,0,Red);
         if (ok4 > -1 && i < 1)
         {
            i++;
         }
      }
      
      while (j < 1)
      {
         touchTakeProfitTwoSell = takeProfitTradTwoSell;
         
         ok5 = OrderSend (currentSymbole,OP_SELL,Lot,Bid,slippage,Bid+(stopLossTradTwoSell*Points),Bid-(takeProfitTradTwoSell*Points),"Trad Two",MagicNumber,0,Red);
         if (ok5 > -1 && j < 1)
         {
            j++;
         }
      }
      
      while (k < 1)
      {
         touchTakeProfitThreeSell = takeProfitTradThreeSell;
         
         ok6 = OrderSend (currentSymbole,OP_SELL,Lot,Bid,slippage,Bid+(stopLossTradThreeSell*Points),Bid-(takeProfitTradThreeSell*Points),"Trad Three",MagicNumber,0,Red);
         if (ok6 > -1 && k < 1)
         {
            k++;
         }
      }
   }
   
   if(startFalseSell == true && checkEndOfdaySell == Open[1] && doubleCheckEndOfdaySell == Open[2])
   {
      startFalseSell = false;
   }
}


//+------------------------------------------------------------------+
//| checkForUpdateTradTwoAndThreeBuy function                        |
//+------------------------------------------------------------------+
void checkForUpdateTradTwoAndThreeBuy()
{
   double currentPrice=(Ask+Bid)/2;
   string value = DoubleToStr(currentPrice,Digits);
   currentPrice = StrToDouble(value);
   
   bool go = false;
   bool stopProcess = false;

   
   if (protectionOneShotBuy == true && updateTradTwoAndThreeBuy == false)
   {
      bool selectOneOk = false;
      int h = 0;
      while(h < 1)
      {
         selectOneOk = OrderSelect(ok2,SELECT_BY_TICKET);
         if(selectOneOk == true)
         {
            h++;
            selectOneOk = false;
         }
      }
      go = true;
   }
   
   if ((Bid <= OrderOpenPrice() - (stopLossTradOneBuy * Points) || Bid <= OrderOpenPrice() - (stopLossTradTwoBuy * Points) || Bid <= OrderOpenPrice() - (stopLossTradThreeBuy * Points) || Bid <= OrderOpenPrice() - (firstUpdateStopLossTradThreeBuy * Points)
      || Bid <= OrderOpenPrice() - (secondeUpdateStopLossTradThreeBuy * Points)) && stopProcess == false && protectionOneShotBuy == true)
   {
      stopProcess = true;
   }
   
   if(Bid >= OrderOpenPrice() + (touchTakeProfitOneBuy * Points) && protectionOneShotBuy == true && updateTradTwoAndThreeBuy == false && go == true 
      && freezeProtectionBuy1 == false && stopProcess == false && OrdersTotal() > 0)
   {
      bool selectTwoOk = false;
      int j = 0;
      while(j < 1)
      {
         selectTwoOk = OrderSelect(ok2,SELECT_BY_TICKET);
         if(selectTwoOk == true)
         {
            j++;
            selectTwoOk = false;
         }
      }
      if (OrderType() == OP_BUY)
      {
         if (updateStopLossTradTwoBuy == stopLossTradTwoBuy)
         {
            updateStopLossTradTwoBuy = NormalizeDouble(currentPrice - ((updateStopLossTradTwoBuy * Points) + (1 * Points)),Digits);
         }
         else
         {
            updateStopLossTradTwoBuy = NormalizeDouble(currentPrice - (updateStopLossTradTwoBuy * Points),Digits);
         }
         
         printf("Update trad two !!!!!");
         
         updateTradTwoAndThreeBuy = true;
         bool res1 = false;
         int i = 0;
         while(i < 1)
         {
            res1 = OrderModify(OrderTicket(),OrderOpenPrice(),updateStopLossTradTwoBuy,OrderTakeProfit(),0,Orange);
            if(res1 == true)
            {
               i++;
               res1 = false;
            }
         }
      }
      
      bool selectThreeOk = false;
      int k = 0;
      while(k < 1)
      {
         selectThreeOk = OrderSelect(ok3,SELECT_BY_TICKET);
         if(selectThreeOk == true)
         {
            k++;
            selectThreeOk = false;
         }
      }
      
      if (OrderType() == OP_BUY)
      {
         printf("Update trad three !!!!!");
         
         if (firstUpdateStopLossTradThreeBuy == stopLossTradThreeBuy)
         {
            firstUpdateStopLossTradThreeBuy = NormalizeDouble(currentPrice - (firstUpdateStopLossTradThreeBuy * Points) + (1 * Points),Digits);
         }
         else
         {
            firstUpdateStopLossTradThreeBuy = NormalizeDouble(currentPrice - (firstUpdateStopLossTradThreeBuy * Points),Digits);
         }
         
         bool res2 = false;
         int l = 0;
         while(l < 1)
         {
            res2 = OrderModify(OrderTicket(),OrderOpenPrice(),firstUpdateStopLossTradThreeBuy,OrderTakeProfit(),0,Red);
            if(res2 == true)
            {
               l++;
               res2 = false;
            }
         }
      }
      freezeProtectionBuy1 = true;
   }
}


//+------------------------------------------------------------------+
//| checkForUpdateTradThreeBuy function                              |
//+------------------------------------------------------------------+
void checkForUpdateTradThreeBuy()
{
   double currentPrice=(Ask+Bid)/2;
   string value = DoubleToStr(currentPrice,Digits);
   currentPrice = StrToDouble(value);
   
   bool go = false;
   bool stopProcess = false;
   
   if (protectionOneShotBuy == true && updateTradTwoAndThreeBuy == true && updateTradThreeBuy == false && stopProcess == false)
   {
      bool selectTwoOk = false;
      int g = 0;
      while(g < 1)
      {
         selectTwoOk = OrderSelect(ok2,SELECT_BY_TICKET);
         if(selectTwoOk == true)
         {
            g++;
            selectTwoOk = false;
         }
      }
      go = true;
   }
   
   if ((Bid <= OrderOpenPrice() - (stopLossTradOneBuy * Points) || Bid <= OrderOpenPrice() - (stopLossTradTwoBuy * Points) || Bid <= OrderOpenPrice() - (stopLossTradThreeBuy * Points) || Bid <= OrderOpenPrice() - (firstUpdateStopLossTradThreeBuy * Points)
      || Bid <= OrderOpenPrice() - (secondeUpdateStopLossTradThreeBuy * Points)) && stopProcess == false && protectionOneShotBuy == true)
   {
      stopProcess = true;
   }
      
   if(Bid >= OrderOpenPrice() + (touchTakeProfitTwoBuy * Points) && protectionOneShotBuy == true && updateTradTwoAndThreeBuy == true && updateTradThreeBuy == false && go == true
      && freezeProtectionBuy2 == false && stopProcess == false && OrdersTotal() > 0)
   {
      bool selectThreeOk = false;
      int i = 0;
      while(i < 1)
      {
         selectThreeOk = OrderSelect(ok3,SELECT_BY_TICKET);
         if(selectThreeOk == true)
         {
             i++;
             selectThreeOk = false;
         }
      }
      if (OrderType() == OP_BUY)
      {
         printf("Update trad three for second cycle !!!!!");
         if (secondeUpdateStopLossTradThreeBuy == firstUpdateStopLossTradThreeBuy)
         {
            secondeUpdateStopLossTradThreeBuy = NormalizeDouble(currentPrice - (secondeUpdateStopLossTradThreeBuy * Points) + (1 * Points),Digits);
         }
         else
         {
            secondeUpdateStopLossTradThreeBuy = NormalizeDouble(currentPrice - (secondeUpdateStopLossTradThreeBuy * Points),Digits);
         }
         updateTradThreeBuy = true;
      
         bool res2 = false;
         int j = 0;
         while(j < 1)
         {
            res2 = OrderModify(OrderTicket(),OrderOpenPrice(),secondeUpdateStopLossTradThreeBuy,OrderTakeProfit(),0,Red);
            if(res2 == true)
            {
               j++;
               res2 = false;
            }
         }
         aboveTheReferencePriceBuy = false;
         ioaNegatifBuy = false;
         ioaPositifBuy = false;
         updateTradTwoAndThreeBuy = false;
         updateTradThreeBuy = false;
         freezeProtectionBuy2 = true;
      }
   }
}


//+------------------------------------------------------------------+
//| checkForUpdateTradTwoAndThreeSell function                       |
//+------------------------------------------------------------------+
void checkForUpdateTradTwoAndThreeSell()
{
   double currentPrice=(Ask+Bid)/2;
   string value = DoubleToStr(currentPrice,Digits);
   currentPrice = StrToDouble(value);
   
   bool go = false;
   bool stopProcess = false;
   
   if (protectionOneShotSell == true && updateTradTwoAndThreeSell == false)
   {
      bool selectOneOk = false;
      int h = 0;
      while(h < 1)
      {
         selectOneOk = OrderSelect(ok5,SELECT_BY_TICKET);
         if(selectOneOk == true)
         {
            h++;
            selectOneOk = false;
         }
      }
      go = true;
   }
   
   if ((Ask >= OrderOpenPrice() + (stopLossTradOneSell * Points) || Ask >= OrderOpenPrice() + (stopLossTradTwoSell * Points) || Ask >= OrderOpenPrice() + (stopLossTradThreeSell * Points) || Ask >= OrderOpenPrice() + (firstUpdateStopLossTradThreeSell * Points)
      || Ask >= OrderOpenPrice() + (secondeUpdateStopLossTradThreeSell * Points)) && stopProcess == false && protectionOneShotSell == true)
   {
      stopProcess = true;
   }
   
   if(Ask <= OrderOpenPrice() - (touchTakeProfitOneSell * Points) && protectionOneShotSell == true && updateTradTwoAndThreeSell == false
      && go == true && freezeProtectionSell1 == false && stopProcess == false && OrdersTotal() > 0)
   {
      bool selectTwoOk = false;
      int j = 0;
      while(j < 1)
      {
         selectTwoOk = OrderSelect(ok5,SELECT_BY_TICKET);
         if(selectTwoOk == true)
         {
            j++;
            selectTwoOk = false;
         }
      }
      if (OrderType() == OP_SELL)
      {
         if (updateStopLossTradTwoSell == stopLossTradTwoSell)
         {
            updateStopLossTradTwoSell = NormalizeDouble(currentPrice + ((updateStopLossTradTwoSell * Points) + (1 * Points)),Digits);
         }
         else
         {
            updateStopLossTradTwoSell = NormalizeDouble(currentPrice + (updateStopLossTradTwoSell * Points),Digits);
         }
         
        
         printf("Update trad two !!!!!");
         
         updateTradTwoAndThreeSell = true;
         bool res1 = false;
         int i = 0;
         while(i < 1)
         {
            res1 = OrderModify(OrderTicket(),OrderOpenPrice(),updateStopLossTradTwoSell,OrderTakeProfit(),0,Orange);
            if(res1 == true)
            {
               i++;
               res1 = false;
            }
         }
      }
      
      bool selectThreeOk = false;
      int k = 0;
      while(k < 1)
      {
         selectThreeOk = OrderSelect(ok6,SELECT_BY_TICKET);
         if(selectThreeOk == true)
         {
            k++;
            selectThreeOk = false;
         }
      }
      if (OrderType() == OP_SELL)
      {
         printf("Update trad three !!!!!");
         if (firstUpdateStopLossTradThreeSell == stopLossTradThreeSell)
         {
            firstUpdateStopLossTradThreeSell = NormalizeDouble(currentPrice + (firstUpdateStopLossTradThreeSell * Points) + (1 * Points),Digits);
         }
         else
         {
            firstUpdateStopLossTradThreeSell = NormalizeDouble(currentPrice + (firstUpdateStopLossTradThreeSell * Points),Digits);
         }
         
         
         double OpenPrice = OrderOpenPrice();
         bool res2 = false;
         int l = 0;
         while(l < 1)
         {
            res2 = OrderModify(OrderTicket(),OrderOpenPrice(),firstUpdateStopLossTradThreeSell,OrderTakeProfit(),0,Red);
            
            if(res2 == true)
            {
               l++;
               res2 = false;
            }
         }
      }
      freezeProtectionSell1 = true;
   }
}


//+------------------------------------------------------------------+
//| checkForUpdateTradThreeSell function                             |
//+------------------------------------------------------------------+
void checkForUpdateTradThreeSell()
{
   double currentPrice=(Ask+Bid)/2;
   string value = DoubleToStr(currentPrice,Digits);
   currentPrice = StrToDouble(value);
   
   bool go = false;
   bool stopProcess = false;
   
   if (protectionOneShotSell == true && updateTradTwoAndThreeSell == true && updateTradThreeSell == false)
   {
      bool selectTwoOk = false;
      int g = 0;
      while(g < 1)
      {
         selectTwoOk = OrderSelect(ok6,SELECT_BY_TICKET);
         if(selectTwoOk == true)
         {
            g++;
            selectTwoOk = false;
         }
      }
      go = true;
   }
   
   if ((Ask >= OrderOpenPrice() + (stopLossTradOneSell * Points) || Ask >= OrderOpenPrice() + (stopLossTradTwoSell * Points) || Ask >= OrderOpenPrice() + (stopLossTradThreeSell * Points) || Ask >= OrderOpenPrice() + (firstUpdateStopLossTradThreeSell * Points)
      || Ask >= OrderOpenPrice() + (secondeUpdateStopLossTradThreeSell * Points)) && stopProcess == false && protectionOneShotSell == true)
   {
      stopProcess = true;
   }
      
   if(Ask <= OrderOpenPrice() - (touchTakeProfitTwoSell * Points) && protectionOneShotSell == true && updateTradTwoAndThreeSell == true && updateTradThreeSell == false 
      && go == true && freezeProtectionSell2 == false && stopProcess == false && OrdersTotal() > 0)
   {
      bool selectThreeOk = false;
      int i = 0;
      while(i < 1)
      {
         selectThreeOk = OrderSelect(ok6,SELECT_BY_TICKET);
         if(selectThreeOk == true)
         {
             i++;
             selectThreeOk = false;
         }
      }
      if (OrderType() == OP_SELL)
      {
         printf("Update trad three for second cycle !!!!!");
         if (secondeUpdateStopLossTradThreeSell == firstUpdateStopLossTradThreeSell)
         {
            secondeUpdateStopLossTradThreeSell = NormalizeDouble(currentPrice + (secondeUpdateStopLossTradThreeSell * Points) + (1 * Points),Digits);
         }
         else
         {
            secondeUpdateStopLossTradThreeSell = NormalizeDouble(currentPrice + (secondeUpdateStopLossTradThreeSell * Points),Digits);
         }
         updateTradThreeSell = true;
      
         bool res2 = false;
         int j = 0;
         while(j < 1)
         {
            res2 = OrderModify(OrderTicket(),OrderOpenPrice(),secondeUpdateStopLossTradThreeSell,OrderTakeProfit(),0,Red);

            if(res2 == true)
            {
               j++;
               res2 = false;
            }
         }
         belowTheReferencePriceSell = false;
         ioaNegatifSell = false;
         ioaPositifSell = false;
         updateTradTwoAndThreeSell = false;
         updateTradThreeSell = false;
         freezeProtectionSell2 = true;
      }
   }
}

bool checkHistoryForSell()
{
   int c = 4;
   bool check = false;
   while (iAO(currentSymbole,currentPeriod,c) > 0)
   {
      if(High[c] < referencePriceForCheckStartTradSell)
      {
         check = true;
      }
      else if(High[c] > referencePriceForCheckStartTradSell)
      {
         check = false;
      }
      c++;
   }
   if (check == true)
   {
      Comment("Le Chlick-Chlak n'a pas dépassé le prix de réfèrence !!! Confirmation du OneShot Sell !!!");
   }
   else if (check == false)
   {
      Comment("Le Chlick-Chlak a pas dépassé le prix de réfèrence !!! Annulation du OneShot Sell !!!");
   }
   return check;
}

bool checkHistoryForBuy()
{
   int c = 4;
   bool check = false;
   while (iAO(currentSymbole,currentPeriod,c) < 0)
   {
      if(High[c] > referencePriceForCheckStartTradSell)
      {
         check = true;
      }
      else if(High[c] < referencePriceForCheckStartTradSell)
      {
         check = false;
      }
      c++;
   }
   if (check == true)
   {
      Comment("Le Chlick-Chlak n'a pas dépassé le prix de réfèrence !!! Confirmation du OneShot Buy !!!");
   }
   else if (check == false)
   {
      Comment("Le Chlick-Chlak a pas dépassé le prix de réfèrence !!! Annulation du OneShot Buy !!!");
   }
   return check;
}