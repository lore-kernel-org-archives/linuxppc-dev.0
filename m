Message-ID: <3B8AB925.D2DB3E90@minolta-qms.com>
Date: Mon, 27 Aug 2001 15:18:29 -0600
From: Mark Pilon <mark.pilon@minolta-qms.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: how to dump other regs via abatron-bdi / gdb ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm accustomed to printing general purpose registers: print $r0
and the like --

bringing up a board (before establishing an exception vector table)
I'm getting some unknown exception -- how do I print the ESR (and
other SPRs for that matter ) ??

I'm using montavista ppc_4xx-gdb -- GNU gdb 5.0 and abatron bdi/gdb:
BDI Type : BDI2000 (SN: 93170608)
Loader   : V1.04
Firmware : V1.05 bdiGDB for PPC400
Logic    : V1.01 PPC400

I suspect the problem is an incomplete bdi board config file,
but it'd help to be able to figure out what's missing ...

thanks,

Mark
--
Mark Pilon

Minolta-QMS
5661 Airport Blvd, Ste A.
Boulder, CO  80301

1-303-443-5505 ext. 326; fax: 303-443-7107

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
