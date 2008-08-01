Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id 35C03DDFBB
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 01:15:05 +1000 (EST)
Date: Fri, 1 Aug 2008 18:14:01 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Sean MacLennan <smaclennan@pikatech.com>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Valentine Barshak <vbarshak@ru.mvista.com>,
	Stefan Roese <sr@denx.de>, mporter@kernel.crashing.org,
	paulus@samba.org, benh@kernel.crashing.org
Subject: platforms/44x/warp-nand.c bogosity
Message-ID: <20080801151401.GC24735@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/platforms/44x/warp-nand.c was added this year and updated 
quite recently.

warp-nand.c is empty unless CONFIG_MTD_NAND_NDFC=y.

MTD_NAND_NDFC depends on !PPC_MERGE.

!PPC_MERGE can never be true on PPC now that arch/ppc/ got removed.

So warp-nand.c is dead code, but that does not seem to be intentionally?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
