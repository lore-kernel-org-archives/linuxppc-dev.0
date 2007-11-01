Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 9DDF0DDE9A
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 01:54:23 +1100 (EST)
Message-ID: <4729E897.1070400@harris.com>
Date: Thu, 01 Nov 2007 10:54:15 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Please pull from 'for-2.6.24' branch of 4xx tree
References: <20071101081057.46a9bfdd@weaponx.rchland.ibm.com>
In-Reply-To: <20071101081057.46a9bfdd@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is this something anyone can do?  I tried:

git pull 
master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git 
for-2.6.24

but it asks me for a password.  I'd like to be able to follow your 
development branch, so I can contribute patches where appropriate.

    Steve


Josh Boyer wrote:
> Hi Paul,
>
> Please pull from:
>
>  master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.24
>
> to pick up a few items for 2.6.24.  Mostly bugfixes, but also some
> documentation updates and a few bootwrapper changes.  Particularly important
> is the TLB flushing fix from Ben.
>
> josh
>
> Benjamin Herrenschmidt (2):
>       [POWERPC] 4xx: Fix 4xx flush_tlb_page()
>       [POWERPC] 4xx: Deal with 44x virtually tagged icache
>
> Grant Likely (5):
>       [POWERPC] bootwrapper: Allow wrapper script to execute verbosely
>       [POWERPC] bootwrapper: Bail from script if any command fails
>       [POWERPC] Device tree bindings for Xilinx devices
>       [POWERPC] Uartlite: speed up console output
>       [POWERPC] ppc405 Fix arithmatic rollover bug when memory size under 16M
>
> Roel Kluin (1):
>       [POWERPC] allocation fix in ppc/platforms/4xx/luan.c
>
> Steven A. Falco (1):
>       [POWERPC] 4xx: Fix Walnut DTS interrupt property
>
> Valentine Barshak (1):
>       [POWERPC] 4xx: Workaround for the 440EP(x)/GR(x) processors identical PVR 
>
>  Documentation/powerpc/booting-without-of.txt |  261 ++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/walnut.dts             |    4 +-
>  arch/powerpc/boot/wrapper                    |   32 ++--
>  arch/powerpc/kernel/cputable.c               |   36 +++-
>  arch/powerpc/kernel/entry_32.S               |   23 +++
>  arch/powerpc/kernel/misc_32.S                |   32 +++-
>  arch/powerpc/kernel/prom.c                   |   12 ++
>  arch/powerpc/mm/40x_mmu.c                    |   17 +-
>  arch/powerpc/mm/44x_mmu.c                    |    1 +
>  arch/powerpc/mm/fault.c                      |    2 +-
>  arch/powerpc/mm/mmu_decl.h                   |    4 +-
>  arch/ppc/kernel/entry.S                      |   23 +++
>  arch/ppc/kernel/misc.S                       |   31 +++-
>  arch/ppc/mm/44x_mmu.c                        |    1 +
>  arch/ppc/mm/4xx_mmu.c                        |   17 +-
>  arch/ppc/mm/fault.c                          |    2 +-
>  arch/ppc/mm/mmu_decl.h                       |    4 +-
>  arch/ppc/platforms/4xx/ebony.c               |    2 +-
>  arch/ppc/platforms/4xx/luan.c                |    7 +-
>  arch/ppc/platforms/4xx/ocotea.c              |    2 +-
>  arch/ppc/platforms/4xx/taishan.c             |    2 +-
>  drivers/serial/uartlite.c                    |   10 +-
>  include/asm-powerpc/pgtable-ppc32.h          |   13 ++
>  include/asm-powerpc/tlbflush.h               |   12 +-
>  24 files changed, 472 insertions(+), 78 deletions(-)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>   
