CON
  _clkmode        = xtal1 + pll16x
  _xinfreq        = 5_000_000

CON

  pin_CLK = 0  ' Purple
  pin_OE  = 1  ' Yellow
  pin_LAT = 2  ' Brown
  pin_A   = 3  ' White
  
  pin_B   = 4  ' White
  pin_C   = 5  ' White
  pin_D   = 6  ' White
  pin_r1  = 7  ' Red
  
  pin_r2  = 8  ' Red
  pin_g1  = 9  ' Green
  pin_g2  = 10 ' Green
  pin_b1  = 11 ' Blue
  
  pin_b2  = 12 ' Blue
    
OBJ     
    PST      : "Parallax Serial Terminal"      

VAR  


PUB Main | i

  dira[0]  := 1  
  dira[1]  := 1
  dira[2]  := 1
  dira[3]  := 1
  dira[4]  := 1
  dira[5]  := 1
  dira[6]  := 1
  dira[7]  := 1
  dira[8]  := 1
  dira[9]  := 1
  dira[10] := 1
  dira[11] := 1
  dira[12] := 1
    
  PauseMSec(2000)
  PST.start(115200)  

  outa[pin_OE] := 1
  outa[pin_LAT] := 0
  outa[pin_CLK] := 0
  
  PauseMSec(1000)

  PST.str(string("Clocking in data",13))
  repeat i from 0 to 10
    outa[pin_CLK] := 1
    PauseMSec(100)
    outa[pin_CLK] := 0
    PauseMSec(100)

  PST.str(string("Latching",13)) 
  outa[pin_LAT] := 1
  PauseMSec(100)
  outa[pin_LAT] := 0  
  PauseMSec(100)

  PST.str(string("Displaying",13)) 
  repeat
    outa[pin_OE] := 0
    PauseMSec(100)
    outa[pin_OE] := 1
    PauseMSec(100)

  repeat

    repeat i from 0 to 3
      outa := i
      PauseMSec(100)

  repeat
  
    ' Clock in 3 of them
    repeat i from 1 to 7
      outa[pin_LAT] := 1
      PauseMSec(500)   
      outa[pin_LAT] := 0
      PauseMSec(500)   
     
    ' Toggle the latch
    outa[pin_LAT] := 1
    PauseMSec(500)   
    outa[pin_LAT] := 0
    PauseMSec(500)   
     
    ' Show the display
    outa[pin_OE] := 0
    PauseMSec(500)          
    
      
PRI PauseMSec(Duration)
  waitcnt(((clkfreq / 1_000 * Duration - 3932) #> 381) + cnt)

DAT