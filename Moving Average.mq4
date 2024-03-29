// paramètres du robot
input int TakeProfit = 300;
input int StopLoss = 5;
input int RSI_Period = 14;
input int RSI_Level = 70;
input double Lots = 0.1;
input int MagicNumber = 0123456;
double PrixStopLoss = 0;
double PrixTakeProfit = 0;
// variables internes
double RSI_Buffer[];
int ticket;
input double StopLossTrailing = 175;

// fonction d'initialisation du robot
void OnInit()
{
  // réserver l'espace mémoire pour le buffer de l'indicateur RSI
  ArrayResize(RSI_Buffer, Bars);
}

// fonction de boucle du robot
void OnTick()
{
  // mettre à jour le buffer de l'indicateur RSI
  for (int i = 0; i < Bars; i++)
    RSI_Buffer[i] = iRSI(Symbol(), 0, RSI_Period, PRICE_CLOSE, i);
    
  // mettre à jour le stop loss suiveur
  for (int j = 0; j < OrdersTotal(); j++)
  {
    if (OrderSelect(j, SELECT_BY_POS, MODE_TRADES))
    {
      // vérifier si c'est une commande en cours d'achat
      if (OrderType() == OP_BUY)
      {
        // mettre à jour le stop loss suiveur
        if (Bid - StopLossTrailing * _Point > OrderStopLoss())
        {
          OrderModify(OrderTicket(), OrderOpenPrice(), Ask - StopLossTrailing * _Point, OrderTakeProfit(), 0, clrNONE);
        }
      }
      // vérifier si c'est une commande en cours de vente
      else if (OrderType() == OP_SELL)
      {
        // mettre à jour le stop loss suiveur
        if (Ask + StopLossTrailing * _Point < OrderStopLoss())
        {
          OrderModify(OrderTicket(), OrderOpenPrice(), Bid + StopLossTrailing * _Point, OrderTakeProfit(), 0, clrNONE);
        }
      }
    }
  }

  // vérifier s'il y a une divergence haussière
  if (RSI_Buffer[1] < RSI_Level && RSI_Buffer[0] >= RSI_Level)
  {
    // ouvrir une position longue
    if (OrdersTotal()<1)
    {
      PrixStopLoss = OrderOpenPrice() - (StopLoss * _Point);
      PrixTakeProfit = OrderOpenPrice() + (TakeProfit * _Point);
      ticket = OrderSend(Symbol(), OP_BUY, Lots, Ask, 3,Bid-StopLoss *Point,0, "Divergence RSI Long", MagicNumber, 0, Green);
       if (ticket < 0)
         Print("Erreur lors de l'ouverture de la position longue: ", GetLastError());
    }
  }

  // vérifier s'il y a une divergence baissière
  if (RSI_Buffer[1] > RSI_Level && RSI_Buffer[0] <= RSI_Level)
  {
    // ouvrir une position courte
    if (OrdersTotal()<1)
    {
       PrixStopLoss = OrderOpenPrice() + (StopLoss * _Point);
       PrixTakeProfit = OrderOpenPrice() - (TakeProfit * _Point);
       ticket = OrderSend(Symbol(), OP_SELL, Lots, Bid, 3,Ask+StopLoss *Point,0, "Divergence RSI Short", MagicNumber, 0, Red);
       if (ticket < 0)
         Print("Erreur lors de l'ouverture de la position courte: ", GetLastError());
    }
  }
  
  if (RSI_Buffer[1] > 30 && RSI_Buffer[0] <= 30)
  {
    // ouvrir une position longue
    if (OrdersTotal()<1)
    {
      PrixStopLoss = OrderOpenPrice() - (StopLoss * _Point);
      PrixTakeProfit = OrderOpenPrice() + (TakeProfit * _Point);
      ticket = OrderSend(Symbol(), OP_BUY, Lots, Ask, 3,Bid-StopLoss *Point,0, "Divergence RSI Long", MagicNumber, 0, Green);
       if (ticket < 0)
         Print("Erreur lors de l'ouverture de la position longue: ", GetLastError());
    }
  }

  // vérifier s'il y a une divergence baissière
  if (RSI_Buffer[1] < 30 && RSI_Buffer[0] >= 30)
  {
    // ouvrir une position courte
    if (OrdersTotal()<1)
    {
       PrixStopLoss = OrderOpenPrice() + (StopLoss * _Point);
       PrixTakeProfit = OrderOpenPrice() - (TakeProfit * _Point);
       ticket = OrderSend(Symbol(), OP_SELL, Lots, Bid, 3,Ask+StopLoss *Point,0, "Divergence RSI Short", MagicNumber, 0, Red);
       if (ticket < 0)
         Print("Erreur lors de l'ouverture de la position courte: ", GetLastError());
    }
  }
}