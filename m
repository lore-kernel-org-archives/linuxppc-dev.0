Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8F86DDED9
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 08:54:06 +1000 (EST)
Date: Wed, 23 Apr 2008 17:50:05 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'powerpc-next' branch
Message-ID: <Pine.LNX.4.64.0804231749530.14182@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'powerpc-next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git powerpc-next

to receive the following updates:

 arch/powerpc/kernel/cpu_setup_6xx.S   |    8
 arch/ppc/8260_io/fcc_enet.c           |   19
 arch/ppc/8xx_io/enet.c                |   23
 arch/ppc/Kconfig                      |   82 --
 arch/ppc/configs/ads8272_defconfig    |  930 ----------------------------------
 arch/ppc/configs/mpc86x_ads_defconfig |  633 -----------------------
 arch/ppc/configs/mpc885ads_defconfig  |  622 ----------------------
 arch/ppc/platforms/Makefile           |    4
 arch/ppc/platforms/fads.h             |   25
 arch/ppc/platforms/mpc8272ads_setup.c |  367 -------------
 arch/ppc/platforms/mpc885ads.h        |   93 ---
 arch/ppc/platforms/mpc885ads_setup.c  |  476 -----------------
 arch/ppc/platforms/pq2ads.c           |   53 -
 arch/ppc/platforms/pq2ads.h           |   94 ---
 arch/ppc/platforms/pq2ads_pd.h        |   32 -
 arch/ppc/syslib/m8260_setup.c         |    6
 arch/ppc/syslib/m82xx_pci.c           |   38 -
 arch/ppc/syslib/m8xx_setup.c          |   10
 include/asm-ppc/mpc8260.h             |    4
 include/asm-ppc/mpc8xx.h              |    4
 20 files changed, 9 insertions(+), 3514 deletions(-)

Kumar Gala (3):
      [PPC] Remove mpc8272 ads board from arch/ppc
      [PPC] Remove mpc885ads and mpc86x ads boards from arch/ppc
      [POWERPC] ppc32: Fix errata for 603 CPUs
