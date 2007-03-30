Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A21BADDED1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 10:47:24 +1000 (EST)
Date: Thu, 29 Mar 2007 19:43:47 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'fsl-2.6.22' branch
Message-ID: <Pine.LNX.4.64.0703291942510.24833@localhost.localdomain>
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

Please pull from 'fsl-2.6.22' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git fsl-2.6.22

to receive the following updates:

 arch/powerpc/Kconfig                       |    5
 arch/powerpc/boot/dts/mpc832x_rdb.dts      |  291 ++++++
 arch/powerpc/boot/dts/mpc8544ds.dts        |  136 +++
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |   24
 arch/powerpc/configs/mpc832x_rdb_defconfig | 1292 +++++++++++++++++++++++++++++
 arch/powerpc/configs/mpc8544_ds_defconfig  | 1077 ++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/Kconfig        |    9
 arch/powerpc/platforms/83xx/Makefile       |    1
 arch/powerpc/platforms/83xx/mpc832x_mds.c  |    1
 arch/powerpc/platforms/83xx/mpc832x_mds.h  |   19
 arch/powerpc/platforms/83xx/mpc832x_rdb.c  |  138 +++
 arch/powerpc/platforms/83xx/mpc834x_itx.h  |   23
 arch/powerpc/platforms/85xx/Kconfig        |    9
 arch/powerpc/platforms/85xx/Makefile       |    1
 arch/powerpc/platforms/85xx/mpc8544_ds.c   |  144 +++
 arch/powerpc/platforms/86xx/Makefile       |    2
 arch/powerpc/platforms/86xx/mpc86xx_pcie.c |  173 ---
 arch/powerpc/platforms/86xx/pci.c          |    2
 arch/powerpc/platforms/Kconfig             |    2
 arch/powerpc/sysdev/Makefile               |    1
 arch/powerpc/sysdev/fsl_pcie.c             |  171 +++
 arch/powerpc/sysdev/fsl_pcie.h             |   94 ++
 arch/powerpc/sysdev/qe_lib/Kconfig         |   10
 arch/powerpc/sysdev/qe_lib/ucc_slow.c      |    4
 drivers/net/Kconfig                        |    9
 include/asm-powerpc/immap_86xx.h           |   75 -
 26 files changed, 3402 insertions(+), 311 deletions(-)

Jon Loeliger (3):
      [POWERPC] 86xx/85xx: Move 8641 PCI-Express to arch/powerpc/sysdev/fsl_pcie.c.
      [POWERPC] 85xx: Add initial MPC8544 DS platform files.
      [POWERPC] 85xx: Add initial MPC8544DS basic port defconfig.

Kumar Gala (1):
      [POWERPC] 83xx: Removed dead header

Michael Barkowski (1):
      [POWERPC] 83xx: Add MPC832x RDB board support.

Robert P. J. Day (1):
      [POWERPC] 83xx: Delete unused header file.

Timur Tabi (2):
      [POWERPC] QE: automatically select QE options
      [POWERPC] QE: fix invalid pointer usage in ucc_slow_init()

Zang Roy-r61911 (1):
      [POWERPC] 86xx/85xx: Unify Freescale PCI Express memory map registers structure

Zhang Wei (1):
      [POWERPC] 86xx: Added 2nd PCI-Ex controller support for MPC8641 HPCN to DTS.
