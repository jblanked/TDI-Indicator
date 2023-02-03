//+------------------------------------------------------------------+
//|                                                TDI Indicator.mq4 |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "JBlanked"
#property link "jblankedonthisbeat@gmail.com"


#property indicator_separate_window
#property indicator_minimum 0 // 0 line
#property indicator_maximum 100 // 100 line
#property indicator_level1  32 // Buy Zone
#property indicator_level2  37 // 
#property indicator_level3  63 // Sell Zone
#property indicator_level4  68 //

#property indicator_level5  20 // Major
#property indicator_level6  15 // Demand
#property indicator_level7  10 // Zone

#property indicator_level8  90 // Major
#property indicator_level9  85 // Suplply
#property indicator_level10 80 // Zone


#property indicator_buffers 4
#property indicator_color1 Red // 7 MA
#property indicator_color2 Green // 2 MA
#property indicator_color3 Yellow // 34 line
#property indicator_color4 Black // RSI



extern int  RSI_Period = 8; // RSI period?
extern int  RSI_Applied_Price = PRICE_CLOSE; // Apply RSI to?
extern int  MA1_Period = 7; // First MA period?
extern int  MA1_Method = MODE_SMA;// First MA method?
extern int  MA2_Period = 2; // Second MA period?
extern int  MA2_Method = MODE_SMA;// Second MA method?
extern int  MA3_Period = 34; // Third MA period?
extern int  MA3_Method = MODE_SMA;// Third MA method?

double MA1_Array[],MA2_Array[],MA3_Array[],RSI[];


datetime expiryDate = D'2099.12.08 00:00'; //Date and time for expirations

    
    
    // Account names allowed for this EA
   
    string Accountn1 = "";                           string Accountn21 = ""; string Accountn41 = ""; string Accountn61 = ""; string Accountn81 = "";
    string Accountn2 = "";                           string Accountn22 = ""; string Accountn42 = ""; string Accountn62 = ""; string Accountn82 = "";
    string Accountn3 = "";                           string Accountn23 = ""; string Accountn43 = ""; string Accountn63 = ""; string Accountn83 = "";
    string Accountn4 = "";                           string Accountn24 = ""; string Accountn44 = ""; string Accountn64 = ""; string Accountn84 = "";
    string Accountn5 = "";                           string Accountn25 = ""; string Accountn45 = ""; string Accountn65 = ""; string Accountn85 = "";
    string Accountn6 = "";                           string Accountn26 = ""; string Accountn46 = ""; string Accountn66 = ""; string Accountn86 = "";
    string Accountn7 = "";                           string Accountn27 = ""; string Accountn47 = ""; string Accountn67 = ""; string Accountn87 = "";
    string Accountn8 = "";                           string Accountn28 = ""; string Accountn48 = ""; string Accountn68 = ""; string Accountn88 = "";
    string Accountn9 = "";                           string Accountn29 = ""; string Accountn49 = ""; string Accountn69 = ""; string Accountn89 = "";
    string Accountn10 = "";                          string Accountn30 = ""; string Accountn50 = ""; string Accountn70 = ""; string Accountn90 = "";
    string Accountn11 = "";                          string Accountn31 = ""; string Accountn51 = ""; string Accountn71 = ""; string Accountn91 = "";
    string Accountn12 = "";                          string Accountn32 = ""; string Accountn52 = ""; string Accountn72 = ""; string Accountn92 = "";
    string Accountn13 = "";                          string Accountn33 = ""; string Accountn53 = ""; string Accountn73 = ""; string Accountn93 = "";
    string Accountn14 = "";                          string Accountn34 = ""; string Accountn54 = ""; string Accountn74 = ""; string Accountn94 = "";
    string Accountn15 = "";                          string Accountn35 = ""; string Accountn55 = ""; string Accountn75 = ""; string Accountn95 = "";
    string Accountn16 = "";                          string Accountn36 = ""; string Accountn56 = ""; string Accountn76 = ""; string Accountn96 = "";
    string Accountn17 = "";                          string Accountn37 = ""; string Accountn57 = ""; string Accountn77 = ""; string Accountn97 = "";
    string Accountn18 = "";                          string Accountn38 = ""; string Accountn58 = ""; string Accountn78 = ""; string Accountn98 = "";
    string Accountn19 = "";                          string Accountn39 = ""; string Accountn59 = ""; string Accountn79 = ""; string Accountn99 = "";
    string Accountn20 = "";                          string Accountn40 = ""; string Accountn60 = ""; string Accountn80 = ""; string Accountn100 = "";

//+------------------------------------------------------------------+
//| Custom indicator initialization function |
//+------------------------------------------------------------------+
int init()
{

    //EA expiry lock
        
if(TimeCurrent()>expiryDate){
Alert("Your license expired... Renew or purchase your VIP subsciption");
SendNotification("Your license expired... Renew or purchase your VIP subsciption");

ObjectDelete("Times Up");                                                         
ObjectCreate("Times Up", OBJ_LABEL, 0, 0, 0);
ObjectSet("Times Up", OBJPROP_CORNER, CORNER_RIGHT_LOWER);
ObjectSet("Times Up", OBJPROP_XDISTANCE, 0);
ObjectSet("Times Up", OBJPROP_YDISTANCE, 0);
ObjectSetText("Times Up", "Indicator expired.... Renew or purchase your VIP subsciption", 35, "Arial", clrYellow);
ExpertRemove();
}

   //Account number function to disable EA
string AK=AccountName();

if(
AK!=Accountn1&&AK!=Accountn21&&AK!=Accountn41&&AK!=Accountn61&&AK!=Accountn81&&
AK!=Accountn2&&AK!=Accountn22&&AK!=Accountn42&&AK!=Accountn62&&AK!=Accountn82&&
AK!=Accountn3&&AK!=Accountn23&&AK!=Accountn43&&AK!=Accountn63&&AK!=Accountn83&&
AK!=Accountn4&&AK!=Accountn24&&AK!=Accountn44&&AK!=Accountn64&&AK!=Accountn84&&
AK!=Accountn5&&AK!=Accountn25&&AK!=Accountn45&&AK!=Accountn65&&AK!=Accountn85&&
AK!=Accountn6&&AK!=Accountn26&&AK!=Accountn46&&AK!=Accountn66&&AK!=Accountn86&&
AK!=Accountn7&&AK!=Accountn27&&AK!=Accountn47&&AK!=Accountn67&&AK!=Accountn87&&
AK!=Accountn8&&AK!=Accountn28&&AK!=Accountn48&&AK!=Accountn68&&AK!=Accountn88&&
AK!=Accountn9&&AK!=Accountn29&&AK!=Accountn49&&AK!=Accountn69&&AK!=Accountn89&&
AK!=Accountn10&&AK!=Accountn30&&AK!=Accountn50&&AK!=Accountn70&&AK!=Accountn90&&
AK!=Accountn11&&AK!=Accountn31&&AK!=Accountn51&&AK!=Accountn71&&AK!=Accountn91&&
AK!=Accountn12&&AK!=Accountn32&&AK!=Accountn52&&AK!=Accountn72&&AK!=Accountn92&&
AK!=Accountn13&&AK!=Accountn33&&AK!=Accountn53&&AK!=Accountn73&&AK!=Accountn93&&
AK!=Accountn14&&AK!=Accountn34&&AK!=Accountn54&&AK!=Accountn74&&AK!=Accountn94&&
AK!=Accountn15&&AK!=Accountn35&&AK!=Accountn55&&AK!=Accountn75&&AK!=Accountn95&&
AK!=Accountn16&&AK!=Accountn36&&AK!=Accountn56&&AK!=Accountn76&&AK!=Accountn96&&
AK!=Accountn17&&AK!=Accountn37&&AK!=Accountn57&&AK!=Accountn77&&AK!=Accountn97&&
AK!=Accountn18&&AK!=Accountn38&&AK!=Accountn58&&AK!=Accountn78&&AK!=Accountn98&&
AK!=Accountn19&&AK!=Accountn39&&AK!=Accountn59&&AK!=Accountn79&&AK!=Accountn99&&
AK!=Accountn20&&AK!=Accountn40&&AK!=Accountn60&&AK!=Accountn80&&AK!=Accountn100
){

Alert(AccountName() + ", renew or purchase your VIP subsciption");
SendNotification(AccountName() + ", renew or purchase your VIP subsciption");

ObjectDelete("Times Up2");                                                         
ObjectCreate("Times Up2", OBJ_LABEL, 0, 0, 0);
ObjectSet("Times Up2", OBJPROP_CORNER, CORNER_RIGHT_LOWER);
ObjectSet("Times Up2", OBJPROP_XDISTANCE, 0);
ObjectSet("Times Up2", OBJPROP_YDISTANCE, 50);
ObjectSetText("Times Up2", AccountName() + ", renew or purchase your VIP subsciption", 35, "Arial", clrYellow);

ExpertRemove();
}


//---- indicators setting
SetIndexStyle(0,DRAW_LINE,STYLE_SOLID,1);
SetIndexStyle(1,DRAW_LINE,STYLE_SOLID,1);
SetIndexStyle(2,DRAW_LINE,STYLE_SOLID,1);
SetIndexStyle(3,DRAW_LINE,STYLE_SOLID,1);


//--- set descriptions of horizontal levels
   IndicatorSetString(INDICATOR_LEVELTEXT,0,"Buy Zone"); // 32
   IndicatorSetString(INDICATOR_LEVELTEXT,1,""); // 37
   IndicatorSetString(INDICATOR_LEVELTEXT,2,"Sell Zone"); // 63
   IndicatorSetString(INDICATOR_LEVELTEXT,3,""); // 68
   
   IndicatorSetString(INDICATOR_LEVELTEXT,4,"Major"); // 20
   IndicatorSetString(INDICATOR_LEVELTEXT,5,"Demand"); // 15
   IndicatorSetString(INDICATOR_LEVELTEXT,6,"Zone"); // 10
   
   IndicatorSetString(INDICATOR_LEVELTEXT,7,"Major"); // 90
   IndicatorSetString(INDICATOR_LEVELTEXT,8,"Supply"); // 85
   IndicatorSetString(INDICATOR_LEVELTEXT,9,"Zone"); // 80



IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS));
IndicatorShortName(" JBlanked TDI "+ GetTimeframe());

SetIndexBuffer(0,MA1_Array);
SetIndexLabel(0,"MA1 - RSI "+ MA1_Period);

SetIndexBuffer(1,MA2_Array);
SetIndexLabel(1,"MA2 - RSI "+ MA2_Period);

SetIndexBuffer(2,MA3_Array);
SetIndexLabel(2,"MA3 - RSI "+ MA2_Period);

SetIndexBuffer(3,RSI);
SetIndexLabel(3,"RSI "+ RSI_Period);

return(0);
}



//+------------------------------------------------------------------+
//| On shutdown                                                      |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
  
      ObjectDelete("Times Up");
   ObjectDelete("Times Up2"); 
   
   }
  
  
  
//+------------------------------------------------------------------+
//| Custom indicator iteration function |
//+------------------------------------------------------------------+
int start()
{
int limit = Bars - IndicatorCounted() - 1;

//---- indicator calculation

   for(int i=limit; i>=0; i--)
   {
    RSI[i]= iRSI(NULL,0,RSI_Period,RSI_Applied_Price,i);
    
   }
    
   for(i=limit; i>=0; i--)
   { 
    MA1_Array[i] = iMAOnArray(RSI,0,MA1_Period,0,MA1_Method,i);
    MA2_Array[i] = iMAOnArray(RSI,0,MA2_Period,0,MA2_Method,i);
    MA3_Array[i] = iMAOnArray(RSI,0,MA3_Period,0,MA3_Method,i);

    
   }
   
//    Print ("First iMAOnArray for current bar " + NormalizeDouble( iMAOnArray(RSI,0,MA1_Period,0,MA1_Method,0),4));
//   Print ("Second iMAOnArray for current bar " + NormalizeDouble( iMAOnArray(RSI,0,MA2_Period,0,MA2_Method,0),4)); 
//    Print ("Current RSI = " + RSI[0]);

//----
return(0);


}

//+------------------------------------------------------------------+


string GetTimeframe()

{

 if(_Period == 1)
 
 {
 
 return "1 minute";
 
 }
 

 if(_Period == 5)
 
 {
 
 return "5 minute";
 
 } 

 if(_Period == 15)
 
 {
 
 return "15 minute";
 
 }
 

 if(_Period == 30)
 
 {
 
 return "30 minute";
 
 } 

 if(_Period == 60)
 
 {
 
 return "1 hour";
 
 }
 

 if(_Period == 240)
 
 {
 
 return "4 hour";
 
 } 
 

 if(_Period == 1440)
 
 {
 
 return "Daily";
 
 }  
 
  
   
 else
 
 {
 
 return "Weekly";
 }
 

}