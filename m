Message-ID: <CA78D1B723D8D411AF0300508BDCF74F011454AF@NTCORREO>
From: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Changing the timeslice
Date: Thu, 6 Feb 2003 16:07:10 +0100 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all:
	Linux has a 10 ms timeslice by default. But we need to have 2 or 3
ms timeslice.

	I read that the only thing i need to do is change the HZ value
defined in asm-ppc/param.h (default is 100) and probe in to find the correct
value. Is it true? Is any formula to do it? Is there any problem (except the
schaduling overhead)?
	I read somewhere that i also need to change properly
PROC_CHANGE_PENALTY in asm-ppc/smp.h. But others dont talk about it. If i
need to change it, what is "properly"?


	Can somebody give me some light?
	Thanks to everibody for your help.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
