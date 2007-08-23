Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3CB0FDDF1D
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 14:16:29 +1000 (EST)
Date: Wed, 22 Aug 2007 23:16:39 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.24' branch
Message-ID: <Pine.LNX.4.64.0708222314420.8543@blarg.am.freescale.net>
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

Please pull from 'for-2.6.24' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.24

This has been rebased against your latest for-2.6.24 branch and includes
the removal of <asm/bootinfo.h> to drivers/macintosh/adb-iop.c.

All other driver related patches have been sent to their maintainers.
(IDE, MTD, NET).

I think this is as good as it gets.

to receive the following updates:

 arch/powerpc/Makefile                             |   17
 arch/powerpc/kernel/setup_32.c                    |    2
 arch/powerpc/platforms/52xx/lite5200.c            |    1
 arch/powerpc/platforms/82xx/m82xx_pci.h           |    2
 arch/powerpc/platforms/82xx/mpc82xx.c             |    1
 arch/powerpc/platforms/82xx/mpc82xx_ads.c         |    1
 arch/powerpc/platforms/82xx/pq2ads.h              |    1
 arch/powerpc/platforms/83xx/mpc832x_mds.c         |    1
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |    1
 arch/powerpc/platforms/83xx/mpc834x_mds.c         |    1
 arch/powerpc/platforms/83xx/mpc836x_mds.c         |    1
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |    1
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |    1
 arch/powerpc/platforms/8xx/m8xx_setup.c           |    4
 arch/powerpc/platforms/8xx/mpc86xads.h            |    1
 arch/powerpc/platforms/8xx/mpc86xads_setup.c      |    1
 arch/powerpc/platforms/8xx/mpc885ads.h            |    1
 arch/powerpc/platforms/8xx/mpc885ads_setup.c      |    1
 arch/powerpc/platforms/chrp/gg2.h                 |   61 +
 arch/powerpc/platforms/chrp/pci.c                 |    2
 arch/powerpc/platforms/chrp/setup.c               |    2
 arch/powerpc/platforms/chrp/smp.c                 |    1
 arch/powerpc/platforms/embedded6xx/linkstation.c  |    3
 arch/powerpc/platforms/embedded6xx/ls_uart.c      |    4
 arch/powerpc/platforms/embedded6xx/mpc10x.h       |  180 +++
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    1
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h |   21
 arch/powerpc/platforms/powermac/bootx_init.c      |    1
 drivers/macintosh/adb-iop.c                       |    1
 drivers/macintosh/ans-lcd.c                       |    3
 drivers/macintosh/ans-lcd.h                       |   11
 include/asm-powerpc/8xx_immap.h                   |  564 +++++++++
 include/asm-powerpc/commproc.h                    |  692 ++++++++++++
 include/asm-powerpc/cpm2.h                        | 1248 ++++++++++++++++++++++
 include/asm-powerpc/highmem.h                     |  135 ++
 include/asm-powerpc/hydra.h                       |  102 +
 include/asm-powerpc/immap_cpm2.h                  |  648 +++++++++++
 include/asm-powerpc/kgdb.h                        |   57 +
 include/asm-powerpc/mpc52xx_psc.h                 |  191 +++
 include/asm-ppc/ans-lcd.h                         |   11
 40 files changed, 3900 insertions(+), 78 deletions(-)

Kumar Gala (3):
      [POWERPC] Remove old includes from arch/ppc
      [POWERPC] Copy over headers from arch/ppc to arch/powerpc that we need
      [POWERPC] Stop include asm-ppc when building ARCH=powerpc for ppc32
