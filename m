Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B139DDE034
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 07:38:29 +1000 (EST)
Date: Tue, 21 Apr 2009 16:38:24 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'merge' branch for 2.6.30
Message-ID: <Pine.LNX.4.64.0904211638001.13898@localhost.localdomain>
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

Please pull from 'merge' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

to receive the following updates:

 arch/powerpc/configs/85xx/mpc8536_ds_defconfig | 1802 ------------------------
 arch/powerpc/configs/85xx/mpc8544_ds_defconfig | 1802 ------------------------
 arch/powerpc/configs/85xx/mpc8568mds_defconfig | 1309 -----------------
 arch/powerpc/configs/85xx/mpc8572_ds_defconfig | 1794 ------------------------
 arch/powerpc/configs/mpc85xx_defconfig         |  252 +--
 arch/powerpc/configs/mpc85xx_smp_defconfig     | 1829 +++++++++++++++++++++++++
 arch/powerpc/platforms/fsl_uli1575.c           |    5
 arch/powerpc/sysdev/fsl_rio.c                  |   28
 8 files changed, 1959 insertions(+), 6862 deletions(-)

Anton Vorontsov (1):
      fsl_rio: Pass the proper device to dma mapping routines

Kumar Gala (4):
      powerpc/85xx: Updated generic mpc85xx_defconfig
      powerpc/85xx: Enabled a bunch of FSL specific drivers/options
      powerpc/85xx: Added SMP defconfig
      powerpc/85xx: Remove defconfigs that mpc85xx_{smp_}defconfig cover

Timur Tabi (1):
      powerpc: don't disable SATA interrupts on Freescale MPC8610 HPCD
