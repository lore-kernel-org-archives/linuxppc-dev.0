Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Jaap-Jan Boor <jjboor@aimsys.nl>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8270 performance
Date: Mon, 8 Dec 2003 18:51:51 -0200
References: <Pine.GSO.4.33.0312082046590.3461-100000@sun064.aimsys.nl>
In-Reply-To: <Pine.GSO.4.33.0312082046590.3461-100000@sun064.aimsys.nl>
MIME-Version: 1.0
Message-Id: <200312081851.51601.scop@digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Monday 08 December 2003 17:50, Jaap-Jan Boor wrote:
> Hi,
>
> I've a modified 2.4.22 kernel built with gcc 3.3.2
> running on a 8270 system here and see the following
> cpuinfo:
>
> # cat /proc/cpuinfo
> cpu            : 82xx (Hip7)
> core clock     : 266 MHz
> CPM clock      : 166 MHz
> bus clock      : 66 MHz
> revision       : 32.17 (pvr 8082 2011)
> bogomips       : 175.71
>
> I would expect the bogomips number
> to be somewhere near the core clock
> (like 8xx).

Well, I think the numbers are pretty fair, assuming that the bogomips number
reflect a certain amount of external memory accesses at 66 MHz external bus
clock.

>
> Any experience? Thanks

Yes, we have a 8250' powered custom board running at:
 - cpu_clk  196608000, cpm_clk  163840000, bus_clk   65536000

Our ported good old PPCBoot 1.1.5 reports:
CPU:   MPC8260 (Rev 14, Mask unknown [immr=0x0062,k=0x002d]) at 196.608 MHz

And the 2.4.21 kernel:
Calibrating delay loop... 130.66 BogoMIPS

HTH,

-Scop.

>
> Jaap-Jan
>
> ---
> J.G.J. Boor			  Anton Philipsweg 1
> Software Engineer		  1223 KZ Hilversum
> AimSys bv              		  tel. +31 35 689 1941
> Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
