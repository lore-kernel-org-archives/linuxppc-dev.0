Return-Path: <jbahr@set-software-services.com>
Received: from set-software-services.com (jbahr168.dsl.frii.net
	[216.17.181.168]) by ozlabs.org (Postfix) with ESMTP id 8199A67B5B
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 09:38:02 +1000 (EST)
Received: from cojlb266 ([192.168.0.57])
	by set-software-services.com (set-software-services.com
	[192.168.0.218]) (MDaemon.PRO.v8.1.4.R)
	with ESMTP id md50000168992.msg
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 17:31:19 -0600
From: "Jeffery Bahr" <jbahr@set-software-services.com>
To: "'Arnd Bergmann'" <arnd@arndb.de>,
	<linuxppc-dev@ozlabs.org>
Subject: RE: Discontiguous Memory
Date: Fri, 15 Sep 2006 17:31:13 -0600
Message-ID: <0fa201c6d91f$087ed060$3900a8c0@headquarters.setsoftwareservices.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200609160124.57280.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks, Arnd.  As we're running a 32-bit 8548, looks like we might not be
able to enable sparse memory maps.

Good thought, though.

J 

-----Original Message-----
From: Arnd Bergmann [mailto:arnd@arndb.de] 
Sent: Friday, September 15, 2006 5:25 PM
To: linuxppc-dev@ozlabs.org
Cc: jbahr
Subject: Re: Discontiguous Memory

Am Friday 15 September 2006 22:22 schrieb jbahr:
> Are this really a problem or is there kernel provision for the PPC for 
> discontiguous real memory DRAM space?
>
> Any comments would be VERY appreciated.

You probably want to enable the CONFIG_ARCH_SPARSEMEM_ENABLE option, which
is currently dependant on CONFIG_PPC64.

Look in the early_init_dt_scan_memory function (arch/powerpc/kernel/prom.c)
for how to layout the "memory" nodes in your device tree.

	Arnd <><
