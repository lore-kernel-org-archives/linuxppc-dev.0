Message-ID: <3BD8338B.B93FCF3C@laposte.net>
Date: Thu, 25 Oct 2001 17:45:15 +0200
From: "ibm405.linux" <ibm405.linux@laposte.net>
MIME-Version: 1.0
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: 405GP Dhrystone Benchmark
References: <AEEDJHMEPHBIHBAHOOCDIELKCAAA.ogoh@asu.edu> <3BD82D8A.F0DC3B77@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Does anyone perform Dhrystone 2.1 benchmark with a 405GP  ?
I've tried and i got : 172 Mips  (Walnut board @200Mhz, HHL2.0).
I've also tried to run the same benchmark with the same board with the
basic_os and the ibm "highcppc" compiler and i found
237 Mips (the 405GP specifications give 282 Mips @200Mhz, they told me that
was obtained with a Diab compiler).
Is there any reason my result (172 Mips) is so far from ~240 Mips.
(i've used  : ppc_405-gcc   -DUNIX -DROPT -O2 -fomit-frame-pointer   dhry21a.c
dhry21b.c timers_b.c -o dhry21 )

thanks,
Phil.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
