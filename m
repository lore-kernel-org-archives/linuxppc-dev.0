Return-Path: <linuxppcdev@qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id E982D67C4F
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 03:16:57 +1100 (EST)
Date: 14 Dec 2006 16:16:56 -0000
Message-ID: <20061214161656.31058.qmail@kunk.qbjnet.com>
From: Bob Brose <linuxppcdev@qbjnet.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes, that did it. The ganged irq is back on 25 now and everything
works. Thanks!

Bob

Ben Said:

> What about that patch ? If it doesn't help, please send me a new dmesg
> log of 2.6.19 with patches -and- with #defin'ing DEBUG in
> arch/powerpc/kernel/pci_32.c and prom_parse.c.
> 
> Index: linux-work/arch/powerpc/kernel/prom_parse.c
> ===================================================================
.
.
.
