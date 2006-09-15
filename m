Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 3639067B67
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 09:25:08 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Discontiguous Memory
Date: Sat, 16 Sep 2006 01:24:57 +0200
References: <6332580.post@talk.nabble.com>
In-Reply-To: <6332580.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609160124.57280.arnd@arndb.de>
Cc: jbahr <jbahr@set-software-services.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Friday 15 September 2006 22:22 schrieb jbahr:
> Are this really a problem or is there kernel provision for the PPC for
> discontiguous real memory DRAM space?
>
> Any comments would be VERY appreciated.

You probably want to enable the CONFIG_ARCH_SPARSEMEM_ENABLE
option, which is currently dependant on CONFIG_PPC64.

Look in the early_init_dt_scan_memory function (arch/powerpc/kernel/prom.c)
for how to layout the "memory" nodes in your device tree.

	Arnd <><
