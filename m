Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5877DDE05
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 15:08:25 +1000 (EST)
Date: Thu, 1 May 2008 00:04:08 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'powerpc-next' branch
Message-ID: <Pine.LNX.4.64.0805010003510.8224@blarg.am.freescale.net>
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

 arch/powerpc/boot/dts/mpc8610_hpcd.dts |   23 ++++++++++++++++++++++-
 arch/powerpc/kernel/head_booke.h       |    2 +-
 arch/powerpc/sysdev/fsl_rio.c          |    9 +++++++--
 include/asm-powerpc/ptrace.h           |    1 +
 include/linux/rio.h                    |    2 ++
 5 files changed, 33 insertions(+), 4 deletions(-)

Anton Vorontsov (1):
      [POWERPC] 86xx: mpc8610_hpcd: add support for PCI Express x8 slot

Jason Jin (1):
      [POWERPC] 86xx: Fix the wrong serial1 interrupt for 8610 board

Kumar Gala (1):
      [POWERPC] Set lower flag bits in regs->trap to indicate debug level exception

Randy Dunlap (1):
      [RAPIDIO] fix current kernel-doc notation
