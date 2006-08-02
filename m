Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99EF867B74
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 00:42:30 +1000 (EST)
To: Adrian Cox <adrian@humboldt.co.uk>
Subject: Re: SMP in 32-bit arch/powerpc 
In-Reply-To: Your message of "Wed, 02 Aug 2006 09:25:45 BST."
	<1154507145.24203.0.camel@localhost.localdomain>
References: <1154507145.24203.0.camel@localhost.localdomain> 
Date: Wed, 02 Aug 2006 09:42:24 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1G8HvV-0007o7-0C@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Adrian Cox mumbled:
> Is anybody else having problems with 32-bit SMP support in arch/powerpc?
> I'm using 2.6.17 as my current base, because I've not yet merged the
> latest mpic changes.
> 
> I'm currently bringing up a dual-7448 board, and when I build the kernel
> with CONFIG_SMP, the bootmem allocator corrupts the device tree. The
> strange thing is, this still happens when I don't start the second CPU.
> Kernels built without CONFIG_SMP run flawlessly on the same hardware.

As a point of reference, the 32-bit 8641 HPCN seems to be working fine
with both CONFIG_SMP and the device tree mechanism in place.  It was working
both before and after the IRQ changes.

Can you nail down any more specifics on how it is failing or where
the corruption happens?

jdl
