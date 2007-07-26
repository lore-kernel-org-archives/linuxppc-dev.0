Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D8610DDECC
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 16:28:50 +1000 (EST)
Date: Thu, 26 Jul 2007 01:28:20 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'fixes-2.6.23' branch
Message-ID: <Pine.LNX.4.64.0707260127310.30790@blarg.am.freescale.net>
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

Please pull from 'fixes-2.6.23' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git fixes-2.6.23

to receive the following updates:

 arch/powerpc/Kconfig.debug            |    2 +-
 arch/powerpc/boot/dts/mpc7448hpc2.dts |    2 +-
 arch/powerpc/boot/dts/mpc8544ds.dts   |    8 ++++++++
 arch/powerpc/boot/dts/mpc8568mds.dts  |    6 ++++++
 arch/powerpc/kernel/irq.c             |    8 ++++----
 arch/powerpc/kernel/pci-common.c      |    2 +-
 arch/powerpc/kernel/pci_32.c          |   20 +++++++++++++++++++-
 arch/powerpc/kernel/process.c         |    4 ++++
 arch/powerpc/kernel/udbg.c            |    2 +-
 arch/powerpc/sysdev/fsl_pci.c         |    4 ++--
 arch/powerpc/sysdev/indirect_pci.c    |    1 +
 11 files changed, 48 insertions(+), 11 deletions(-)

Kumar Gala (6):
      [POWERPC] Fix PCI indirect for big-endian cfg_addr
      [POWERPC] Don't try to allocate resources for a Freescale POWERPC PHB
      [POWERPC] Fix ethernet PHY support on MPC8544 DS
      [POWREPC] Fixup a number of modpost warnings on ppc32
      [POWERPC] Only allow building of BootX text support on PPC_MULTIPLATFORM
      [POWERPC] Fix register labels on show_regs() message for 4xx/Book-E

Roy Zang (2):
      [POWERPC] Fix mpc7448hpc2 tsi108 device_type bug
      [POWERPC] Fix the ability to reset on MPC8544 DS and MPC8568 MDS boards
