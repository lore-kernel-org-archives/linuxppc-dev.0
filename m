Message-ID: <3BD3E93E.7090403@gmx.ch>
Date: Mon, 22 Oct 2001 11:39:10 +0200
From: Stefan Wanner <stefan.wanner@gmx.ch>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: invert lcd on mpc823l
References: <20011022092446.E745010CD6@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


i'm using a tq components board (bought it from you) the pins are
connected this way:


Pinbelegung zum Anschluss des SHARP LQ64D341 an TQM823L Board
-------------------------------------------------------------

TQM823L         ------------->      SHARP LQ64D341 TFT

Stecker Pin     Signal              Pin     Signal

X11                                             1
X11     20 ---- SHIFT/CLK   ----->  2       CK
X11     14 ---- FRAME/HSYNC ----->  3       Hsync
X11     16 ---- FRAME/VSYNC ----->  4       Vsync
X11                                 5
X11                                 6       R0    RED (LSB)
X11                                 7       R1    RED
X11     5  ---- LCD_A       ----->  8       R2    RED
X11     26 ---- LD2         ----->  9       R3    RED
X11     25 ---- LD1         ----->  10      R4    RED
X11     24 ---- LD0         ----->  11      R5    RED
X11                                 12      GND
X11                                 13      G0    GREEN (LSB)
X11                                 14      G1    GREEN
X11     3  ---- LCD_B       ----->  15      G2    GREEN
X11     29 ---- LD5         ----->  16      G3    GREEN
X11     28 ---- LD4         ----->  17      G4    GREEN
X11     27 ---- LD3         ----->  18      G5    GREEN
X11                                 19      GND
X11                                 20      B0    BLUE (LSB)
X11                                 21      B1    BLUE
X11     1  ---- LCD_C       ----->  22      B2    BLUE
X11     32 ---- LD8         ----->  23      B3    BLUE
X11     31 ---- LD7         ----->  24      B4    BLUE
X11     30 ---- LD6         ----->  25      B5    BLUE
X11     19 ---- GND         ------  26      GND
X11                                 27      ENAB  Siehe Manual 7-2
(nicht auf High!)
X11     7  ---- VCC5V       ------  28      VCC
X11                                 29
X11                                 30      R/L   Anzeigemodi  Siehe
Manual Seite LCY-99193-4
X11                                 31      U/D   Anzeigemodi  Siehe
Manual Seite LCY-99193-4


Wolfgang Denk wrote:

> In message <3BD3E484.1030909@gmx.ch> you wrote:
>
>>i'm using a sharp LQ64D341 tft lcd on a MPC823L board with the
>>
>
> Is this a custom board, or some standard product?
>
>
>>kernelsources from denx.de. now when i use /dev/tty0 (the frambuffer
>>character device) the output apears inverse (white background, black
>>text). the tux in the upper left corner has also strange colors (looks
>>also like inverse). how can i fix that?
>>
>
> Are you sure that all wires are connected properly?
>
> Works here - on a TQM823L-E.
>
> Wolfgang Denk
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
