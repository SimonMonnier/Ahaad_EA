#property copyright ""
#property link      ""
#property version   ""
#property strict

//+-----------------------------------------------------------------------+
//| Extern global variable                                                |
//+-----------------------------------------------------------------------+
extern int slippage = 10 ;
extern int MagicNumber = 1618 ;



//+-----------------------------------------------------------------------+
//| global variable                                                       |
//+-----------------------------------------------------------------------+
double Lot = 0.01 ;

int currentPeriod = 0;
string currentSymbole = "";
   
double SL = 0 ;
double TP = 0 ;

extern int signUp = 0;
int VerifOk = 0;
double OpenOderValue = 0;
int total = 0;
double solde = 0;

bool upOne = false;
bool upTwo = false;
bool upThree = false;

double UpUpUp = 0;
bool closeOk = false;

int firstTrad = 0;
int secondTrad = 0;
int protectionCloseTrad1 = 0;
int protectionCloseTrad2 = 0;

double lastSolde = 0;

double longTime = 0;

double selectDiff50 = 0;
double selectDiff100 = 0;
double selectDiff150 = 0;
double selectDiff190 = 0;
double selectDiff200 = 0;
double selectDiff250 = 0;
double selectDiff300 = 0;
double selectDiff500 = 0;
double selectDiff1000 = 0;
double selectDiff1500 = 0;
double selectDiff2000 = 0;
double selectDiff4000 = 0;
double selectDiff5000 = 0;
double selectDiff10000 = 0;
double selectDiff15000 = 0;
double selectDiff35000 = 0;

double CHIKOUSPAN29 = 0;
double CHIKOUSPAN30 = 0;
double CHIKOUSPAN34 = 0;
double CHIKOUSPAN39 = 0;
double CHIKOUSPAN46 = 0;
double CHIKOUSPAN35 = 0;
double CHIKOUSPAN37 = 0;
double CHIKOUSPAN161 = 0;

double PINGPONGKENJU1 = 0;
double PINGPONGKENJU2 = 0;
     
double SPANB0 = 0;
double SPANA0 = 0;
double SPANB1 = 0;
double SPANA1 = 0;
double SPANB2 = 0;
double SPANA2 = 0;
double SPANB3 = 0;
double SPANA3 = 0;
double SPANB4 = 0;
double SPANA4 = 0;
double SPANB5 = 0;
double SPANA5 = 0;
double SPANB6 = 0;
double SPANA6 = 0;
double SPANB7 = 0;
double SPANA7 = 0;
double SPANB10 = 0;
double SPANA10 = 0;
double SPANB11 = 0;
double SPANA11 = 0;
double SPANB20 = 0;
double SPANA20 = 0;
double SPANB75 = 0;
double SPANA75 = 0;
     
double TEKAN0 = 0;
double TEKAN1 = 0;
double TEKAN2 = 0;
double TEKAN3 = 0;
double TEKAN4 = 0;
double TEKAN5 = 0;
double TEKAN6 = 0;
double TEKAN7 = 0;
double TEKAN8 = 0;
double TEKAN9 = 0;
double TEKAN10 = 0;
double TEKAN11 = 0;
double TEKAN12 = 0;
double TEKAN13 = 0;
double TEKAN14 = 0;
double TEKAN15 = 0;
double TEKAN16 = 0;
double TEKAN17 = 0;
double TEKAN18 = 0;
double TEKAN19 = 0;
double TEKAN20 = 0;
double TEKAN21 = 0;
double TEKAN22 = 0;
double TEKAN23 = 0;
double TEKAN24 = 0;
double TEKAN33 = 0;
double TEKAN37 = 0;
double TEKAN52 = 0;
double TEKAN75 = 0;
double TEKAN85 = 0;
     
double KIJUN0 = 0;
double KIJUN1 = 0;
double KIJUN2 = 0;
double KIJUN3 = 0;
double KIJUN4 = 0;
double KIJUN5 = 0;
double KIJUN6 = 0;
double KIJUN7 = 0;
double KIJUN8 = 0;
double KIJUN9 = 0;
double KIJUN10 = 0;
double KIJUN11 = 0;
double KIJUN12 = 0;
double KIJUN13 = 0;
double KIJUN14 = 0;
double KIJUN15 = 0;
double KIJUN16 = 0;
double KIJUN17 = 0;
double KIJUN18 = 0;
double KIJUN19 = 0;
double KIJUN20 = 0;
double KIJUN21 = 0;
double KIJUN22 = 0;
double KIJUN23 = 0;
double KIJUN24 = 0;
double KIJUN37 = 0;
double KIJUN52 = 0;
double KIJUN75 = 0;
double KIJUN85 = 0;

double RSI1 = 0;
double RSI2 = 0;

double CCI21 = 0;
double CCI1 = 0;
double CCI13 = 0;
double CCI29 = 0;

double TickSize = 0;
double Pips = 0;
//+-----------------------------------------------------------------------+
//| Init function                                                         |
//+-----------------------------------------------------------------------+
int OnInit()
{
   Print(MarketInfo(Symbol(), MODE_LOTSIZE));
   Print(MarketInfo(Symbol(), MODE_MINLOT));
   Print(MarketInfo(Symbol(), MODE_LOTSTEP));
   Print(MarketInfo(Symbol(), MODE_MAXLOT));
   TickSize = MarketInfo (Symbol(),MODE_TICKSIZE);

   if (TickSize == 0.00001 || TickSize == 0.001 )
   {
      Pips = TickSize * 10 ;
   }
   else Pips = TickSize;
   
   solde = AccountBalance();
   lastSolde = AccountBalance();
    
   return(INIT_SUCCEEDED);
}


//+-----------------------------------------------------------------------+
//| Expert tick function                                                  |
//+-----------------------------------------------------------------------+
void OnTick()
{
   lastSolde = AccountBalance();
   initSelectDiff();
   getChikouSpan();
   getCloud();
   getRedLine();
   getBlueLine();
   getRsi();
   getCci();
   getTotalOrders();
   checkForOpenOderSignUp();
   checkSignUp();
   checkForCloseOrderSignUp();
   checkForUpLot(); 
} 


//+-----------------------------------------------------------------------+
//| initSelectDiff function                                               |
//+-----------------------------------------------------------------------+
void initSelectDiff()
{
   currentPeriod = PERIOD_CURRENT;
   currentSymbole = Symbol();
   
   if (currentSymbole == "EURJPY" && currentPeriod == PERIOD_D1)
   {
      selectDiff50 = 0.05000;
      selectDiff100 = 0.10000;
      selectDiff150 = 0.15000;
      selectDiff190 = 0.19000;
      selectDiff200 = 0.20000;
      selectDiff250 = 0.25000;
      selectDiff300 = 0.30000;
      selectDiff500 = 0.50000;
      selectDiff1000 = 1.00000;
      selectDiff1500 = 1.50000;
      selectDiff2000 = 2.00000;
      selectDiff4000 = 4.00000;
      selectDiff5000 = 5.00000;
      selectDiff10000 = 10.00000;
      selectDiff15000 = 15.00000;
      selectDiff35000 = 35.00000;
   }
   else if ((currentSymbole == "EURUSD" || currentSymbole == "NZDUSD")
      && currentPeriod == PERIOD_D1)
   {
      selectDiff50 = 0.00050;
      selectDiff100 = 0.00100;
      selectDiff150 = 0.00150;
      selectDiff190 = 0.00190;
      selectDiff200 = 0.00200;
      selectDiff250 = 0.00250;
      selectDiff300 = 0.00300;
      selectDiff500 = 0.00500;
      selectDiff1000 = 0.01000;
      selectDiff1500 = 0.01500;
      selectDiff2000 = 0.02000;
      selectDiff4000 = 0.04000;
      selectDiff15000 = 0.05000;
      selectDiff10000 = 0.10000;
      selectDiff15000 = 0.15000;
      selectDiff35000 = 0.35000;
   }
   else if (currentSymbole == "EURJPY" && currentPeriod == PERIOD_M1)
   {
      selectDiff50 = 0.0005000;
      selectDiff100 = 0.0010000;
      selectDiff150 = 0.0015000;
      selectDiff190 = 0.0019000;
      selectDiff200 = 0.0020000;
      selectDiff250 = 0.0025000;
      selectDiff300 = 0.0030000;
      selectDiff500 = 0.0050000;
      selectDiff1000 = 0.0100000;
      selectDiff1500 = 0.0150000;
      selectDiff2000 = 0.0200000;
      selectDiff4000 = 0.04000;
      selectDiff10000 = 0.10000;
      selectDiff15000 = 0.15000;
      selectDiff5000 = 0.05000;
      selectDiff35000 = 0.35000;
   }
   else if ((currentSymbole == "EURUSD" || currentSymbole == "NZDUSD")
      && currentPeriod == PERIOD_M1)
   {
      selectDiff50 = 0.0000050;
      selectDiff100 = 0.0000100;
      selectDiff150 = 0.0000150;
      selectDiff190 = 0.0000190;
      selectDiff200 = 0.0000200;
      selectDiff250 = 0.0000250;
      selectDiff300 = 0.0000300;
      selectDiff500 = 0.0000500;
      selectDiff1000 = 0.0001000;
      selectDiff1500 = 0.0001500;
      selectDiff2000 = 0.0002000;
      selectDiff4000 = 0.0004000;
      selectDiff5000 = 0.0005000;
      selectDiff10000 = 0.0010000;
      selectDiff15000 = 0.0015000;
      selectDiff35000 = 0.0035000;
   }
   
   TickSize = MarketInfo (Symbol(),MODE_TICKSIZE);

   if (TickSize == 0.00001 || TickSize == 0.001)
   {
      Pips = TickSize * 10;
   }
   else Pips = TickSize;
}


//+-----------------------------------------------------------------------+
//| getChikouSpan function                                                |
//+-----------------------------------------------------------------------+
void getChikouSpan()
{
   CHIKOUSPAN29 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,29);
   CHIKOUSPAN30 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,30);
   CHIKOUSPAN34 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,34);
   CHIKOUSPAN39 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,39);
   CHIKOUSPAN46 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,46);
   CHIKOUSPAN35 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,35);
   CHIKOUSPAN37 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,37);
   CHIKOUSPAN161 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,161);
   
   PINGPONGKENJU1 = iIchimoku (currentSymbole,currentPeriod,9,1,52,MODE_CHIKOUSPAN,1);
   PINGPONGKENJU2 = iIchimoku (currentSymbole,currentPeriod,9,1,52,MODE_CHIKOUSPAN,2);
}


//+-----------------------------------------------------------------------+
//| getCloud function                                                     |
//+-----------------------------------------------------------------------+
void getCloud()
{
   SPANB0 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANB,0);
   SPANA0 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANA,0);
   SPANB1 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANB,1);
   SPANA1 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANA,1);
   SPANB2 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANB,2);
   SPANA2 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANA,2);
   SPANB3 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANB,3);
   SPANA3 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANA,3);
   SPANB4 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANB,4);
   SPANA4 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANA,4);
   SPANB5 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANB,5);
   SPANA5 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANA,5);
   SPANB6 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANB,6);
   SPANA6 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANA,6);
   SPANB7 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANB,7);
   SPANA7 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANA,7);
   SPANB1 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANB,10);
   SPANA1 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANA,10);
   SPANB11 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANB,11);
   SPANA11 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANA,11);
   SPANB20 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANB,20);
   SPANA20 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANA,20);
   SPANB75 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANB,75);
   SPANA75 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_SENKOUSPANA,75);
}


//+-----------------------------------------------------------------------+
//| getRedLine function                                                   |
//+-----------------------------------------------------------------------+
void getRedLine()
{
   TEKAN0 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,0);
   TEKAN1 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,1);
   TEKAN2 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,2);
   TEKAN3 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,3);
   TEKAN4 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,4);
   TEKAN5 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,5);
   TEKAN6 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,6);
   TEKAN7 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,7);
   TEKAN8 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,8);
   TEKAN9 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,9);
   TEKAN10 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,10);
   TEKAN11 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,11);
   TEKAN12 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,12);
   TEKAN13 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,13);
   TEKAN14 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,14);
   TEKAN15 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,15);
   TEKAN16 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,16);
   TEKAN17 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,17);
   TEKAN18 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,18);
   TEKAN19 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,19);
   TEKAN20 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,20);
   TEKAN21 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,21);
   TEKAN22 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,22);
   TEKAN23 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,23);
   TEKAN24 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,24);
   TEKAN33 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,33);
   TEKAN37 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,37);
   TEKAN52 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,52);
   TEKAN75 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,75);
   TEKAN85 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_TENKANSEN,85);
}


//+-----------------------------------------------------------------------+
//| getBlueLine function                                                  |
//+-----------------------------------------------------------------------+
void getBlueLine()
{
   KIJUN0 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,0);
   KIJUN1 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,1);
   KIJUN2 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,2);
   KIJUN3 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,3);
   KIJUN4 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,4);
   KIJUN5 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,5);
   KIJUN6 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,6);
   KIJUN7 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,7);
   KIJUN8 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,8);
   KIJUN9 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,9);
   KIJUN10 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,10);
   KIJUN11 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,11);
   KIJUN12 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,12);
   KIJUN13 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,13);
   KIJUN14 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,14);
   KIJUN15 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,15);
   KIJUN16 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,16);
   KIJUN17 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,17);
   KIJUN18 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,18);
   KIJUN19 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,19);
   KIJUN20 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,20);
   KIJUN21 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,21);
   KIJUN22 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,22);
   KIJUN23 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,23);
   KIJUN24 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,24);
   KIJUN37 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,37);
   KIJUN52 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,52);
   KIJUN75 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,75);
   KIJUN85 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_KIJUNSEN,85);
}


//+-----------------------------------------------------------------------+
//| getRsi function                                                       |
//+-----------------------------------------------------------------------+
void getRsi()
{
   RSI1 = iRSI (currentSymbole,currentPeriod,75,PRICE_CLOSE,1);
   RSI2 = iRSI (currentSymbole,currentPeriod,75,PRICE_CLOSE,2);
}


//+-----------------------------------------------------------------------+
//| getCci function                                                       |
//+-----------------------------------------------------------------------+
void getCci()
{
   CCI1 = iCCI (currentSymbole,currentPeriod,75,PRICE_CLOSE,1);
   CCI13 = iCCI (currentSymbole,currentPeriod,75,PRICE_CLOSE,13);
   CCI21 = iCCI (currentSymbole,currentPeriod,75,PRICE_CLOSE,21);
   CCI29 = iCCI (currentSymbole,currentPeriod,75,PRICE_CLOSE,29);
}


//+-----------------------------------------------------------------------+
//| getTotalOrders function                                               |
//+-----------------------------------------------------------------------+
void getTotalOrders()
{
   total = OrdersTotal();
}


//+-----------------------------------------------------------------------+
//| checkSignUp function                                                  |
//+-----------------------------------------------------------------------+
void checkSignUp()
{
   if (Low[1] > SPANA1 && Low[1] > SPANB1 && signUp == 0 && VerifOk == 1)
   {
      if (SPANB0 < TEKAN0 && SPANA0 < TEKAN0 && SPANB1 < (TEKAN1 + selectDiff250)
         && SPANA1 < (TEKAN1 + selectDiff250) && Open[1] > SPANA1
         && High[1] > TEKAN1 && TEKAN5 > KIJUN5 && Low[20] < SPANA20 && Low[20] < SPANB20
         && Low[75] < SPANA75 && Low[75] < SPANB75)
      {
         printf("SignUP!!!!!!!!!!!");
         signUp = 9;
      }
   } 
}


//+-----------------------------------------------------------------------+
//| checkForCloseOrderSignUp function                                     |
//+-----------------------------------------------------------------------+
void checkForCloseOrderSignUp()
{
   if (signUp == 9 && total > 0 && VerifOk == 1)
   {
      if (KIJUN0 > TEKAN0 && SPANA0 > KIJUN0 && SPANB0 > KIJUN0 && SPANA0 > TEKAN0
            && SPANB0 > TEKAN0 && CCI21 < 0 && SPANA0 > SPANB0)
      {
         printf("Fermé par checkForCloseOrderSignUp");
         closeOrder();
         upOne = false;
         UpUpUp = 0.005;
         closeOk = false;
         signUp = 0;
         VerifOk = 0;
      }
      else if (firstTrad == 0 && secondTrad == 1 && protectionCloseTrad1 == 0 && (Open[0] > TEKAN1 || Close[0] > TEKAN1 || Low[0] > TEKAN1) && KIJUN1 > TEKAN1 && signUp == 9 && total > 0 && VerifOk == 1 && PINGPONGKENJU1 < Open[0])
      {
         secondTrad = 0;
         closeOrderForUpLot();
      }
      /*else if (signUp == 9 && total > 0 && VerifOk == 1 && PINGPONGKENJU1 < Open[1]
      && ((firstTrad == 0 && secondTrad == 1 && protectionCloseTrad1 == 0 && protectionCloseTrad2 == 0) || (firstTrad == 1 && secondTrad == 0 && protectionCloseTrad1 == 0 && protectionCloseTrad2 == 0)))
      {
         closeOrderForUpLot();
      }*/
   }
}


//+-----------------------------------------------------------------------+
//| checkForCloseOrderNotSignUp function                                  |
//+-----------------------------------------------------------------------+
void checkForCloseOrderNotSignUp()
{
   if (Low[1] > SPANB1 && High[2] < High[1] && signUp == 0 && Low[2] < TEKAN1 && total == 1)
   {
      printf("Fermé par checkForCloseOrderNotSignUp");
      lastSolde = AccountBalance();
      closeOrder();
   }
}


//+-----------------------------------------------------------------------+
//| checkForOpenOderNotSignUp function                                    |
//+-----------------------------------------------------------------------+
void checkForOpenOderNotSignUp()
{
   if (SPANB0 < TEKAN0 && SPANA0 < TEKAN0 && SPANB1 < (TEKAN1 + selectDiff250)
         && SPANA1 < (TEKAN1 + selectDiff250)
         && Low[1] > SPANA1 && Low[0] > SPANA0 && High[1] > TEKAN1 && Low[1] > TEKAN1
         && (((KIJUN19 > TEKAN19 && KIJUN18 > TEKAN18 && KIJUN17 > TEKAN17 && KIJUN16 > TEKAN16
         && KIJUN15 > TEKAN15 && KIJUN9 < TEKAN9 && KIJUN8 < TEKAN8 && KIJUN7 < TEKAN7
         && KIJUN6 < TEKAN6 && KIJUN5 < TEKAN5 && TEKAN1 > SPANA1 && TEKAN1 > SPANB1 )
         || (KIJUN19 < TEKAN19 && KIJUN18 < TEKAN18 && KIJUN17 < TEKAN17 && KIJUN16 < TEKAN16
         && KIJUN15 < TEKAN15 && KIJUN9 > TEKAN9 && KIJUN8 > TEKAN8 && KIJUN7 > TEKAN7
         && KIJUN6 > TEKAN6 && KIJUN5 > TEKAN5 && TEKAN1 > SPANA1 && TEKAN1 > SPANB1)) || ((KIJUN24 > TEKAN24
         && KIJUN23 > TEKAN23 && KIJUN24 > TEKAN24 && KIJUN9 < TEKAN9 && KIJUN8 < TEKAN8 && KIJUN7 < TEKAN7
         && KIJUN6 < TEKAN6 && KIJUN5 < TEKAN5 && TEKAN1 > SPANA1 && TEKAN1 > SPANB1)
         || (KIJUN19 < TEKAN19 && KIJUN18 < TEKAN18 && KIJUN17 < TEKAN17 && KIJUN16 < TEKAN16
         && KIJUN15 < TEKAN15 && KIJUN9 > TEKAN9 && KIJUN8 > TEKAN8 && KIJUN7 > TEKAN7
         && KIJUN6 > TEKAN6 && KIJUN5 > TEKAN5 && TEKAN1 > SPANA1 && TEKAN1 > SPANB1)))
         && Low[4] > TEKAN4 && Low[0] > TEKAN0 && Low[2] > TEKAN2 && Low[3] > KIJUN3 && KIJUN3 < TEKAN3
         && total == 0)
   {
      openOrders(Lot);
   }
}


//+-----------------------------------------------------------------------+
//| checkForOpenOderSignUp function                                       |
//+-----------------------------------------------------------------------+
void checkForOpenOderSignUp()
{
   if ((KIJUN3 > TEKAN3 && KIJUN4 > TEKAN4 && KIJUN5 > TEKAN5
         && (KIJUN4 - TEKAN4) > selectDiff500 && High[3] > TEKAN3
         && High[4] > TEKAN4 && High[5] > TEKAN5 && High[7] > TEKAN7
         && High[8] > TEKAN8 && High[9] > (TEKAN9 + selectDiff150) 
         && TEKAN1 > (KIJUN1 + selectDiff100) && High[4] < SPANA4
         && High[5] < SPANA5 && High[6] < SPANA6 && High[7] < SPANA7 
         && High[4] < SPANB4 && High[5] < SPANB5 && High[6] < SPANB6
         && High[7] < SPANB7 && Low[4] < (KIJUN4 + selectDiff100)
         && Low[5] < KIJUN5 && (Low[3] + selectDiff200) > TEKAN3)
         && Open[3] > TEKAN3 && Open[4] > TEKAN4 && Open[5] > TEKAN5
         && CHIKOUSPAN161 > TEKAN1 && CHIKOUSPAN37 < TEKAN1 && VerifOk == 0 && total == 0)
   {
      VerifOk = 1;
      //openOrders(Lot);
   }
}


//+-----------------------------------------------------------------------+
//| checkForCloseLooseHigh function                                       |
//+-----------------------------------------------------------------------+
void checkForCloseLooseHigh() 
{
   double highLoose = (selectDiff15000 - selectDiff15000 - selectDiff15000);
   
   if (((High[1] - OpenOderValue) < highLoose) && signUp == 0
      && SPANB1 < TEKAN1 && SPANA1 < TEKAN1 && total == 1)
   {
      printf("Fermé par checkForCloseLooseHigh");
      closeOrder();
   }
}


//+-----------------------------------------------------------------------+
//| checkForUpLot function                                                |
//+-----------------------------------------------------------------------+
void checkForUpLot()
{
   /*if ((High[1] - OpenOderValue) > selectDiff5000 && total == 1)
   {
      closeOrderForUpLot();
   }*/
   if (signUp == 9 && VerifOk == 1 && PINGPONGKENJU1 > Open[1])
   {
     openOrdersSignUp();
   }
}


//+-----------------------------------------------------------------------+
//| openOrdersSignUp function                                             |
//+-----------------------------------------------------------------------+
void openOrders(double lot)
{
   bool ok = false;
   int i = 0;
  
   double lotUp = Lot;
   double TakeProfit = 350;

   while (i < 1)
   {
      ok = OrderSend (currentSymbole,OP_BUY,lotUp,Ask,slippage,SL,Ask + (TakeProfit*Pips),NULL,MagicNumber,0,Green);
      if (ok == true)
      {
         i++;
         ok = false;
      }
   }
}

//+-----------------------------------------------------------------------+
//| openOrdersSignUp function                                             |
//+-----------------------------------------------------------------------+
void openOrdersSignUp()
{
   bool ok = false;
   int i = 0;
   double lotUp = 0;
   double spanichi10 = iIchimoku (currentSymbole,currentPeriod,1,1,1,MODE_CHIKOUSPAN,10);
   double spanichi0 = iIchimoku (currentSymbole,currentPeriod,1,1,1,MODE_CHIKOUSPAN,0);
   double TakeProfit = 300;
   int soldeTmp = solde;
   int lastSoldeTmp = lastSolde;
   double lossFactorMax = (((lastSoldeTmp - soldeTmp)/1250)*7);
   string value = DoubleToStr(lossFactorMax,2);
   
   lotUp = StrToDouble(value);
   lotUp = (lotUp*Lot) + (Lot * 10);
   
   if (lotUp <= 0 || ((lastSoldeTmp - soldeTmp) <= 0))
   {
      lotUp = Lot * 10;
   }
   
   getTotalOrders();
   
   bool total_01234 = false;
   if (total == 0) total_01234 = true;
   if (total == 1) total_01234 = true;
   if (total == 2) total_01234 = true;
   if (total == 4) total_01234 = true;
   
   bool total_012345 = false;
   if (total == 0) total_012345 = true;
   if (total == 1) total_012345 = true;
   if (total == 2) total_012345 = true;
   if (total == 4) total_012345 = true;
   if (total == 5) total_012345 = true;
   
   bool total_012346 = false;
   if (total == 0) total_012346 = true;
   if (total == 1) total_012346 = true;
   if (total == 2) total_012346 = true;
   if (total == 4) total_012346 = true;
   if (total == 5) total_012346 = true;
   if (total == 6) total_012346 = true;

   
   if (CCI1 < 0 && CCI13 < 100 && RSI1 < 55 && firstTrad == 0 && secondTrad == 0 && protectionCloseTrad1 == 0 && protectionCloseTrad2 == 0 && total_012345 && VerifOk == 1)
   {
      TakeProfit = 1161.8;
      while (i < 1)
      {
         ok = OrderSend (currentSymbole,OP_BUY,lotUp,Ask,slippage,SL,Ask + (TakeProfit*Pips),NULL,MagicNumber,0,Green);
         if (ok == true)
         {
            i++;
            ok = false;
         }
      }
   }
   
   //FIRSTTRADETAKE1100
   if (CCI1 < 30 && CCI13 > 100 && RSI1 < 55 && firstTrad == 0 && secondTrad == 0 && protectionCloseTrad1 == 0 && protectionCloseTrad2 == 0 && total_012345 && VerifOk == 1)
   {
      TakeProfit = 1100;
      firstTrad = 1;
      protectionCloseTrad1 = 1;
      OpenOderValue = High[1];
      
      while (i < 1)
      {
         ok = OrderSend (currentSymbole,OP_BUY,lotUp,Ask,slippage,SL,Ask + (TakeProfit*Pips),NULL,MagicNumber,0,Green);
         if (ok == true)
         {
            i++;
            ok = false;
         }
      }
   }
   
   //TRAD SIGUNP
   if (CCI1 < 100 && CCI13 < 100 && RSI1 < 55 && firstTrad == 0 && secondTrad == 0 && protectionCloseTrad1 == 0 && protectionCloseTrad2 == 0 && total == 0 && VerifOk == 1)
   {
      double thisLotUp = Lot * 20;
      
      while (i < 2)
      {
         ok = OrderSend (currentSymbole,OP_BUY,thisLotUp,Ask,slippage,SL,0,NULL,MagicNumber,0,Green);
         if (ok == true)
         {
            i++;
            ok = false;
         }
      }
   }
   
   //TradShort1100
   if (CCI1 < 100 && CCI13 < 100 && RSI1 < 55 && firstTrad == 0 && secondTrad == 0 && protectionCloseTrad1 == 0 && protectionCloseTrad2 == 0 && total_012345 && VerifOk == 1)
   {
      TakeProfit = 161.8;
   
      while (i < 2)
      {
         ok = OrderSend (currentSymbole,OP_BUY,lotUp,Ask,slippage,SL,Ask + (TakeProfit*Pips),NULL,MagicNumber,0,Green);
         if (ok == true)
         {
            i++;
            ok = false;
         }
      }
   }
   
   //FIRTTAKEPINGPONG
   if (firstTrad == 1 && secondTrad == 0 && protectionCloseTrad1 == 1 && protectionCloseTrad2 == 0 && VerifOk == 1 && total_012345)
   {
      TakeProfit = 161.8;
      firstTrad = 1;
      protectionCloseTrad1 = 1;
      
      while (i < 2)
      {
         ok = OrderSend (currentSymbole,OP_BUY,lotUp,Ask,slippage,SL,Ask + (TakeProfit*Pips),NULL,MagicNumber,0,Green);
         if (ok == true)
         {
            i++;
            ok = false;
         }
      }
      if ((High[1] - OpenOderValue) > 11.618)
      {
         protectionCloseTrad1 = 0;
      }
   }
   
   //SECONDETRADETAKE1100
   if (TEKAN1 > CHIKOUSPAN35 && firstTrad == 1 && protectionCloseTrad1 == 0 && protectionCloseTrad2 == 0 && total_012346 && VerifOk == 1)
   {
      firstTrad = 0;
      secondTrad = 1;
      TakeProfit = 1161.8;
      protectionCloseTrad2 = 1;
      OpenOderValue = High[1];
      
      while (i < 2)
      {
         ok = OrderSend (currentSymbole,OP_BUY,lotUp,Ask,slippage,SL,Ask + (TakeProfit*Pips),NULL,MagicNumber,0,Green);
         if (ok == true)
         {
            i++;
            ok = false;
         }
      }
   }
   
   if (secondTrad == 1 && firstTrad == 0 && protectionCloseTrad2 == 1 && protectionCloseTrad1 == 0 && total_012345 && VerifOk == 1)
   {
      TakeProfit = 161.8;
      secondTrad = 1;
      protectionCloseTrad2 = 1;
      while (i < 1)
      {
         ok = OrderSend (currentSymbole,OP_BUY,lotUp,Ask,slippage,SL,Ask + (TakeProfit*Pips),NULL,MagicNumber,0,Green);
         if (ok == true)
         {
            i++;
            ok = false;
         }
      }
      if ((High[1] - OpenOderValue) > 10.618)
      {
         protectionCloseTrad2 = 0;
         secondTrad = 0;
      }
   }
}


//+-----------------------------------------------------------------------+
//| closeOrder function                                                   |
//+-----------------------------------------------------------------------+
void closeOrder()
{
   printf("Fermé par closeOrder");
   signUp = 0;
   Lot = 0.01;
   total = OrdersTotal();
   while (total > 0)
   {
      for(int i=total-1; i>=0; i--)
      {
         int ticket = OrderSelect(i,SELECT_BY_POS);
         bool result = OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),3,clrNONE);
      }
      total = OrdersTotal();
   }
}


//+-----------------------------------------------------------------------+
//| closeOrderForUpLot function                                           |
//+-----------------------------------------------------------------------+
void closeOrderForUpLot()
{
   printf("Fermé par closeOrderForUpLot");
   total = OrdersTotal();
   bool result = false;
   int i = total-1;
   while (total > 0 && i >= 0)
   {
      int ticket = OrderSelect(i,SELECT_BY_POS);
      result = OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),3,clrNONE);
      if (result == true)
      {
         i--;
      }
      total = OrdersTotal();
   }
}
