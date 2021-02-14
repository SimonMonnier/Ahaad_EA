

 //////////////////////////////////////////////////////////////////////////////
/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!/*/
/**-----------------------------------------------------------------------+/**/
/*!                                                                       !***/              
/*!                                      .   .                            !***/
/*!                              '  /\   |\  |\                           !***/
/*!                             /|  ||   ||\ ||\                          !***/
/*!                            /||  ||   ||  ||                           !***/
/*!                           //||  ||   ||  ||                           !***/
/*!                           \/\\_//\\_//   |/                           !***/          
/*!                                                                       !***/
/*!                               Ahaad.mq4                               !***/
/*!                                                                       !***/
/*!       Copyright Forever: Allah, gloire à lui qu'il soit Exalté.       !***/
/*!                       https://www.ahaad.1618/phi                      !***/
/*!                                                                       !***/
/*+-----------------------------------------------------------------------+***/
/*!                                                                       !***/
/*!                         Coran                                         !***/
/*!                                                                       !***/
/*!               Chapitre 93: La Matinée                                 !***/
/*!                                                                       !***/
/*!    Au nom d'Allah, le Tout Miséricordieux, le Plus Miséricordieux     !***/
/*!                                                                       !***/
/*! 1  - Par la matinée.                                                  !***/
/*! 2  - Par la nuit quand elle tombe.                                    !***/
/*! 3  - Ton Seigneur ne t’a jamais abandonné, et Il n’a pas oublié.      !***/
/*! 4  - L’Au-delà est de loin meilleur pour toi que cette première(vie). !***/
/*! 5  - Et ton Seigneur te donnera suffisamment ; tu seras satisfait.    !***/
/*! 6  - Ne t’a-t-Il pas trouvé orphelin et Il t’a donné un foyer ?       !***/
/*! 7  - Il t’a trouvé égaré, et t’a guidé.                               !***/
/*! 8  - Il t’a trouvé pauvre, et t’a rendu riche.                        !***/
/*! 9  - Donc, tu ne délaisseras pas l’orphelin.                          !***/
/*! 10 - Et tu ne réprimanderas pas le mendiant.                          !***/
/*! 11 - Tu proclameras la bénédiction dont ton Seigneur t’a comblé.      !**/
/*!                                                                       !*/
/**-----------------------------------------------------------------------*/






#property copyright "Copyright Forever: Allah, gloire à lui qu'il soit Exalté."
#property link      "https://www.ahaad.1618/phi"
#property version   "1.00"
#property strict


//+-----------------------------------------------------------------------+
//| Extern global variable                                                |
//+-----------------------------------------------------------------------+
extern int slippage = 10 ;
extern int MagicNumber = 1618 ;
extern double Lot = 0.1618 ;


//+-----------------------------------------------------------------------+
//| Global variable                                                       |
//+-----------------------------------------------------------------------+
int currentPeriod = 0;
string currentSymbole = "";

double SL = 0 ;
double TP = 0 ;

int signUp = 0;
int doubleVerifOk = 0;
int total = 0;

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

double CHIKOUSPAN29 = 0;
double CHIKOUSPAN30 = 0;
double CHIKOUSPAN34 = 0;
double CHIKOUSPAN39 = 0;
double CHIKOUSPAN46 = 0;
double CHIKOUSPAN57 = 0;
     
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


//+-----------------------------------------------------------------------+
//| Init function                                                         |
//+-----------------------------------------------------------------------+
int OnInit()
{
   return(INIT_SUCCEEDED);
}


//+-----------------------------------------------------------------------+
//| Expert tick function                                                  |
//+-----------------------------------------------------------------------+
void OnTick()
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
   }
   
   CHIKOUSPAN29 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,29);
   CHIKOUSPAN30 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,30);
   CHIKOUSPAN34 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,34);
   CHIKOUSPAN39 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,39);
   CHIKOUSPAN46 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,46);
   CHIKOUSPAN57 = iIchimoku (currentSymbole,currentPeriod,9,26,52,MODE_CHIKOUSPAN,57);
   
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
   
   RSI1 = iRSI (currentSymbole,currentPeriod,75,PRICE_CLOSE,1);
   RSI2 = iRSI (currentSymbole,currentPeriod,75,PRICE_CLOSE,2);
   
   CCI21 = iCCI (currentSymbole,currentPeriod,75,PRICE_CLOSE,21);
   
   total = OrdersTotal();

   if (Low[1] > SPANA1 && Low[1] > SPANB1 && signUp == 0 && total > 0)
   {
      if (SPANB0 < TEKAN0 && SPANA0 < TEKAN0 && SPANB1 < (TEKAN1 + selectDiff250)
         && SPANA1 < (TEKAN1 + selectDiff250) && CHIKOUSPAN57 < TEKAN1
         && Open[1] > SPANA1 && Open[0] > SPANA0 && High[1] > TEKAN1 && High[1] > TEKAN1
         && TEKAN5 > KIJUN4 && High[3] > SPANA3 && High[3] > SPANB3 && High[2] > SPANA2
         && High[2] > SPANB2 && High[4] > SPANA4 && High[4] > SPANB4 && Low[10] < SPANA10
         && Low[10] < SPANB10 && Low[11] < SPANA11 && Low[11] < SPANB11 && Low[20] < SPANA20
         && Low[20] < SPANB20 && Low[75] < SPANA75 && Low[75] < SPANB75 && doubleVerifOk == 1)
      {
         signUp = 9;
         printf(signUp);
         printf("SignUp :");
      }
      if (Low[1] > SPANB1 && High[0] < High[1] && doubleVerifOk == 0 && Low[0] < TEKAN0)
      {
         closeOrder();
      } 
   } 
   else if (signUp == 9)
   {
      if (KIJUN0 > TEKAN0 && SPANA0 > KIJUN0 && SPANB0 > KIJUN0 && SPANA0 > TEKAN0
            && SPANB0 > TEKAN0 && CCI21 < 0 && SPANA0 > SPANB0)
      {
         closeOrder();
      }
   }
   
   if (SPANB0 < TEKAN0 && SPANA0 < TEKAN0 && SPANB1 < (TEKAN1 + selectDiff250)
         && SPANA1 < (TEKAN1 + selectDiff250) && CHIKOUSPAN57 + selectDiff100 < TEKAN1
         && Low[1] > SPANA1 && Low[0] > SPANA0 && High[1] > TEKAN1 && Low[1] > TEKAN1
         && (((KIJUN19 > TEKAN19 && KIJUN18 > TEKAN18 && KIJUN17 > TEKAN17 && KIJUN16 > TEKAN16
         && KIJUN15 > TEKAN15 && KIJUN9 < TEKAN9 && KIJUN8 < TEKAN8 && KIJUN7 < TEKAN7
         && KIJUN6 < TEKAN6 && KIJUN5 < TEKAN5 && TEKAN1 > SPANA1 && TEKAN1 > SPANB1 )
         || (KIJUN19 < TEKAN19 && KIJUN18 < TEKAN18 && KIJUN17 < TEKAN17 && KIJUN16 < TEKAN16
         && KIJUN15 < TEKAN15 && KIJUN9 > TEKAN9 && KIJUN8 > TEKAN8 && KIJUN7 > TEKAN7
         && KIJUN6 > TEKAN6 && KIJUN5 > TEKAN5 && TEKAN1 > SPANA1 && TEKAN1 > SPANB1)) || ((KIJUN24 > TEKAN24
         && KIJUN23 > TEKAN23 && KIJUN24 > TEKAN24 && KIJUN9 < TEKAN9 && KIJUN8 < TEKAN8 && KIJUN7 < TEKAN7
         && KIJUN6 < TEKAN6 && KIJUN5 < TEKAN5 && TEKAN1 > SPANA1 && TEKAN1 > SPANB1 )
         || (KIJUN19 < TEKAN19 && KIJUN18 < TEKAN18 && KIJUN17 < TEKAN17 && KIJUN16 < TEKAN16
         && KIJUN15 < TEKAN15 && KIJUN9 > TEKAN9 && KIJUN8 > TEKAN8 && KIJUN7 > TEKAN7
         && KIJUN6 > TEKAN6 && KIJUN5 > TEKAN5 && TEKAN1 > SPANA1 && TEKAN1 > SPANB1)))
         && Low[4] > TEKAN4  && Low[0] > TEKAN0 && Low[2] > TEKAN2 && Low[3] > KIJUN3 && KIJUN3 < TEKAN3
         && total <= 2)
   {
      doubleVerifOk = 1;
      bool ok = false;
      int i = 0;
      while (ok == false && i < 3)
      {
         ok = OrderSend (currentSymbole,OP_BUY,Lot,Ask,slippage,SL,TP,NULL,MagicNumber,0,Green);
         if (ok == true)
         {
            i++;
            ok = false;
         }
      }
   }
   else if ((KIJUN3 > TEKAN3 && KIJUN4 > TEKAN4 && KIJUN5 > TEKAN5
         && (KIJUN4 - TEKAN4) > selectDiff500 && High[3] > TEKAN3
         && High[4] > TEKAN4 && High[5] > TEKAN5 && High[7] > TEKAN7
         && High[8] > TEKAN8 && High[9] > (TEKAN9 + selectDiff150) 
         && TEKAN1  > (KIJUN1 + selectDiff100) && High[4] < SPANA4
         && High[5] < SPANA5 && High[6] < SPANA6 && High[7] < SPANA7 
         && High[4] < SPANB4 && High[5] < SPANB5 && High[6] < SPANB6
         && High[7] < SPANB7 && Low[4] < (KIJUN4 + selectDiff100)
         && Low[5] < KIJUN5 && (Low[3] + selectDiff200) > TEKAN3)
         && Open[3] > TEKAN3 && Open[4] > TEKAN4 && Open[5] > TEKAN5
         && ((RSI1 < 49 && RSI2 < 49) || (RSI1 > 53 && RSI2 < 50))
         && Low[1] < TEKAN1 && Close[1] > KIJUN1 && Open[1] < (KIJUN3 + selectDiff150) && total < 3)
   {
      bool ok = false;
      int i = 0;
      while (ok == false && i < 3)
      {
         ok = OrderSend (currentSymbole,OP_BUY,Lot,Ask,slippage,SL,TP,NULL,MagicNumber,0,Green);
         if (ok == true)
         {
            i++;
            ok = false;
         }
      }
   }
} 



//+-----------------------------------------------------------------------+
//| Close orders function                                                 |
//+-----------------------------------------------------------------------+
void closeOrder()
{
   signUp = 0;
   doubleVerifOk = 0;
   total = OrdersTotal();
   while (total > 0)
   {
      for(int i=total-1; i>=0; i--)
      {
         int  ticket = OrderSelect(i,SELECT_BY_POS);
         bool result = OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),3,clrNONE);     
      }
      total = OrdersTotal();
   }
}