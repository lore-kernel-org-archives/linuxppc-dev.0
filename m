From: adharankar@attbi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem: SDRAM configuration and refresh
Date: Tue, 11 Jun 2002 19:22:51 +0000
Message-Id: <20020611192251.WCYS2751.rwcrmhc52.attbi.com@rwcrwbc57>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,

I am trying to getup a Scout based board with
64MB SDRAM, and could use any recommendations
to fix this problem:

If I set the refresh-enable bit in the PSDMR,
the chipselect for flash and other devices
vanishes: consequently, this startup code
ends up executing junk. At this point if I try
to look at the flash from the BDI2000, the
flash cannot be seen.



On the other hand, if I initialize the SDRAM
without setting this refresh-enable bit, ppcboot
(the code using it) comes up and am able to run
commands etc. However, the problem now is that
without the SDRAM refresh we run into memory
corruption problem (mtest will fail) and a system
hang.

Its interesting to note that as long as memory
is accessed frequently (say via mtest), the
corruption is not see at that address. Also, an
idle system almost hangs in a very short time,
whereas an active one with mtest will continue on.



Best regards,
-Arun.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
