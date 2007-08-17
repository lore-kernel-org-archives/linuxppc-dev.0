Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B3D4DDEE3
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 17:17:26 +1000 (EST)
Date: Fri, 17 Aug 2007 02:17:41 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.24' branch
Message-ID: <Pine.LNX.4.64.0708170215590.15311@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Please pull from 'for-2.6.24' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.24

It would be good to get these changes in ASAP as a baseline for other work
that might need to move other files over to asm-powerpc or other clean
ups.

to receive the following updates:

 arch/powerpc/Makefile                        |   23
 arch/powerpc/kernel/setup_32.c               |    2
 arch/powerpc/platforms/52xx/lite5200.c       |    1
 arch/powerpc/platforms/82xx/mpc82xx.c        |    1
 arch/powerpc/platforms/82xx/mpc82xx_ads.c    |    1
 arch/powerpc/platforms/82xx/pq2ads.h         |    1
 arch/powerpc/platforms/83xx/mpc832x_mds.c    |    1
 arch/powerpc/platforms/83xx/mpc834x_itx.c    |    1
 arch/powerpc/platforms/83xx/mpc834x_mds.c    |    1
 arch/powerpc/platforms/83xx/mpc836x_mds.c    |    1
 arch/powerpc/platforms/85xx/mpc85xx_cds.c    |    1
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |    1
 arch/powerpc/platforms/8xx/m8xx_setup.c      |    4
 arch/powerpc/platforms/8xx/mpc86xads.h       |    1
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |    1
 arch/powerpc/platforms/8xx/mpc885ads.h       |    1
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    1
 arch/powerpc/platforms/chrp/smp.c            |    1
 arch/powerpc/platforms/embedded6xx/ls_uart.c |    1
 arch/powerpc/platforms/powermac/bootx_init.c |    1
 include/asm-powerpc/8xx_immap.h              |  564 ++++++++++++
 include/asm-powerpc/commproc.h               |  692 ++++++++++++++
 include/asm-powerpc/cpm2.h                   | 1248 +++++++++++++++++++++++++++
 include/asm-powerpc/gg2.h                    |   61 +
 include/asm-powerpc/highmem.h                |  135 ++
 include/asm-powerpc/hydra.h                  |  102 ++
 include/asm-powerpc/immap_cpm2.h             |  648 ++++++++++++++
 include/asm-powerpc/kgdb.h                   |   57 +
 include/asm-powerpc/m8260_pci.h              |  187 ++++
 include/asm-powerpc/mpc10x.h                 |  180 +++
 include/asm-powerpc/mpc52xx_psc.h            |  191 ++++
 31 files changed, 4075 insertions(+), 36 deletions(-)

Kumar Gala (3):
      [POWERPC] Remove old includes from arch/ppc
      [POWERPC] Copy over headers from arch/ppc to arch/powerpc that we need
      [POWERPC] Stop include asm-ppc when building ARCH=powerpc for ppc32
