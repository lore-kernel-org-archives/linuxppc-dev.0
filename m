Message-Id: <200201171036.EAA02575@lists.linuxppc.org>
Date: Thu, 17 Jan 2002 18:37:27 +0800
From: =?GB2312?Q?=D7=DE=CC=CE?= <stone@pocketix.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: mppmc8240:how to turn  PROGMODE mode on?
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello:
   i use sandpoint3 and mppmc8240(unity ). When i use fupdate to write linux kernel into flash.
  DINK32_KAHLUA >>fu -l 100000 FF700000 100000
  PPMC Local Flash Programmer
  Are you sure? y
  Check flash type: Unknown, Manu. 90, Device 4c
Make sure the PROGMODE switch is ON
  ERROR : FLASH error.


   i read the unity_x2.pdf carefully. but i can't find the PROGMODE switch.There are only two
switch on the process board. One is sw2 ,the other is sw3. The sw2 is
"system speed setting" .My setting is "01111",(1 means on,right). the sw3 is "user configuration
setting". My setting is "10010"
    position  value  mean
    sw3-1       1     pci bus           ROM location
    sw3-2       0	  independant       free agent
	sw3-3		0	  map B(chrp)       memory map
    sw3-4       1     enable             debug
    sw3-5       0     disable           local reset

    Do i ignore something? Could you give me some advice? Thanks for you help.



　　　　　　　　　　　　　　stone@pocketix.com
　　　　　　　　　　　　　　　　　2002-01-17

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
