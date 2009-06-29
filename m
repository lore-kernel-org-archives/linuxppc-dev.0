Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.248])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 1053BB7095
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 06:47:19 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so1502900rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 13:47:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A49249C.5080101@freescale.com>
References: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
	<4A44FD90.2040607@freescale.com>
	<97dd5fd20906261012h34a85b33j9183eb9e41ed1181@mail.gmail.com>
	<1ba63b520906271401u5d012b0ex87a48820b616ae48@mail.gmail.com>
	<97dd5fd20906291053u1a07c3afla1c2ea0590d01f1e@mail.gmail.com>
	<4A4901A8.5010402@mlbassoc.com>
	<97dd5fd20906291113t5ea98285h2db6379ff1a940c@mail.gmail.com>
	<4A490AE4.7000509@freescale.com>
	<97dd5fd20906291324jf085addjaa61ff48dfca3d04@mail.gmail.com>
	<4A49249C.5080101@freescale.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Mon, 29 Jun 2009 15:46:58 -0500
Message-ID: <97dd5fd20906291346s3ee60edbr1863c27280ae373c@mail.gmail.com>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Gary Thomas <gary@mlbassoc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Change "root=" to "console=".
Thank you for clarifying.

I tried this but I get the following in my memory dump:

<6>Using Embedded Planet EP88xC ??achine description?
<5>Linux ver??ion 2.6.30-rc2-01402-gd4e2f68-d??rty
(devone@localhost.localdoma??n) (gcc version 4.2.2) #1 Mon J??n 29
11:35:28 CDT 2009?
<7>Top o?? RAM: 0x4000000' Total RAM: 0x4??00000?
<7>Memory hole size: 0MB???
>4>Zone PFN ranges:?
<4>  DMA    ?? 0x00000000 -> 0x00004000?
<4>  ??ormal   0x00004000 -> 0x0000400???
<4>Movable zone start PFN for ??ach node?
<4>early_node_map[1] a??tive PFN ranges?
<4>    0: 0x000??0000 -> 0x00004000?
<7>On node 0??totalpages: 16384?
<7>free_area_??nit_node: node 0' pgdat c021bf7??' node_mem_map c023f000?
<7>  DM?? zone: 128 pages used for memma???
<7>  DMA zone: 0 pages reserve???
<7>  DMA zone: 16256 pages' LI??O batch:3?
<6>MMU: Allocated 72 ??ytes of context maps for 16 con??exts?
<4>Built 1 zonelists in Zo??e order' mobility grouping on. ??Total pages: 16256?
<5>Kernel co??mand line: console=ttyCPM0'9600??8 loglevel=7?
<6>NR_IRQS:512?
<7>??rq: irq 5 on host /soc@f0000000??interrupt-controller@0 mapped
t?? virtual irq 16?
<7>irq: irq 0 o?? host /soc@f0000000/cpm@9c0/int??rrupt-controller@930
mapped to ??irtual irq 17?
<4>PID hash table??entries: 256 (order: 8' 1024 by??es)?
<4>Decrementer Frequency = ??x7bfa48?
<7>irq: irq 15 on host ??soc@f0000000/interrupt-controll??r@0 mapped
to virtual irq 18?
<7??time_init: decrementer frequenc?? = 8.125000 MHz?
<7>time_init: p??ocessor frequency   = 130.00000?? MHz?
<6>clocksource: timebase m??lt[1ec4ec4f] shift[22] register??d?
<7>clockevent: decrementer mu??t[214] shift[16] cpu[0]?
<7>irq:??irq 4 on host /soc@f0000000/cpm??9c0/interrupt-controller@930
ma??ped to virtual irq 19?
<6>consol?? [ttyCPM0] enabled

Seems like at that point it begins to redirect output to ttyCPM0 but
still nothing showing on the console...
