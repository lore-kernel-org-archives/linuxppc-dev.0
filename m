Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 0D1D6DDFFA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 03:25:24 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: linux/powerpc memory management
Date: Thu, 10 Jul 2008 19:25:08 +0200
References: <d2b9ccd90807092114kc1883d2ud33c09c245d94d86@mail.gmail.com>
	<48762608.3060605@freescale.com>
	<d2b9ccd90807101006v79658fcateb5af4c83fc728da@mail.gmail.com>
In-Reply-To: <d2b9ccd90807101006v79658fcateb5af4c83fc728da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807101925.08657.arnd@arndb.de>
Cc: Scott Wood <scottwood@freescale.com>,
	sumedh tirodkar <sumedhtirodkar@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 10 July 2008, sumedh tirodkar wrote:
> by pointers i meant any documentation of design as to how exactly the memory
> management is done...
> how does linux use hardware features provided by powerpc for protection
> between tasks and kernel,etc...
> sorry for not being more specific previously...
> 

It depends on what platform you want to look at, powerpc64, powerpc32 classic
and powerpc32 book E are very different, but you'll see that in the code.

arch/powerpc/mm/hash*
arch/powerpc/mm/pgtable*
arch/powerpc/mm/mem.c
arch/powerpc/mm/ppc_mmu_32.c
arch/powerpc/mm/slb*
arch/powerpc/mm/stab.c
arch/powerpc/mm/tlb*
include/asm-powerpc/mmu*
include/asm-powerpc/pgalloc*
include/asm-powerpc/pgtable*

That should cover all you need to know.

	Arnd <><
